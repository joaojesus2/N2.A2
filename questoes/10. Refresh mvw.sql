Com a extensão pg_cron

SELECT cron.schedule(
    'refresh_mv_2h',
    '0 */2 * * *',
    'REFRESH MATERIALIZED VIEW vmw_consulta_permissoes_grupo'
)

Com pgAgent
1 - Criar um job
2 - Adicionar o step:
  REFRESH MATERIALIZED VIEW  vmw_consulta_grupo;
