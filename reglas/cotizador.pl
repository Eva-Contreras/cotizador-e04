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

calcular(_, cotizacion(0, 0, 0, 0, 0, 0, 0)).
