--
-- Name: grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.grupo (
    id integer NOT NULL,
    nome character varying(30) NOT NULL,
    visualizar_edital boolean DEFAULT false,
    gerenciar_anexo_edital boolean DEFAULT false,
    gerenciar_status boolean DEFAULT false,
    add_edital_manual boolean DEFAULT false,
    gerenciar_grupo_edital boolean DEFAULT false,
    gerenciar_analise_edital boolean DEFAULT false,
    visualizar_historico_analise_edital boolean DEFAULT false,
    realiza_preanalise_tec boolean DEFAULT false,
    gerenciar_etapas_edital boolean DEFAULT false,
    realizar_proposta boolean DEFAULT false,
    gerenciar_historico_analise boolean DEFAULT false,
    gerenciar_consulta boolean DEFAULT false,
    adm boolean DEFAULT false
);


ALTER TABLE public.grupo OWNER TO postgres;

--
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
    id integer NOT NULL,
    nome character varying(30),
    email character varying(30) NOT NULL,
    ultimo_acesso timestamp without time zone
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- Name: usuario_grupo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_grupo (
    id_usuario integer NOT NULL,
    id_grupo integer NOT NULL
);


ALTER TABLE public.usuario_grupo OWNER TO postgres;

--
-- Name: grupo_do_usuario; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.grupo_do_usuario AS
 SELECT u.nome,
    string_agg((g.nome)::text, ', '::text) AS string_agg
   FROM ((public.usuario_grupo ug
     JOIN public.usuario u ON ((u.id = ug.id_usuario)))
     JOIN public.grupo g ON ((g.id = ug.id_grupo)))
  GROUP BY u.nome;


ALTER VIEW public.grupo_do_usuario OWNER TO postgres;

--
-- Name: grupo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.grupo ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.grupo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: papel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.papel (
    id integer NOT NULL,
    nome character varying(40) NOT NULL
);


ALTER TABLE public.papel OWNER TO postgres;

--
-- Name: papel_do_usuario; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.papel_do_usuario AS
SELECT
    NULL::character varying(30) AS nome,
    NULL::text AS grupo;


ALTER VIEW public.papel_do_usuario OWNER TO postgres;

--
-- Name: papel_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.papel ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.papel_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: usuario_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.usuario ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.usuario_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: usuario_papel; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_papel (
    id_usuario integer NOT NULL,
    id_papel integer NOT NULL
);


ALTER TABLE public.usuario_papel OWNER TO postgres;

--
-- Name: grupo grupo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.grupo
    ADD CONSTRAINT grupo_pkey PRIMARY KEY (id);


--
-- Name: usuario_grupo id_usuario_grupo; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_grupo
    ADD CONSTRAINT id_usuario_grupo PRIMARY KEY (id_usuario, id_grupo);


--
-- Name: usuario_papel id_usuario_papel; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_papel
    ADD CONSTRAINT id_usuario_papel PRIMARY KEY (id_usuario, id_papel);


--
-- Name: papel papel_nome_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.papel
    ADD CONSTRAINT papel_nome_key UNIQUE (nome);


--
-- Name: papel papel_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.papel
    ADD CONSTRAINT papel_pkey PRIMARY KEY (id);


--
-- Name: usuario usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- Name: papel_do_usuario _RETURN; Type: RULE; Schema: public; Owner: postgres
--

CREATE OR REPLACE VIEW public.papel_do_usuario AS
 SELECT u.nome,
    string_agg((p.nome)::text, ', '::text) AS grupo
   FROM ((public.usuario_papel up
     JOIN public.usuario u ON ((up.id_usuario = u.id)))
     JOIN public.papel p ON ((up.id_papel = p.id)))
  GROUP BY u.id;


--
-- Name: usuario_grupo usuario_grupo_id_grupo_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_grupo
    ADD CONSTRAINT usuario_grupo_id_grupo_fkey FOREIGN KEY (id_grupo) REFERENCES public.grupo(id);


--
-- Name: usuario_grupo usuario_grupo_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_grupo
    ADD CONSTRAINT usuario_grupo_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- Name: usuario_papel usuario_papel_id_papel_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_papel
    ADD CONSTRAINT usuario_papel_id_papel_fkey FOREIGN KEY (id_papel) REFERENCES public.papel(id);


--
-- Name: usuario_papel usuario_papel_id_usuario_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_papel
    ADD CONSTRAINT usuario_papel_id_usuario_fkey FOREIGN KEY (id_usuario) REFERENCES public.usuario(id);


--
-- PostgreSQL database dump complete
--
