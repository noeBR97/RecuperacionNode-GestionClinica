--
-- PostgreSQL database dump
--

\restrict GYfJlNQZ4a0YxOmwb786FWrerxywQ5KGeQWOfV7uWA0tlgrNizbZJyVnjv84vWS

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: enum_citas_estado; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_citas_estado AS ENUM (
    'pendiente',
    'en curso',
    'finalizada',
    'cancelada'
);


ALTER TYPE public.enum_citas_estado OWNER TO postgres;

--
-- Name: enum_usuarios_rol; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public.enum_usuarios_rol AS ENUM (
    'admin',
    'medico',
    'recepcionista'
);


ALTER TYPE public.enum_usuarios_rol OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: citas; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.citas (
    id integer NOT NULL,
    fecha timestamp with time zone NOT NULL,
    motivo character varying(255) NOT NULL,
    estado public.enum_citas_estado DEFAULT 'pendiente'::public.enum_citas_estado NOT NULL,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL,
    "pacienteID" integer,
    "medicoID" integer
);


ALTER TABLE public.citas OWNER TO postgres;

--
-- Name: citas_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.citas_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.citas_id_seq OWNER TO postgres;

--
-- Name: citas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.citas_id_seq OWNED BY public.citas.id;


--
-- Name: pacientes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pacientes (
    id integer NOT NULL,
    dni character varying(255) NOT NULL,
    nombre character varying(255) NOT NULL,
    apellido1 character varying(255) NOT NULL,
    apellido2 character varying(255),
    telefono character varying(255),
    fecha_nacimiento date,
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.pacientes OWNER TO postgres;

--
-- Name: pacientes_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.pacientes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pacientes_id_seq OWNER TO postgres;

--
-- Name: pacientes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.pacientes_id_seq OWNED BY public.pacientes.id;


--
-- Name: usuarios; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuarios (
    id integer NOT NULL,
    nombre character varying(255) NOT NULL,
    apellido1 character varying(255) NOT NULL,
    apellido2 character varying(255),
    email character varying(255) NOT NULL,
    clave character varying(255) NOT NULL,
    rol public.enum_usuarios_rol DEFAULT 'recepcionista'::public.enum_usuarios_rol NOT NULL,
    tfno character varying(255),
    "createdAt" timestamp with time zone NOT NULL,
    "updatedAt" timestamp with time zone NOT NULL
);


ALTER TABLE public.usuarios OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.usuarios_id_seq OWNER TO postgres;

--
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.usuarios_id_seq OWNED BY public.usuarios.id;


--
-- Name: citas id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas ALTER COLUMN id SET DEFAULT nextval('public.citas_id_seq'::regclass);


--
-- Name: pacientes id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes ALTER COLUMN id SET DEFAULT nextval('public.pacientes_id_seq'::regclass);


--
-- Name: usuarios id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios ALTER COLUMN id SET DEFAULT nextval('public.usuarios_id_seq'::regclass);


--
-- Data for Name: citas; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.citas (id, fecha, motivo, estado, "createdAt", "updatedAt", "pacienteID", "medicoID") FROM stdin;
6	2026-05-30 10:47:00+02	resfriado común	pendiente	2026-05-05 10:47:48.359+02	2026-05-05 10:47:48.359+02	2	7
7	2026-05-09 12:30:00+02	Dolor de espalda	pendiente	2026-05-05 10:49:31.811+02	2026-05-05 10:49:31.811+02	40	9
8	2026-05-20 09:15:00+02	Migrañas	pendiente	2026-05-05 11:00:02.618+02	2026-05-05 11:00:02.618+02	33	7
\.


--
-- Data for Name: pacientes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.pacientes (id, dni, nombre, apellido1, apellido2, telefono, fecha_nacimiento, "createdAt", "updatedAt") FROM stdin;
2	12345678Z	Javier	García	Rodríguez	600123456	1985-10-25	2026-04-29 11:17:48.74+02	2026-04-29 11:17:48.74+02
33	76848694B	Mercedes	Jáquez	Nájera	972-243-347	1950-06-25	2026-04-30 11:35:18.608+02	2026-04-30 11:35:18.608+02
34	97849566I	Laura	Villa	Estévez	990 199 165	1980-03-30	2026-04-30 11:35:18.608+02	2026-04-30 11:35:18.608+02
35	97914473O	José Luis	Mojica	Barreto	918.686.478	1989-02-11	2026-04-30 11:35:18.608+02	2026-04-30 11:35:18.608+02
36	55369946N	Ana Luisa	Gálvez	Benítez	926.138.086	2025-10-18	2026-04-30 11:35:18.608+02	2026-04-30 11:35:18.608+02
37	29320653V	Manuela	Fajardo	Núñez	929 273 645	2015-01-14	2026-04-30 11:35:18.608+02	2026-04-30 11:35:18.608+02
38	08959618L	Raquel	Ballesteros	Castillo	970-464-395	1933-11-23	2026-04-30 11:35:18.608+02	2026-04-30 11:35:18.608+02
39	63009182T	Conchita	de	Toro	967 107 558	2000-04-28	2026-04-30 11:35:18.608+02	2026-04-30 11:35:18.608+02
40	14108477E	Bernardo	Paz	Carrero	921.965.080	1954-06-15	2026-04-30 11:35:18.608+02	2026-04-30 11:35:18.608+02
41	72277404O	Ángel	Cardona	Delatorre	935385931	2025-09-14	2026-04-30 11:35:18.608+02	2026-04-30 11:35:18.608+02
42	34237050Q	Salvador	Cabrera	Padrón	943-848-051	2005-12-12	2026-04-30 11:35:18.608+02	2026-04-30 11:35:18.608+02
43	52775218A	Mercedes	Osorio	Moreno	930 752 857	2002-02-11	2026-04-30 13:04:55.52+02	2026-04-30 13:04:55.52+02
44	52611248S	Javier	Negrón	Arriaga	936792275	1967-01-29	2026-04-30 13:04:55.52+02	2026-04-30 13:04:55.52+02
45	14255541J	Alfonso	Casares	Macías	910987377	1947-04-14	2026-04-30 13:04:55.52+02	2026-04-30 13:04:55.52+02
46	19139019X	Mateo	Cervántez	Casillas	929527306	1999-12-09	2026-04-30 13:04:55.52+02	2026-04-30 13:04:55.52+02
47	73704341V	Carlos	Ruelas	Tovar	905.471.314	1960-10-11	2026-04-30 13:04:55.52+02	2026-04-30 13:04:55.52+02
48	89733496M	Alfredo	Delapaz	Mercado	933.105.602	1960-12-12	2026-04-30 13:04:55.52+02	2026-04-30 13:04:55.52+02
49	65435933T	Gloria	Raya	Fonseca	952.845.978	1970-12-14	2026-04-30 13:04:55.52+02	2026-04-30 13:04:55.52+02
50	41757891C	Manuel	Bravo	Bañuelos	932 209 953	1949-11-04	2026-04-30 13:04:55.52+02	2026-04-30 13:04:55.52+02
51	42640414E	Anita	Delao	Viera	982 722 494	1989-01-08	2026-04-30 13:04:55.52+02	2026-04-30 13:04:55.52+02
52	34155851K	Manuel	Godínez	Saavedra	914 564 448	1937-12-13	2026-04-30 13:04:55.52+02	2026-04-30 13:04:55.52+02
53	12345678X	Carlos	García	Pérez	600123456	1990-05-15	2026-05-04 11:04:29.103+02	2026-05-04 11:04:29.103+02
54	29560262O	Ana	Pichardo	Valencia	949 673 929	2014-06-17	2026-05-05 10:00:39.661+02	2026-05-05 10:00:39.661+02
55	10128098G	Miguel	de	Montes	912 932 467	1960-06-18	2026-05-05 10:00:39.661+02	2026-05-05 10:00:39.661+02
56	67250693O	Timoteo	Mercado	Lucio	910-104-276	1968-11-07	2026-05-05 10:00:39.661+02	2026-05-05 10:00:39.661+02
57	52721634D	Javier	Verduzco	Perales	971.968.580	1944-08-11	2026-05-05 10:00:39.661+02	2026-05-05 10:00:39.661+02
58	29841596H	Dolores	Tirado	Espino	994.086.779	1990-04-21	2026-05-05 10:00:39.661+02	2026-05-05 10:00:39.661+02
\.


--
-- Data for Name: usuarios; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.usuarios (id, nombre, apellido1, apellido2, email, clave, rol, tfno, "createdAt", "updatedAt") FROM stdin;
6	Administrador	de Prueba	\N	admin@admin.com	$2b$10$tHm6beM5iECaOwkJC8Pu4eiu2N1SRCFeL3nfeX331unko0EqfqIJa	admin	123456789	2026-05-05 10:44:47.542+02	2026-05-05 10:44:47.542+02
7	Médico	de Prueba	\N	medico@app.com	$2b$10$FO9sx0t1BZNZ3cM6ll1Uauo0KfrK4ntprwI5rchvIgMOTcvoTnu42	medico	123456789	2026-05-05 10:46:11.42+02	2026-05-05 10:46:11.42+02
8	Recepcionista	de Prueba	\N	recepcionista@app.com	$2b$10$I..umKm0ik/qHYVfT0esW.T7nfuhGxtfczW8c.bEvhhV2O4qJ4chq	recepcionista	123456789	2026-05-05 10:46:49.25+02	2026-05-05 10:46:49.25+02
9	Médico	de Prueba 2	\N	medico2@app.com	$2b$10$X0kqpzRhCVQJvneHIaE78.wzowNG781B2SZ648cekkKs82bw0ib9m	medico	123456789	2026-05-05 10:48:57.769+02	2026-05-05 10:48:57.769+02
\.


--
-- Name: citas_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.citas_id_seq', 8, true);


--
-- Name: pacientes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.pacientes_id_seq', 58, true);


--
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.usuarios_id_seq', 9, true);


--
-- Name: citas citas_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT citas_pkey PRIMARY KEY (id);


--
-- Name: pacientes pacientes_dni_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key1 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key10 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key100 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key101 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key102 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key103 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key104 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key105 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key106 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key107 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key108 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key109 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key11 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key110; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key110 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key111; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key111 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key112; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key112 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key113; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key113 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key114; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key114 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key115; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key115 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key116; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key116 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key117; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key117 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key118; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key118 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key119; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key119 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key12 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key120; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key120 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key121; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key121 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key122; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key122 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key123; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key123 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key124; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key124 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key125; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key125 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key126; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key126 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key127; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key127 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key128; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key128 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key129; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key129 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key13 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key130; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key130 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key131; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key131 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key132; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key132 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key133; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key133 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key134; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key134 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key135; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key135 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key136; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key136 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key137; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key137 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key138; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key138 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key139; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key139 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key14 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key140; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key140 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key141; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key141 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key142; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key142 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key143; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key143 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key144; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key144 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key145; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key145 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key146; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key146 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key147; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key147 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key148; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key148 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key149; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key149 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key15 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key150; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key150 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key151; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key151 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key152; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key152 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key153; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key153 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key154; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key154 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key155; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key155 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key156; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key156 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key157; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key157 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key158; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key158 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key159; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key159 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key16 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key160; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key160 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key161; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key161 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key162; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key162 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key163; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key163 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key164; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key164 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key165; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key165 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key166; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key166 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key167; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key167 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key168; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key168 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key169; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key169 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key17 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key170; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key170 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key171; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key171 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key172; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key172 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key173; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key173 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key174; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key174 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key175; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key175 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key176; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key176 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key177; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key177 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key178; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key178 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key179; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key179 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key18 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key180; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key180 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key181; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key181 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key182; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key182 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key183; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key183 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key184; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key184 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key185; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key185 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key186; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key186 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key187; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key187 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key188; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key188 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key189; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key189 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key19 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key190; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key190 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key191; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key191 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key192; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key192 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key193; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key193 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key194; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key194 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key195; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key195 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key196; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key196 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key197; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key197 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key198; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key198 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key199; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key199 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key2 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key20 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key200; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key200 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key201; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key201 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key202; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key202 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key203; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key203 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key204; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key204 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key205; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key205 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key206; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key206 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key207; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key207 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key208; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key208 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key209; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key209 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key21 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key210; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key210 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key211; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key211 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key212; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key212 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key213; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key213 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key214; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key214 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key215; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key215 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key216; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key216 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key217; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key217 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key218; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key218 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key219; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key219 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key22 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key220; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key220 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key221; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key221 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key222; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key222 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key223; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key223 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key224; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key224 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key225; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key225 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key226; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key226 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key227; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key227 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key228; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key228 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key229; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key229 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key23 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key230; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key230 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key231; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key231 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key232; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key232 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key233; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key233 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key234; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key234 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key235; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key235 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key236; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key236 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key237; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key237 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key238; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key238 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key239; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key239 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key24 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key240; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key240 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key241; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key241 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key242; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key242 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key243; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key243 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key244; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key244 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key245; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key245 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key246; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key246 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key247; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key247 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key248; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key248 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key249; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key249 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key25 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key250; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key250 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key251; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key251 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key252; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key252 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key253; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key253 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key254; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key254 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key255; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key255 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key256; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key256 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key257; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key257 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key258; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key258 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key259; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key259 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key26 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key260; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key260 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key261; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key261 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key262; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key262 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key263; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key263 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key264; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key264 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key265; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key265 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key266; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key266 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key267; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key267 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key268; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key268 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key269; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key269 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key27 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key270; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key270 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key271; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key271 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key272; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key272 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key273; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key273 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key274; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key274 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key275; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key275 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key276; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key276 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key277; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key277 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key278; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key278 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key279; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key279 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key28 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key280; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key280 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key281; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key281 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key282; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key282 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key283; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key283 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key284; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key284 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key285; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key285 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key286; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key286 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key287; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key287 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key288; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key288 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key289; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key289 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key29 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key290; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key290 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key291; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key291 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key292; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key292 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key293; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key293 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key294; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key294 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key295; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key295 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key296; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key296 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key297; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key297 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key298; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key298 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key299; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key299 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key3 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key30 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key300; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key300 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key301; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key301 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key302; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key302 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key303; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key303 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key304; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key304 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key305; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key305 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key306; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key306 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key307; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key307 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key308; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key308 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key309; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key309 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key31 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key310; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key310 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key311; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key311 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key312; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key312 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key313; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key313 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key314; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key314 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key315; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key315 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key316; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key316 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key317; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key317 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key318; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key318 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key319; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key319 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key32 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key320; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key320 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key321; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key321 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key322; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key322 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key323; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key323 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key324; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key324 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key325; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key325 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key326; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key326 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key327; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key327 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key328; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key328 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key329; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key329 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key33 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key330; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key330 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key331; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key331 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key332; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key332 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key333; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key333 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key334; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key334 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key335; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key335 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key336; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key336 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key337; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key337 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key338; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key338 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key339; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key339 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key34 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key340; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key340 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key341; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key341 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key342; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key342 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key343; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key343 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key344; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key344 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key345; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key345 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key346; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key346 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key347; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key347 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key348; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key348 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key349; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key349 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key35 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key350; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key350 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key351; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key351 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key352; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key352 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key353; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key353 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key354; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key354 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key355; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key355 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key356; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key356 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key357; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key357 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key358; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key358 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key359; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key359 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key36 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key360; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key360 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key361; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key361 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key362; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key362 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key363; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key363 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key364; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key364 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key365; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key365 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key366; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key366 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key367; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key367 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key368; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key368 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key369; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key369 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key37 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key370; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key370 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key371; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key371 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key372; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key372 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key373; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key373 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key374; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key374 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key375; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key375 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key376; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key376 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key377; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key377 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key378; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key378 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key379; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key379 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key38 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key380; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key380 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key381; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key381 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key382; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key382 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key383; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key383 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key384; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key384 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key385; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key385 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key386; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key386 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key387; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key387 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key388; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key388 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key389; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key389 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key39 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key390; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key390 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key391; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key391 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key392; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key392 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key393; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key393 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key394; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key394 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key395; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key395 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key396; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key396 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key397; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key397 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key398; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key398 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key399; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key399 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key4 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key40 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key400; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key400 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key401; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key401 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key402; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key402 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key403; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key403 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key404; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key404 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key405; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key405 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key406; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key406 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key407; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key407 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key408; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key408 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key409; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key409 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key41 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key410; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key410 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key411; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key411 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key412; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key412 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key413; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key413 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key414; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key414 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key415; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key415 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key416; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key416 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key417; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key417 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key418; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key418 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key419; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key419 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key42 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key420; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key420 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key421; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key421 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key422; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key422 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key423; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key423 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key424; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key424 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key425; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key425 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key426; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key426 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key427; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key427 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key428; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key428 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key429; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key429 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key43 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key430; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key430 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key431; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key431 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key432; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key432 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key433; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key433 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key434; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key434 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key435; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key435 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key436; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key436 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key437; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key437 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key438; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key438 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key439; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key439 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key44 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key440; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key440 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key441; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key441 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key442; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key442 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key443; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key443 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key444; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key444 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key445; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key445 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key446; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key446 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key447; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key447 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key448; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key448 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key449; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key449 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key45 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key450; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key450 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key451; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key451 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key452; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key452 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key453; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key453 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key454; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key454 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key455; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key455 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key456; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key456 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key457; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key457 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key458; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key458 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key459; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key459 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key46 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key460; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key460 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key461; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key461 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key462; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key462 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key463; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key463 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key464; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key464 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key465; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key465 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key466; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key466 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key467; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key467 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key468; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key468 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key469; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key469 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key47 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key470; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key470 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key471; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key471 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key472; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key472 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key473; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key473 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key474; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key474 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key475; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key475 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key476; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key476 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key477; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key477 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key478; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key478 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key479; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key479 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key48 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key480; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key480 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key481; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key481 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key482; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key482 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key483; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key483 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key484; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key484 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key485; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key485 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key486; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key486 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key487; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key487 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key488; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key488 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key489; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key489 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key49 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key490; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key490 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key491; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key491 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key492; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key492 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key493; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key493 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key494; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key494 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key495; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key495 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key496; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key496 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key497; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key497 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key498; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key498 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key499; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key499 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key5 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key50 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key500; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key500 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key501; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key501 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key502; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key502 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key503; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key503 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key504; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key504 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key505; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key505 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key506; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key506 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key507; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key507 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key508; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key508 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key509; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key509 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key51 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key510; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key510 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key511; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key511 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key512; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key512 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key513; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key513 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key514; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key514 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key515; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key515 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key516; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key516 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key517; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key517 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key518; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key518 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key519; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key519 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key52 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key520; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key520 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key521; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key521 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key522; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key522 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key523; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key523 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key524; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key524 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key525; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key525 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key526; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key526 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key527; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key527 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key528; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key528 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key529; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key529 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key53 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key530; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key530 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key531; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key531 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key532; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key532 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key533; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key533 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key534; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key534 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key535; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key535 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key536; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key536 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key537; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key537 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key538; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key538 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key539; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key539 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key54 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key540; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key540 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key541; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key541 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key542; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key542 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key543; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key543 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key544; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key544 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key545; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key545 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key546; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key546 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key547; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key547 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key548; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key548 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key549; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key549 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key55 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key550; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key550 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key551; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key551 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key552; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key552 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key553; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key553 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key554; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key554 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key555; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key555 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key556; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key556 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key557; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key557 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key558; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key558 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key559; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key559 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key56 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key560; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key560 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key561; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key561 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key562; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key562 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key563; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key563 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key564; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key564 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key565; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key565 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key566; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key566 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key567; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key567 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key568; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key568 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key569; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key569 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key57 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key570; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key570 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key571; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key571 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key572; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key572 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key573; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key573 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key574; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key574 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key575; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key575 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key576; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key576 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key577; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key577 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key578; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key578 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key579; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key579 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key58 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key580; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key580 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key581; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key581 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key582; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key582 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key583; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key583 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key584; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key584 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key585; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key585 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key586; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key586 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key587; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key587 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key588; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key588 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key589; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key589 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key59 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key590; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key590 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key591; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key591 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key592; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key592 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key593; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key593 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key594; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key594 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key595; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key595 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key596; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key596 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key597; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key597 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key598; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key598 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key599; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key599 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key6 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key60 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key600; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key600 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key601; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key601 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key602; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key602 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key603; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key603 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key604; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key604 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key605; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key605 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key606; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key606 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key607; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key607 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key608; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key608 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key609; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key609 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key61 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key610; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key610 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key611; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key611 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key612; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key612 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key613; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key613 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key614; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key614 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key615; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key615 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key616; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key616 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key617; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key617 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key618; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key618 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key619; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key619 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key62 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key620; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key620 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key621; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key621 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key622; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key622 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key623; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key623 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key624; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key624 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key625; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key625 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key626; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key626 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key627; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key627 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key628; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key628 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key629; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key629 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key63 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key630; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key630 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key631; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key631 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key632; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key632 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key633; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key633 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key634; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key634 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key635; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key635 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key636; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key636 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key637; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key637 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key638; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key638 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key639; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key639 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key64 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key640; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key640 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key641; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key641 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key642; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key642 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key643; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key643 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key644; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key644 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key645; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key645 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key646; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key646 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key647; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key647 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key648; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key648 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key649; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key649 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key65 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key650; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key650 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key651; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key651 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key652; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key652 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key653; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key653 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key654; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key654 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key66 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key67 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key68 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key69 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key7 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key70 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key71 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key72 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key73 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key74 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key75 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key76 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key77 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key78 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key79 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key8 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key80 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key81 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key82 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key83 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key84 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key85 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key86 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key87 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key88 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key89 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key9 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key90 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key91 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key92 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key93 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key94 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key95 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key96 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key97 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key98 UNIQUE (dni);


--
-- Name: pacientes pacientes_dni_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_dni_key99 UNIQUE (dni);


--
-- Name: pacientes pacientes_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pacientes
    ADD CONSTRAINT pacientes_pkey PRIMARY KEY (id);


--
-- Name: usuarios usuarios_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key UNIQUE (email);


--
-- Name: usuarios usuarios_email_key1; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key1 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key10; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key10 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key100; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key100 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key101; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key101 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key102; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key102 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key103; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key103 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key104; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key104 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key105; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key105 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key106; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key106 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key107; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key107 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key108; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key108 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key109; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key109 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key11; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key11 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key110; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key110 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key111; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key111 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key112; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key112 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key113; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key113 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key114; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key114 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key115; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key115 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key116; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key116 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key117; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key117 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key118; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key118 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key119; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key119 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key12; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key12 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key120; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key120 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key121; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key121 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key122; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key122 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key123; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key123 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key124; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key124 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key125; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key125 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key126; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key126 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key127; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key127 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key128; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key128 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key129; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key129 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key13; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key13 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key130; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key130 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key131; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key131 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key132; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key132 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key133; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key133 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key134; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key134 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key135; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key135 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key136; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key136 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key137; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key137 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key138; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key138 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key139; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key139 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key14; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key14 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key140; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key140 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key141; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key141 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key142; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key142 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key143; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key143 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key144; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key144 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key145; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key145 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key146; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key146 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key147; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key147 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key148; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key148 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key149; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key149 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key15; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key15 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key150; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key150 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key151; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key151 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key152; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key152 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key153; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key153 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key154; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key154 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key155; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key155 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key156; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key156 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key157; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key157 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key158; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key158 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key159; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key159 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key16; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key16 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key160; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key160 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key161; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key161 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key162; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key162 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key163; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key163 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key164; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key164 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key165; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key165 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key166; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key166 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key167; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key167 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key168; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key168 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key169; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key169 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key17; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key17 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key170; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key170 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key171; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key171 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key172; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key172 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key173; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key173 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key174; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key174 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key175; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key175 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key176; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key176 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key177; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key177 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key178; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key178 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key179; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key179 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key18; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key18 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key180; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key180 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key181; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key181 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key182; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key182 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key183; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key183 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key184; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key184 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key185; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key185 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key186; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key186 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key187; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key187 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key188; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key188 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key189; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key189 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key19; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key19 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key190; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key190 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key191; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key191 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key192; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key192 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key193; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key193 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key194; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key194 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key195; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key195 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key196; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key196 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key197; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key197 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key198; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key198 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key199; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key199 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key2 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key20; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key20 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key200; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key200 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key201; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key201 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key202; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key202 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key203; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key203 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key204; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key204 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key205; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key205 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key206; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key206 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key207; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key207 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key208; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key208 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key209; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key209 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key21; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key21 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key210; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key210 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key211; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key211 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key212; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key212 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key213; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key213 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key214; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key214 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key215; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key215 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key216; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key216 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key217; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key217 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key218; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key218 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key219; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key219 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key22; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key22 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key220; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key220 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key221; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key221 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key222; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key222 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key223; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key223 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key224; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key224 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key225; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key225 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key226; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key226 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key227; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key227 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key228; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key228 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key229; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key229 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key23; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key23 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key230; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key230 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key231; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key231 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key232; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key232 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key233; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key233 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key234; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key234 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key235; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key235 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key236; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key236 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key237; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key237 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key238; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key238 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key239; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key239 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key24; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key24 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key240; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key240 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key241; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key241 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key242; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key242 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key243; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key243 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key244; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key244 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key245; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key245 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key246; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key246 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key247; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key247 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key248; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key248 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key249; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key249 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key25; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key25 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key250; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key250 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key251; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key251 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key252; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key252 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key253; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key253 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key254; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key254 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key255; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key255 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key256; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key256 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key257; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key257 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key258; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key258 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key259; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key259 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key26; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key26 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key260; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key260 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key261; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key261 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key262; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key262 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key263; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key263 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key264; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key264 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key265; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key265 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key266; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key266 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key267; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key267 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key268; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key268 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key269; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key269 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key27; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key27 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key270; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key270 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key271; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key271 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key272; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key272 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key273; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key273 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key274; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key274 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key275; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key275 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key276; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key276 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key277; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key277 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key278; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key278 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key279; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key279 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key28; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key28 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key280; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key280 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key281; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key281 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key282; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key282 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key283; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key283 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key284; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key284 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key285; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key285 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key286; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key286 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key287; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key287 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key288; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key288 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key289; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key289 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key29; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key29 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key290; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key290 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key291; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key291 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key292; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key292 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key293; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key293 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key294; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key294 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key295; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key295 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key296; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key296 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key297; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key297 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key298; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key298 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key299; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key299 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key3 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key30; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key30 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key300; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key300 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key301; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key301 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key302; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key302 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key303; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key303 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key304; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key304 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key305; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key305 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key306; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key306 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key307; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key307 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key308; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key308 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key309; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key309 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key31; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key31 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key310; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key310 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key311; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key311 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key312; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key312 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key313; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key313 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key314; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key314 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key315; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key315 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key316; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key316 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key317; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key317 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key318; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key318 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key319; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key319 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key32; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key32 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key320; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key320 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key321; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key321 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key322; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key322 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key323; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key323 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key324; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key324 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key325; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key325 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key326; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key326 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key327; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key327 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key328; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key328 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key329; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key329 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key33 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key330; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key330 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key331; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key331 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key332; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key332 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key333; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key333 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key334; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key334 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key335; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key335 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key336; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key336 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key337; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key337 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key338; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key338 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key339; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key339 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key34; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key34 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key340; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key340 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key341; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key341 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key342; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key342 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key343; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key343 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key344; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key344 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key345; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key345 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key346; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key346 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key347; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key347 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key348; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key348 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key349; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key349 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key35; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key35 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key350; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key350 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key351; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key351 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key352; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key352 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key353; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key353 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key354; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key354 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key355; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key355 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key356; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key356 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key357; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key357 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key358; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key358 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key359; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key359 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key36; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key36 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key360; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key360 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key361; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key361 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key362; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key362 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key363; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key363 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key364; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key364 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key365; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key365 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key366; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key366 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key367; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key367 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key368; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key368 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key369; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key369 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key37; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key37 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key370; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key370 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key371; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key371 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key372; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key372 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key373; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key373 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key374; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key374 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key375; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key375 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key376; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key376 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key377; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key377 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key378; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key378 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key379; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key379 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key38; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key38 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key380; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key380 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key381; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key381 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key382; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key382 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key383; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key383 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key384; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key384 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key385; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key385 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key386; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key386 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key387; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key387 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key388; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key388 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key389; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key389 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key39; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key39 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key390; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key390 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key391; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key391 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key392; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key392 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key393; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key393 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key394; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key394 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key395; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key395 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key396; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key396 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key397; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key397 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key398; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key398 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key399; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key399 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key4 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key40 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key400; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key400 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key401; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key401 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key402; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key402 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key403; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key403 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key404; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key404 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key405; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key405 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key406; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key406 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key407; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key407 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key408; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key408 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key409; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key409 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key41; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key41 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key410; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key410 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key411; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key411 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key412; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key412 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key413; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key413 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key414; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key414 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key415; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key415 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key416; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key416 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key417; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key417 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key418; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key418 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key419; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key419 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key42; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key42 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key420; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key420 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key421; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key421 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key422; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key422 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key423; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key423 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key424; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key424 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key425; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key425 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key426; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key426 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key427; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key427 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key428; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key428 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key429; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key429 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key43; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key43 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key430; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key430 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key431; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key431 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key432; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key432 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key433; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key433 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key434; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key434 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key435; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key435 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key436; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key436 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key437; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key437 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key438; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key438 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key439; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key439 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key44; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key44 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key440; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key440 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key441; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key441 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key442; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key442 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key443; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key443 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key444; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key444 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key445; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key445 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key446; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key446 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key447; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key447 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key448; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key448 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key449; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key449 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key45; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key45 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key450; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key450 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key451; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key451 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key452; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key452 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key453; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key453 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key454; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key454 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key455; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key455 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key456; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key456 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key457; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key457 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key458; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key458 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key459; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key459 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key46; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key46 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key460; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key460 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key461; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key461 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key462; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key462 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key463; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key463 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key464; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key464 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key465; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key465 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key466; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key466 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key467; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key467 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key468; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key468 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key469; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key469 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key47; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key47 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key470; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key470 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key471; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key471 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key472; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key472 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key473; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key473 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key474; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key474 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key475; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key475 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key476; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key476 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key477; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key477 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key478; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key478 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key479; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key479 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key48; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key48 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key480; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key480 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key481; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key481 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key482; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key482 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key483; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key483 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key484; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key484 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key485; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key485 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key486; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key486 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key487; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key487 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key488; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key488 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key489; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key489 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key49; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key49 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key490; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key490 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key491; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key491 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key492; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key492 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key493; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key493 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key494; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key494 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key495; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key495 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key496; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key496 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key497; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key497 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key498; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key498 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key499; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key499 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key5 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key50; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key50 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key500; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key500 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key501; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key501 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key502; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key502 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key503; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key503 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key504; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key504 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key505; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key505 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key506; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key506 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key507; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key507 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key508; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key508 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key509; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key509 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key51; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key51 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key510; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key510 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key511; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key511 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key512; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key512 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key513; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key513 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key514; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key514 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key515; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key515 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key516; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key516 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key517; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key517 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key518; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key518 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key519; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key519 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key52; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key52 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key520; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key520 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key521; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key521 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key522; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key522 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key523; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key523 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key524; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key524 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key525; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key525 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key526; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key526 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key527; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key527 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key528; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key528 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key529; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key529 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key53; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key53 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key530; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key530 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key531; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key531 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key532; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key532 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key533; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key533 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key534; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key534 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key535; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key535 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key536; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key536 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key537; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key537 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key538; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key538 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key539; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key539 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key54; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key54 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key540; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key540 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key541; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key541 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key542; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key542 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key543; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key543 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key544; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key544 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key545; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key545 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key546; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key546 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key547; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key547 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key548; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key548 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key549; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key549 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key55; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key55 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key550; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key550 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key551; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key551 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key552; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key552 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key553; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key553 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key554; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key554 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key555; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key555 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key556; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key556 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key557; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key557 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key558; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key558 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key559; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key559 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key56; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key56 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key560; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key560 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key561; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key561 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key562; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key562 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key563; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key563 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key564; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key564 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key565; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key565 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key566; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key566 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key567; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key567 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key568; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key568 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key569; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key569 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key57 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key570; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key570 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key571; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key571 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key572; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key572 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key573; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key573 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key574; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key574 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key575; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key575 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key576; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key576 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key577; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key577 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key578; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key578 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key579; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key579 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key58; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key58 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key580; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key580 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key581; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key581 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key582; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key582 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key583; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key583 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key584; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key584 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key585; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key585 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key586; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key586 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key587; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key587 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key588; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key588 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key589; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key589 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key59; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key59 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key590; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key590 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key591; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key591 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key592; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key592 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key593; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key593 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key594; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key594 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key595; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key595 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key596; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key596 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key597; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key597 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key598; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key598 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key599; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key599 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key6 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key60; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key60 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key600; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key600 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key601; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key601 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key602; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key602 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key603; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key603 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key604; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key604 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key605; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key605 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key606; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key606 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key607; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key607 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key608; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key608 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key609; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key609 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key61; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key61 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key610; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key610 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key611; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key611 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key612; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key612 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key613; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key613 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key614; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key614 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key615; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key615 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key616; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key616 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key617; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key617 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key618; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key618 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key619; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key619 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key62; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key62 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key620; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key620 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key621; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key621 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key622; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key622 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key623; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key623 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key624; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key624 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key625; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key625 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key626; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key626 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key627; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key627 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key628; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key628 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key629; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key629 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key63; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key63 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key630; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key630 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key631; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key631 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key632; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key632 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key633; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key633 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key634; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key634 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key635; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key635 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key636; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key636 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key637; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key637 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key638; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key638 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key639; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key639 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key64; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key64 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key640; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key640 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key641; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key641 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key642; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key642 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key643; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key643 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key644; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key644 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key645; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key645 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key646; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key646 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key647; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key647 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key648; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key648 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key649; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key649 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key65; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key65 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key650; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key650 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key651; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key651 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key652; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key652 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key653; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key653 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key654; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key654 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key655; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key655 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key656; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key656 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key657; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key657 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key658; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key658 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key659; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key659 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key66; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key66 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key660; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key660 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key661; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key661 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key662; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key662 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key663; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key663 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key664; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key664 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key665; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key665 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key666; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key666 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key667; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key667 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key668; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key668 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key669; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key669 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key67; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key67 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key670; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key670 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key671; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key671 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key672; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key672 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key673; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key673 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key674; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key674 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key675; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key675 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key676; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key676 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key677; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key677 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key678; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key678 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key679; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key679 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key68; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key68 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key680; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key680 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key681; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key681 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key682; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key682 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key683; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key683 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key684; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key684 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key685; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key685 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key686; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key686 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key687; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key687 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key688; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key688 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key689; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key689 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key69; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key69 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key690; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key690 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key691; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key691 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key692; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key692 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key693; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key693 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key694; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key694 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key695; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key695 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key696; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key696 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key697; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key697 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key698; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key698 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key699; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key699 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key7 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key70; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key70 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key700; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key700 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key701; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key701 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key702; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key702 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key703; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key703 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key704; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key704 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key705; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key705 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key706; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key706 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key707; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key707 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key708; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key708 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key709; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key709 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key71; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key71 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key710; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key710 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key711; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key711 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key712; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key712 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key713; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key713 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key714; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key714 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key715; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key715 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key716; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key716 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key717; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key717 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key718; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key718 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key719; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key719 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key72; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key72 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key720; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key720 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key721; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key721 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key722; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key722 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key723; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key723 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key724; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key724 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key725; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key725 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key726; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key726 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key727; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key727 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key728; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key728 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key729; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key729 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key73; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key73 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key730; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key730 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key731; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key731 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key732; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key732 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key733; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key733 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key734; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key734 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key735; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key735 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key736; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key736 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key737; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key737 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key738; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key738 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key739; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key739 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key74; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key74 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key740; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key740 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key741; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key741 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key742; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key742 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key743; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key743 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key744; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key744 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key745; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key745 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key746; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key746 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key747; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key747 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key748; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key748 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key749; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key749 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key75; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key75 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key750; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key750 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key751; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key751 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key752; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key752 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key753; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key753 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key754; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key754 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key755; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key755 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key756; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key756 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key757; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key757 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key758; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key758 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key759; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key759 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key76; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key76 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key760; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key760 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key761; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key761 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key762; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key762 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key763; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key763 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key764; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key764 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key765; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key765 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key766; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key766 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key767; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key767 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key768; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key768 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key769; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key769 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key77; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key77 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key770; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key770 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key771; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key771 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key772; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key772 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key773; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key773 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key774; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key774 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key775; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key775 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key776; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key776 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key777; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key777 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key778; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key778 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key779; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key779 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key78; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key78 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key780; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key780 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key781; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key781 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key782; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key782 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key783; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key783 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key784; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key784 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key785; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key785 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key786; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key786 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key787; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key787 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key788; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key788 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key789; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key789 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key79; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key79 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key790; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key790 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key791; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key791 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key792; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key792 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key793; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key793 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key794; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key794 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key795; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key795 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key796; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key796 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key797; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key797 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key798; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key798 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key799; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key799 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key8 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key80; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key80 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key800; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key800 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key801; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key801 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key802; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key802 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key803; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key803 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key804; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key804 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key805; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key805 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key806; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key806 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key807; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key807 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key808; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key808 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key809; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key809 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key81 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key810; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key810 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key811; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key811 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key812; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key812 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key813; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key813 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key814; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key814 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key815; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key815 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key816; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key816 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key817; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key817 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key818; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key818 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key819; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key819 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key82; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key82 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key820; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key820 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key821; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key821 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key822; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key822 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key823; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key823 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key824; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key824 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key825; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key825 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key826; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key826 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key827; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key827 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key828; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key828 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key829; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key829 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key83; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key83 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key830; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key830 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key831; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key831 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key832; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key832 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key833; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key833 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key834; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key834 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key835; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key835 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key836; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key836 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key837; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key837 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key838; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key838 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key839; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key839 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key84 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key840; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key840 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key841; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key841 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key842; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key842 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key843; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key843 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key844; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key844 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key845; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key845 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key846; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key846 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key847; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key847 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key848; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key848 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key849; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key849 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key85; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key85 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key850; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key850 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key851; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key851 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key852; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key852 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key853; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key853 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key854; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key854 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key855; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key855 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key856; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key856 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key857; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key857 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key858; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key858 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key859; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key859 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key86; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key86 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key860; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key860 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key861; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key861 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key862; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key862 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key863; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key863 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key864; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key864 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key865; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key865 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key866; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key866 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key867; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key867 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key868; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key868 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key869; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key869 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key87; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key87 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key870; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key870 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key871; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key871 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key872; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key872 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key873; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key873 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key874; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key874 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key875; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key875 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key876; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key876 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key877; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key877 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key878; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key878 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key879; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key879 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key88; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key88 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key880; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key880 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key881; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key881 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key882; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key882 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key883; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key883 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key884; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key884 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key885; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key885 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key886; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key886 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key887; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key887 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key888; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key888 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key889; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key889 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key89; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key89 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key890; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key890 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key891; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key891 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key892; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key892 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key893; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key893 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key894; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key894 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key895; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key895 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key896; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key896 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key897; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key897 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key898; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key898 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key899; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key899 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key9 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key90; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key90 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key900; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key900 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key901; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key901 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key902; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key902 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key903; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key903 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key904; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key904 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key905; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key905 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key906; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key906 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key907; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key907 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key908; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key908 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key909; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key909 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key91; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key91 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key910; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key910 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key911; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key911 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key912; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key912 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key913; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key913 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key914; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key914 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key915; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key915 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key916; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key916 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key917; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key917 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key918; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key918 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key919; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key919 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key92 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key920; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key920 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key921; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key921 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key922; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key922 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key923; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key923 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key924; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key924 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key925; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key925 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key926; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key926 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key927; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key927 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key928; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key928 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key929; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key929 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key93; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key93 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key930; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key930 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key931; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key931 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key932; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key932 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key933; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key933 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key934; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key934 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key935; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key935 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key936; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key936 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key937; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key937 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key938; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key938 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key939; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key939 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key94; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key94 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key940; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key940 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key941; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key941 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key942; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key942 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key943; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key943 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key944; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key944 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key945; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key945 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key946; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key946 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key947; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key947 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key948; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key948 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key949; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key949 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key95; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key95 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key950; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key950 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key951; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key951 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key952; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key952 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key953; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key953 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key954; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key954 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key955; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key955 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key956; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key956 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key957; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key957 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key958; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key958 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key959; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key959 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key96; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key96 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key960; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key960 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key961; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key961 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key962; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key962 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key963; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key963 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key964; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key964 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key965; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key965 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key966; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key966 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key967; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key967 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key968; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key968 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key969; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key969 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key97; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key97 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key970; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key970 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key971; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key971 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key972; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key972 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key973; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key973 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key974; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key974 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key975; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key975 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key976; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key976 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key977; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key977 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key978; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key978 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key979; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key979 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key98; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key98 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key980; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key980 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key981; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key981 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key982; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key982 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key983; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key983 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key984; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key984 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key985; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key985 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key986; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key986 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key987; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key987 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key988; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key988 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key989; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key989 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key99; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key99 UNIQUE (email);


--
-- Name: usuarios usuarios_email_key990; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_email_key990 UNIQUE (email);


--
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- Name: citas citas_medicoID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT "citas_medicoID_fkey" FOREIGN KEY ("medicoID") REFERENCES public.usuarios(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: citas citas_pacienteID_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.citas
    ADD CONSTRAINT "citas_pacienteID_fkey" FOREIGN KEY ("pacienteID") REFERENCES public.pacientes(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

\unrestrict GYfJlNQZ4a0YxOmwb786FWrerxywQ5KGeQWOfV7uWA0tlgrNizbZJyVnjv84vWS

