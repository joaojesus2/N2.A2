CREATE MATERIALIZED VIEW  AS
SELECT
    nome,
    visualizar_edital,
    gerenciar_anexo_edital,
    gerenciar_status,
    add_edital_manual,
    gerenciar_grupo_edital,
    gerenciar_analise_edital,
    visualizar_historico_analise_edital,
    realiza_preanalise_tec,
    gerenciar_etapas_edital,
    realizar_proposta,
    gerenciar_historico_analise,
    gerenciar_consulta,
    adm
FROM grupo;
