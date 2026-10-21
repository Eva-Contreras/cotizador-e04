defmodule Cotizador do
  @tipos [:general, :refrigerada, :peligrosa, :sobredimensionada]

  def cotizar(embarque, reglas) do
    with :ok <- validar(embarque, reglas) do
      {:ok, calcular(embarque, reglas)}
    end
  end

  def resumen(embarques, reglas) do
    resumen =
      embarques
      |> Enum.map(fn embarque -> {embarque, cotizar(embarque, reglas)} end)
      |> Enum.reduce(
        %{
          cotizados: 0,
          rechazados: [],
          totales: [],
          por_puente: %{comercio_mundial: 0, colombia: 0}
        },
        fn
          {embarque, {:ok, cotizacion}}, acumulado ->
            %{
              acumulado
              | cotizados: acumulado.cotizados + 1,
                totales: [cotizacion.total | acumulado.totales],
                por_puente:
                  Map.update!(
                    acumulado.por_puente,
                    embarque.puente,
                    &(&1 + cotizacion.total)
                  )
            }

          {embarque, {:error, motivo}}, acumulado ->
            %{
              acumulado
              | rechazados: [{embarque.id, motivo} | acumulado.rechazados]
            }
        end
      )

    %{
      cotizados: resumen.cotizados,
      rechazados: Enum.reverse(resumen.rechazados),
      total: sumar_totales(resumen.totales),
      por_puente: resumen.por_puente
    }
  end

  defp sumar_totales([]), do: 0
  defp sumar_totales([total | restantes]), do: total + sumar_totales(restantes)

  defp validar(%{peso_kg: p}, _reglas) when p <= 0,
    do: {:error, :peso_invalido}

  defp validar(%{distancia_km: d}, _reglas) when d <= 0,
    do: {:error, :distancia_invalida}

  defp validar(%{tipo: tipo}, _reglas) when tipo not in @tipos,
    do: {:error, :tipo_desconocido}

  defp validar(
         %{puente: puente},
         %{cuota_puente: cuotas}
       )
       when not is_map_key(cuotas, puente),
       do: {:error, :puente_desconocido}

  defp validar(%{tipo: :peligrosa, numero_un: nil}, _reglas),
    do: {:error, :falta_numero_un}

  defp validar(%{tipo: :sobredimensionada, permiso: nil}, _reglas),
    do: {:error, :falta_permiso}

  defp validar(%{tipo: :sobredimensionada}, _reglas), do: :ok

  defp validar(
         %{peso_kg: peso},
         %{peso_maximo_kg: maximo}
       )
       when peso > maximo,
       do: {:error, :excede_peso_maximo}

  defp validar(_embarque, _reglas), do: :ok

  defp calcular(embarque, reglas) do
    flete_bruto = embarque.distancia_km * reglas.tarifa_km

    descuento =
      calcular_descuento(embarque.peso_kg, flete_bruto, reglas.descuento)

    flete = flete_bruto - descuento
    cuota_puente = Map.fetch!(reglas.cuota_puente, embarque.puente)
    recargo_config = Map.fetch!(reglas.recargo, embarque.tipo)
    base = base_recargo(reglas.base_recargo, flete, cuota_puente)
    recargo = pct(base, recargo_config.pct) + recargo_config.fija
    subtotal = flete + cuota_puente + recargo
    total = max(subtotal, reglas.minimo)

    %{
      id: embarque.id,
      flete_bruto: flete_bruto,
      descuento: descuento,
      flete: flete,
      cuota_puente: cuota_puente,
      recargo: recargo,
      ajuste_minimo: total - subtotal,
      total: total
    }
  end

  defp base_recargo(:flete, flete, _cuota_puente), do: flete

  defp base_recargo(:subtotal, flete, cuota_puente),
    do: flete + cuota_puente

  defp calcular_descuento(peso, flete_bruto, %{
         criterio: :a_partir_de,
         umbral_kg: umbral,
         pct: porcentaje
       })
       when peso >= umbral,
       do: pct(flete_bruto, porcentaje)

  defp calcular_descuento(_peso, _flete_bruto, %{criterio: :a_partir_de}), do: 0

  defp calcular_descuento(peso, flete_bruto, %{
         criterio: :mas_de,
         umbral_kg: umbral,
         pct: porcentaje
       })
       when peso > umbral,
       do: pct(flete_bruto, porcentaje)

  defp calcular_descuento(_peso, _flete_bruto, %{criterio: :mas_de}), do: 0

  defp pct(monto, porcentaje), do: div(monto * porcentaje + 50, 100)
end
