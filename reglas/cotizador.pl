:- consult(variante).

% rechazo(+Embarque, -Motivo): una clausula por motivo, en el orden del enunciado
% calcular(+Embarque, -Cotizacion)

cotizar(E, error(Id, Motivo)) :- E = embarque(Id, _, _, _, _, _, _), once(rechazo(E, Motivo)), !.
cotizar(E, ok(Id, C)) :- E = embarque(Id, _, _, _, _, _, _), \+ rechazo(E, _), calcular(E, C).

rechazo(embarque(_, Peso, _, _, _, _, _), peso_invalido) :- Peso =< 0.
rechazo(embarque(_, _, Dist, _, _, _, _), distancia_invalida) :- Dist =< 0.
rechazo(embarque(_, _, _, Tipo, _, _, _), tipo_desconocido) :- \+ recargo(Tipo, _, _).
rechazo(embarque(_, _, _, _, Puente, _, _), puente_desconocido) :- \+ cuota_puente(Puente, _).
rechazo(embarque(_, _, _, peligrosa, _, none, _), falta_numero_un).
rechazo(embarque(_, _, _, sobredimensionada, _, _, none), falta_permiso).
rechazo(embarque(_, Peso, _, Tipo, _, _, _), excede_peso_maximo) :- Tipo \== sobredimensionada, peso_maximo(Max), Peso > Max.

pct(Monto, P, R) :- R is (Monto * P + 50) // 100.

aplica_descuento(Peso) :- descuento(Umbral, _, a_partir_de), Peso >= Umbral.
aplica_descuento(Peso) :- descuento(Umbral, _, mas_de), Peso > Umbral.

monto_descuento(Peso, Bruto, D) :- aplica_descuento(Peso), !, descuento(_, P, _), pct(Bruto, P, D).
monto_descuento(_, _, 0).

base_para_recargo(flete, Flete, _, Flete).
base_para_recargo(subtotal, Flete, Cuota, Base) :- Base is Flete + Cuota.

calcular(embarque(_, Peso, Dist, Tipo, Puente, _, _), cotizacion(Bruto, Desc, Flete, Cuota, Recargo, Ajuste, Total)) :-
    tarifa_km(Tarifa),
    Bruto is Dist * Tarifa,
    monto_descuento(Peso, Bruto, Desc),
    Flete is Bruto - Desc,
    cuota_puente(Puente, Cuota),
    base_recargo(Criterio),
    base_para_recargo(Criterio, Flete, Cuota, Base),
    recargo(Tipo, Porcentaje, Fija),
    pct(Base, Porcentaje, PorcentajeRecargo),
    Recargo is PorcentajeRecargo + Fija,
    Calculado is Flete + Cuota + Recargo,
    minimo(Minimo),
    Total is max(Calculado, Minimo),
    Ajuste is Total - Calculado.

resumen(Embarques, Resumen) :- resumir(Embarques, Resumen).

resumir([], resumen(0, [], 0, [comercio_mundial-0, colombia-0])).
resumir([Embarque | Resto], Resumen) :-
    cotizar(Embarque, Resultado),
    resumir(Resto, ResumenResto),
    agregar_resultado(Embarque, Resultado, ResumenResto, Resumen).

agregar_resultado(_, error(Id, Motivo),
                  resumen(N, Rechazados, Total, Puentes),
                  resumen(N, [Id-Motivo | Rechazados], Total, Puentes)) :- !.

agregar_resultado(embarque(_, _, _, _, comercio_mundial, _, _),
                  ok(_, cotizacion(_, _, _, _, _, _, Monto)),
                  resumen(N0, Rechazados, Total0, [comercio_mundial-C0, colombia-D]),
                  resumen(N, Rechazados, Total, [comercio_mundial-C, colombia-D])) :- !, N is N0 + 1, Total is Total0 + Monto, C is C0 + Monto.

agregar_resultado(embarque(_, _, _, _, colombia, _, _),
                  ok(_, cotizacion(_, _, _, _, _, _, Monto)),
                  resumen(N0, Rechazados, Total0, [comercio_mundial-C, colombia-D0]),
                  resumen(N, Rechazados, Total, [comercio_mundial-C, colombia-D])) :- !, N is N0 + 1, Total is Total0 + Monto, D is D0 + Monto.