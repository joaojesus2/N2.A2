CREATE MATERIALIZED VIEW o AS
SELECT
	g.nome,
	(visualizar_edital::int +
    gerenciar_anexo_edital::int +
    gerenciar_status::int +
    add_edital_manual::int +
    gerenciar_grupo_edital::int +
    gerenciar_analise_edital::int +
    visualizar_historico_analise_edital::int +
    realiza_preanalise_tec::int +
    gerenciar_etapas_edital::int +
    realizar_proposta::int +
    gerenciar_historico_analise::int +
    gerenciar_consulta::int +
    adm::int) AS permissoes,
	COUNT(ug.id_usuario) AS usuarios
FROM grupo g
LEFT JOIN usuario_grupo ug ON ug.id_grupo = id
GROUP BY     
	g.id,
    g.nome
