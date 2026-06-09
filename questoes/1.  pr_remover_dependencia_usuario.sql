CREATE OR REPLACE PROCEDURE pr_remover_dependencia_usuario(identificador INT)
LANGUAGE PLPGSQL AS $$
BEGIN
	DELETE FROM usuario_papel WHERE id_usuario = identificador;
	DELETE FROM usuario_grupo WHERE id_usuario = identificador;
END;
$$
