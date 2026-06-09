CREATE TRIGGER tg_acionar_remocao_dependencia
BEFORE DELETE
ON usuario
FOR EACH ROW
EXECUTE FUNCTION fu_intermediaria_delete()

CREATE OR REPLACE FUNCTION fu_intermediaria_delete()
RETURNS TRIGGER AS $$
BEGIN
	CALL pr_remover_dependencia_usuario(OLD.id);
	RETURN OLD;
END;
$$ LANGUAGE plpgsql;
