
export type Puente = 'comercio_mundial' | 'colombia';

export type Carga =
  | { tipo: 'general' }
  | { tipo: 'refrigerada' }
  | { tipo: 'peligrosa'; numeroUn: string }
  | { tipo: 'sobredimensionada'; permiso: string };

export type Datos = {
  id: string;
  pesoKg: number;
  distanciaKm: number;
  puente: Puente;
};

export type Embarque = Datos & Carga;

export type Borrador = {
  estado: 'borrador';
  embarque: Embarque;
};

export type Cotizacion = {
  id: string;
  fleteBruto: number;
  descuento: number;
  flete: number;
  cuotaPuente: number;
  recargo: number;
  ajusteMinimo: number;
  total: number;
};

export type Cotizado = {
  estado: 'cotizado';
  embarque: Embarque;
  cotizacion: Cotizacion;
};

export type Motivo =
  | 'peso_invalido'
  | 'distancia_invalida'
  | 'excede_peso_maximo';

export type Rechazado = {
  estado: 'rechazado';
  embarque: Embarque;
  motivo: Motivo;
};

export type Despachado = {
  estado: 'despachado';
  embarque: Embarque;
  cotizacion: Cotizacion;
  folio: string;
};

export type Estado = Borrador | Cotizado | Rechazado | Despachado;

export type Resultado<T, E> =
  | { ok: true; valor: T }
  | { ok: false; error: E };

export type Reglas = {
  tarifaKm: number;
  cuotaPuente: Record<Puente, number>;
  descuento: {
    umbralKg: number;
    pct: number;
    criterio: 'a_partir_de' | 'mas_de';
  };
  recargo: Record<Carga['tipo'], { pct: number; fija: number }>;
  baseRecargo: 'flete' | 'subtotal';
  minimo: number;
  pesoMaximoKg: number;
};

export function cotizar(
  b: Borrador,
  r: Reglas,
): Cotizado | Rechazado {
  const e = b.embarque;

  if (e.pesoKg <= 0) {
    return { estado: 'rechazado', embarque: e, motivo: 'peso_invalido' };
  }

  if (e.distanciaKm < 0) {
    return {
      estado: 'rechazado',
      embarque: e,
      motivo: 'distancia_invalida',
    };
  }

  if (
    e.pesoKg > r.pesoMaximoKg &&
    e.tipo !== 'sobredimensionada'
  ) {
    return {
      estado: 'rechazado',
      embarque: e,
      motivo: 'excede_peso_maximo',
    };
  }

  const fleteBruto = e.distanciaKm * r.tarifaKm;

  const aplicaDescuento =
    r.descuento.criterio === 'a_partir_de'
      ? e.pesoKg >= r.descuento.umbralKg
      : e.pesoKg > r.descuento.umbralKg;

  const descuento = aplicaDescuento
    ? Math.floor((fleteBruto * r.descuento.pct + 50) / 100)
    : 0;

  const flete = fleteBruto - descuento;
  const cuotaPuente = r.cuotaPuente[e.puente];
  const reglaRecargo = r.recargo[e.tipo];

  const baseRecargo =
    r.baseRecargo === 'flete'
      ? flete
      : flete + cuotaPuente;

  const recargo = Math.floor(
    (baseRecargo * reglaRecargo.pct + 50) / 100,
  ) + reglaRecargo.fija;

  const subtotal = flete + cuotaPuente + recargo;
  const ajusteMinimo = Math.max(0, r.minimo - subtotal);

  const cotizacion: Cotizacion = {
    id: e.id,
    fleteBruto,
    descuento,
    flete,
    cuotaPuente,
    recargo,
    ajusteMinimo,
    total: subtotal + ajusteMinimo,
  };

  return {
    estado: 'cotizado',
    embarque: e,
    cotizacion,
  };
}

export function despachar(
  _c: Cotizado,
  _folio: string,
): Despachado {
  throw new Error('por implementar');
}
