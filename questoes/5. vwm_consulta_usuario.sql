CREATE MATERIALIZED VIEW  AS
SELECT
    CASE
        WHEN u.nome IS NULL THEN '-'
        ELSE u.nome
    END AS nome,
	u.email AS email,
	STRING_AGG(g.nome,', ') AS grupo,
	CASE
        WHEN STRING_AGG(p.nome,', ') IS NULL THEN '-'
        ELSE STRING_AGG(p.nome,', ')
    END AS papel
FROM usuario u
INNER JOIN usuario_grupo ug ON ug.id_usuario = u.id
INNER JOIN grupo g ON g.id = ug.id_grupo
LEFT JOIN usuario_papel up ON up.id_usuario = u.id
LEFT JOIN papel p ON up.id_papel = p.id

GROUP BY 
	u.id,
	u.nome,
	u.email

ORDER BY u.nome
