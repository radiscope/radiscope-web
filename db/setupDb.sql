--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.0
-- Dumped by pg_dump version 9.5.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: notification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE notification (
    id integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    read boolean DEFAULT false NOT NULL,
    type smallint NOT NULL,
    data json NOT NULL,
    user_id integer NOT NULL
);


ALTER TABLE notification OWNER TO postgres;

--
-- Name: COLUMN notification.read; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notification.read IS 'Whether or not the user has read the notification';


--
-- Name: COLUMN notification.type; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notification.type IS 'Notification type. This is an enum/const that will be defined in code';


--
-- Name: COLUMN notification.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN notification.user_id IS 'The user the notification is for';


--
-- Name: notification_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE notification_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE notification_id_seq OWNER TO postgres;

--
-- Name: notification_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE notification_id_seq OWNED BY notification.id;


--
-- Name: project; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE project (
    id integer NOT NULL,
    display_name character varying(50) NOT NULL,
    user_id integer,
    workplace_id integer,
    due_date date,
    CONSTRAINT project_user_id_workplace_id_check CHECK ((((user_id IS NOT NULL) AND (workplace_id IS NULL)) OR ((user_id IS NULL) AND (workplace_id IS NOT NULL))))
);


ALTER TABLE project OWNER TO postgres;

--
-- Name: COLUMN project.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN project.user_id IS 'The user this project belongs to. The project can belong to a workplace OR a user';


--
-- Name: COLUMN project.workplace_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN project.workplace_id IS 'The workplace this project belongs to. The project can belong to a workplace OR a user';


--
-- Name: CONSTRAINT project_user_id_workplace_id_check ON project; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON CONSTRAINT project_user_id_workplace_id_check ON project IS 'Make sure only user_id OR workplace_id can be set at a time. Not both, no none.';


--
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
-- Name: project_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE project_id_seq OWNED BY project.id;


--
-- Name: task; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE task (
    id integer NOT NULL,
    user_id integer,
    project_id integer,
    workplace_id integer,
    assigned_to integer,
    due_date date,
    status integer,
    text text NOT NULL
);


ALTER TABLE task OWNER TO postgres;

--
-- Name: COLUMN task.user_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN task.user_id IS 'The user this task belongs to. A task can belong to a user OR a project OR a workplace. This is not the user this task has been assigned to';


--
-- Name: COLUMN task.project_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN task.project_id IS 'The project this task belongs to. A task can belong to a user OR a project OR a workplace';


--
-- Name: COLUMN task.workplace_id; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN task.workplace_id IS 'The workplace this task belongs to. A task can belong to a user OR a project OR a workplace';


--
-- Name: COLUMN task.status; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN task.status IS 'The status of the task. This will be an enum/const defined in code';


--
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
-- Name: task_comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE task_comment_id_seq OWNED BY task_comment.id;


--
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
-- Name: task_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE task_id_seq OWNED BY task.id;


--
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
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE "user" (
    id integer DEFAULT nextval('user_id_seq'::regclass) NOT NULL,
    display_name character varying(50) NOT NULL,
    email character varying(255) NOT NULL,
    photo_url character varying(255),
    oauth_profiles json
);


ALTER TABLE "user" OWNER TO postgres;

--
-- Name: COLUMN "user".oauth_profiles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON COLUMN "user".oauth_profiles IS 'A JSON containing information returned by OAuth providers';


--
-- Name: user_tasks_following; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_tasks_following (
    id integer NOT NULL,
    user_id integer NOT NULL,
    task_id integer NOT NULL
);


ALTER TABLE user_tasks_following OWNER TO postgres;

--
-- Name: user_tasks_following_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE user_tasks_following_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE user_tasks_following_id_seq OWNER TO postgres;

--
-- Name: user_tasks_following_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_tasks_following_id_seq OWNED BY user_tasks_following.id;


--
-- Name: user_workplaces; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE user_workplaces (
    id integer NOT NULL,
    user_id integer NOT NULL,
    workplace_id integer NOT NULL
);


ALTER TABLE user_workplaces OWNER TO postgres;

--
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
-- Name: user_workplaces_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE user_workplaces_id_seq OWNED BY user_workplaces.id;


--
-- Name: workplace; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE workplace (
    id integer NOT NULL,
    display_name character varying(50)[] NOT NULL,
    license integer
);


ALTER TABLE workplace OWNER TO postgres;

--
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
-- Name: workplace_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE workplace_id_seq OWNED BY workplace.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notification ALTER COLUMN id SET DEFAULT nextval('notification_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project ALTER COLUMN id SET DEFAULT nextval('project_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task ALTER COLUMN id SET DEFAULT nextval('task_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_comment ALTER COLUMN id SET DEFAULT nextval('task_comment_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_tasks_following ALTER COLUMN id SET DEFAULT nextval('user_tasks_following_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_workplaces ALTER COLUMN id SET DEFAULT nextval('user_workplaces_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workplace ALTER COLUMN id SET DEFAULT nextval('workplace_id_seq'::regclass);


--
-- Name: notification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: project_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_id_pk PRIMARY KEY (id);


--
-- Name: task_comment_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_pk PRIMARY KEY (id);


--
-- Name: task_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_id_pk PRIMARY KEY (id);


--
-- Name: user_email_unique; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_email_unique UNIQUE (email);


--
-- Name: user_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY "user"
    ADD CONSTRAINT user_id_pk PRIMARY KEY (id);


--
-- Name: user_tasks_following_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_tasks_following
    ADD CONSTRAINT user_tasks_following_pkey PRIMARY KEY (id);


--
-- Name: user_workplaces_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_workplaces
    ADD CONSTRAINT user_workplaces_id_pk PRIMARY KEY (id);


--
-- Name: workplace_id_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY workplace
    ADD CONSTRAINT workplace_id_pk PRIMARY KEY (id);


--
-- Name: user_email_uindex; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_email_uindex ON "user" USING btree (email);


--
-- Name: notification_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY notification
    ADD CONSTRAINT notification_user_id_fk FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: project_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_user_id_fk FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: project_workplace_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY project
    ADD CONSTRAINT project_workplace_id_fk FOREIGN KEY (workplace_id) REFERENCES workplace(id);


--
-- Name: task_assigned_to_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_assigned_to_fk FOREIGN KEY (assigned_to) REFERENCES "user"(id);


--
-- Name: task_comment_task_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_task_id_fk FOREIGN KEY (task_id) REFERENCES task(id);


--
-- Name: task_comment_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task_comment
    ADD CONSTRAINT task_comment_user_id_fk FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: task_project_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_project_id_fk FOREIGN KEY (project_id) REFERENCES project(id);


--
-- Name: task_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_user_id_fk FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: task_workplace_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY task
    ADD CONSTRAINT task_workplace_id_fk FOREIGN KEY (workplace_id) REFERENCES workplace(id);


--
-- Name: user_tasks_following_task_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_tasks_following
    ADD CONSTRAINT user_tasks_following_task_id_fk FOREIGN KEY (task_id) REFERENCES task(id);


--
-- Name: user_tasks_following_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_tasks_following
    ADD CONSTRAINT user_tasks_following_user_id_fk FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: user_workplaces_user_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_workplaces
    ADD CONSTRAINT user_workplaces_user_id_fk FOREIGN KEY (user_id) REFERENCES "user"(id);


--
-- Name: user_workplaces_workplace_id_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY user_workplaces
    ADD CONSTRAINT user_workplaces_workplace_id_fk FOREIGN KEY (workplace_id) REFERENCES workplace(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--

