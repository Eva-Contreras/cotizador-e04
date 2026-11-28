-- consulta 1
SELECT puente, COUNT(*), SUM(total_centavos)
FROM embarques
WHERE total_centavos IS NOT NULL
GROUP BY puente
ORDER BY puente;

-- consulta 2
SELECT id, motivo
FROM embarques
WHERE motivo IS NOT NULL
ORDER BY orden;

-- consulta 3
SELECT id
FROM embarques
WHERE tipo = 'peligrosa' AND numero_un IS NULL
ORDER BY orden;