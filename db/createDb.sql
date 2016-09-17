--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.0
-- Dumped by pg_dump version 9.5.1

-- Started on 2016-09-17 15:02:46

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2165 (class 1262 OID 40951)
-- Name: radiscope; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE radiscope WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C' LC_CTYPE = 'C';


ALTER DATABASE radiscope OWNER TO postgres;

\connect radiscope

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2168 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 188 (class 1259 OID 41001)
-- Name: project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project (
    id integer NOT NULL,
    display_name character varying(50) NOT NULL,
    user_id integer,
    workplace_id integer,
    CONSTRAINT project_user_id_workplace_id_check CHECK ((((user_id IS NOT NULL) AND (workplace_id IS NULL)) OR ((user_id IS NULL) AND (workplace_id IS NOT NULL))))
);


ALTER TABLE project OWNER TO postgres;

--
-- TOC entry 2169 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN project.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN project.user_id IS 'The user this project belongs to. The project can belong to a workplace OR a user';


--
-- TOC entry 2170 (class 0 OID 0)
-- Dependencies: 188
-- Name: COLUMN project.workplace_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN project.workplace_id IS 'The workplace this project belongs to. The project can belong to a workplace OR a user';


--
-- TOC entry 2171 (class 0 OID 0)
-- Dependencies: 188
-- Name: CONSTRAINT project_user_id_workplace_id_check ON project; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT project_user_id_workplace_id_check ON project IS 'Make sure only user_id OR workplace_id can be set at a time. Not both, no none.';


--
-- TOC entry 187 (class 1259 OID 40999)
-- Name: project_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE project_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE project_id_seq OWNER TO postgres;

--
-- TOC entry 2172 (class 0 OID 0)
-- Dependencies: 187
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_id_seq OWNED BY project.id;


--
-- TOC entry 190 (class 1259 OID 41025)
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE task (
    id integer NOT NULL,
    user_id integer,
    project_id integer,
    workplace_id integer
);


ALTER TABLE task OWNER TO postgres;

--
-- TOC entry 2173 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN task.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN task.user_id IS 'The user this task belongs to. A task can belong to a user OR a project OR a workplace. This is not the user this task has been assigned to';


--
-- TOC entry 2174 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN task.project_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN task.project_id IS 'The project this task belongs to. A task can belong to a user OR a project OR a workplace';


--
-- TOC entry 2175 (class 0 OID 0)
-- Dependencies: 190
-- Name: COLUMN task.workplace_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN task.workplace_id IS 'The workplace this task belongs to. A task can belong to a user OR a project OR a workplace';


--
-- TOC entry 192 (class 1259 OID 41082)
-- Name: task_comment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE task_comment (
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    text text NOT NULL,
    task_id integer NOT NULL
);


ALTER TABLE task_comment OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 41080)
-- Name: task_comment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE task_comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE task_comment_id_seq OWNER TO postgres;

--
-- TOC entry 2176 (class 0 OID 0)
-- Dependencies: 191
-- Name: task_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE task_comment_id_seq OWNED BY task_comment.id;


--
-- TOC entry 189 (class 1259 OID 41023)
-- Name: task_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE task_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE task_id_seq OWNER TO postgres;

--
-- TOC entry 2177 (class 0 OID 0)
-- Dependencies: 189
-- Name: task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE task_id_seq OWNED BY task.id;


--
-- TOC entry 183 (class 1259 OID 40966)
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_id_seq OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 40968)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "user" (
    id integer DEFAULT nextval('user_id_seq'::regclass) NOT NULL,
    name character varying(50) NOT NULL,
    display_name character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    photo_url character varying(255),
    oauth_profiles json
);


ALTER TABLE "user" OWNER TO postgres;

--
-- TOC entry 2178 (class 0 OID 0)
-- Dependencies: 184
-- Name: COLUMN "user".oauth_profiles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN "user".oauth_profiles IS 'A JSON containing information returned by OAuth providers';


--
-- TOC entry 186 (class 1259 OID 40983)
-- Name: user_workplaces; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_workplaces (
    id integer NOT NULL,
    user_id integer NOT NULL,
    workplace_id integer NOT NULL
);


ALTER TABLE user_workplaces OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 40981)
-- Name: user_workplaces_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_workplaces_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_workplaces_id_seq OWNER TO postgres;

--
-- TOC entry 2179 (class 0 OID 0)
-- Dependencies: 185
-- Name: user_workplaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_workplaces_id_seq OWNED BY user_workplaces.id;


--
-- TOC entry 182 (class 1259 OID 40957)
-- Name: workplace; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE workplace (
    id integer NOT NULL,
    display_name character varying(50)[] NOT NULL,
    license integer
);


ALTER TABLE workplace OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 40955)
-- Name: workplace_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE workplace_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE workplace_id_seq OWNER TO postgres;

--
-- TOC entry 2180 (class 0 OID 0)
-- Dependencies: 181
-- Name: workplace_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE workplace_id_seq OWNED BY workplace.id;


--
-- TOC entry 2017 (class 2604 OID 41004)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project ALTER COLUMN id SET DEFAULT nextval('project_id_seq'::regclass);


--
-- TOC entry 2019 (class 2604 OID 41028)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task ALTER COLUMN id SET DEFAULT nextval('task_id_seq'::regclass);


--
-- TOC entry 2020 (class 2604 OID 41085)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_comment ALTER COLUMN id SET DEFAULT nextval('task_comment_id_seq'::regclass);


--
-- TOC entry 2016 (class 2604 OID 40986)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_workplaces ALTER COLUMN id SET DEFAULT nextval('user_workplaces_id_seq'::regclass);


--
-- TOC entry 2014 (class 2604 OID 40960)
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workplace ALTER COLUMN id SET DEFAULT nextval('workplace_id_seq'::regclass);


--
-- TOC entry 2033 (class 2606 OID 41006)
-- Name: project_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_id_pk PRIMARY KEY (id);


--
-- TOC entry 2037 (class 2606 OID 41094)
-- Name: task_comment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_pk PRIMARY KEY (id);


--
-- TOC entry 2035 (class 2606 OID 41079)
-- Name: task_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_id_pk PRIMARY KEY (id);


--
-- TOC entry 2025 (class 2606 OID 40978)
-- Name: user_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_unique UNIQUE (email);


--
-- TOC entry 2027 (class 2606 OID 40976)
-- Name: user_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_id_pk PRIMARY KEY (id);


--
-- TOC entry 2029 (class 2606 OID 41038)
-- Name: user_name_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_name_unique UNIQUE (name);


--
-- TOC entry 2031 (class 2606 OID 40988)
-- Name: user_workplaces_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_workplaces
    ADD CONSTRAINT user_workplaces_id_pk PRIMARY KEY (id);


--
-- TOC entry 2022 (class 2606 OID 40962)
-- Name: workplace_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workplace
    ADD CONSTRAINT workplace_id_pk PRIMARY KEY (id);


--
-- TOC entry 2023 (class 1259 OID 41105)
-- Name: user_email_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_email_uindex ON "user" USING btree (email);


--
-- TOC entry 2040 (class 2606 OID 41007)
-- Name: project_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_user_id_fk FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 2041 (class 2606 OID 41013)
-- Name: project_workplace_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_workplace_id_fk FOREIGN KEY (workplace_id) REFERENCES workplace(id);


--
-- TOC entry 2046 (class 2606 OID 41100)
-- Name: task_comment_task_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_task_id_fk FOREIGN KEY (task_id) REFERENCES task(id);


--
-- TOC entry 2045 (class 2606 OID 41088)
-- Name: task_comment_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_user_id_fk FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 2044 (class 2606 OID 41073)
-- Name: task_project_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_project_id_fk FOREIGN KEY (project_id) REFERENCES project(id);


--
-- TOC entry 2043 (class 2606 OID 41068)
-- Name: task_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_user_id_fk FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 2042 (class 2606 OID 41063)
-- Name: task_workplace_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_workplace_id_fk FOREIGN KEY (workplace_id) REFERENCES workplace(id);


--
-- TOC entry 2038 (class 2606 OID 40989)
-- Name: user_workplaces_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_workplaces
    ADD CONSTRAINT user_workplaces_user_id_fk FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- TOC entry 2039 (class 2606 OID 40994)
-- Name: user_workplaces_workplace_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_workplaces
    ADD CONSTRAINT user_workplaces_workplace_id_fk FOREIGN KEY (workplace_id) REFERENCES workplace(id);


--
-- TOC entry 2167 (class 0 OID 0)
-- Dependencies: 6
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2016-09-17 15:02:47

--
-- PostgreSQL database dump complete
--

