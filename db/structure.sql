--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: pg_trgm; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_trgm WITH SCHEMA public;


--
-- Name: EXTENSION pg_trgm; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pg_trgm IS 'text similarity measurement and index searching based on trigrams';


SET search_path = public, pg_catalog;

--
-- Name: pg_search_dmetaphone(text); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION pg_search_dmetaphone(text) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $_$
  SELECT array_to_string(ARRAY(SELECT dmetaphone(unnest(regexp_split_to_array($1, E'\\s+')))), ' ')
$_$;


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: active_admin_comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE active_admin_comments (
    id integer NOT NULL,
    resource_id character varying(255) NOT NULL,
    resource_type character varying(255) NOT NULL,
    author_id integer,
    author_type character varying(255),
    body text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    namespace character varying(255)
);


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE active_admin_comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: active_admin_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE active_admin_comments_id_seq OWNED BY active_admin_comments.id;


--
-- Name: admin_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admin_users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: admin_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_users_id_seq OWNED BY admin_users.id;


--
-- Name: attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE attachments (
    id integer NOT NULL,
    item character varying(255),
    attachable_id integer,
    attachable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE attachments_id_seq OWNED BY attachments.id;


--
-- Name: checklist_items; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE checklist_items (
    id integer NOT NULL,
    checklist_id integer,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: checklist_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE checklist_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: checklist_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE checklist_items_id_seq OWNED BY checklist_items.id;


--
-- Name: checklists; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE checklists (
    id integer NOT NULL,
    user_id integer,
    author_id integer,
    name character varying(255),
    frequency character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    days_of_week_mask integer,
    checklist_item_id integer
);


--
-- Name: checklists_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE checklists_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: checklists_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE checklists_id_seq OWNED BY checklists.id;


--
-- Name: club_users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE club_users (
    id integer NOT NULL,
    user_id integer,
    club_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: club_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE club_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: club_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE club_users_id_seq OWNED BY club_users.id;


--
-- Name: clubs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE clubs (
    id integer NOT NULL,
    name character varying(255),
    region_id integer,
    address text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    abbreviation character varying(255)
);


--
-- Name: clubs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE clubs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: clubs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE clubs_id_seq OWNED BY clubs.id;


--
-- Name: completes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE completes (
    id integer NOT NULL,
    completable_id integer,
    completable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: completes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE completes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: completes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE completes_id_seq OWNED BY completes.id;


--
-- Name: contexts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE contexts (
    id integer NOT NULL,
    name character varying(255),
    "position" integer,
    owner_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: contexts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE contexts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: contexts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE contexts_id_seq OWNED BY contexts.id;


--
-- Name: daily_summaries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE daily_summaries (
    id integer NOT NULL,
    summary_date timestamp without time zone,
    monthly_summary_id integer,
    membership_cash numeric(8,2),
    training_cash numeric(8,2),
    juice_bar_cash numeric(8,2),
    nursery_cash numeric(8,2),
    membership_draft_cash numeric(8,2),
    training_draft_cash numeric(8,2),
    membership_cancellations integer,
    membership_cancellations_value numeric(8,2),
    membership_freezes integer,
    membership_freezes_value numeric(8,2),
    membership_delinquents integer,
    membership_delinquents_value numeric(8,2),
    training_cancellations integer,
    training_cancellations_value numeric(8,2),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: daily_summaries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE daily_summaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: daily_summaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE daily_summaries_id_seq OWNED BY daily_summaries.id;


--
-- Name: departments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE departments (
    id integer NOT NULL,
    name character varying(255),
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: departments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE departments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: departments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE departments_id_seq OWNED BY departments.id;


--
-- Name: envelopes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE envelopes (
    id integer NOT NULL,
    message_id integer,
    recipient_id integer,
    read_flag boolean DEFAULT false,
    important_flag boolean DEFAULT false,
    trash_flag boolean DEFAULT false,
    delete_flag boolean DEFAULT false,
    delivered_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    author_flag boolean DEFAULT false
);


--
-- Name: envelopes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE envelopes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: envelopes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE envelopes_id_seq OWNED BY envelopes.id;


--
-- Name: event_subscriptions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE event_subscriptions (
    id integer NOT NULL,
    event_id integer,
    user_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: event_subscriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE event_subscriptions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: event_subscriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE event_subscriptions_id_seq OWNED BY event_subscriptions.id;


--
-- Name: events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events (
    id integer NOT NULL,
    organizer_id integer,
    summary text,
    description text,
    starts_at_time time without time zone,
    starts_at_date date,
    ends_at_date date,
    days_of_week_mask integer
);


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: events_save; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE events_save (
    id integer NOT NULL,
    user_id integer,
    invitee_list character varying(255),
    subject character varying(255),
    location character varying(255),
    description text,
    start_at timestamp without time zone,
    end_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    state character varying(255)
);


--
-- Name: events_save_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_save_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_save_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_save_id_seq OWNED BY events_save.id;


--
-- Name: mailboxes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mailboxes (
    id integer NOT NULL,
    user_id integer,
    name character varying(255),
    host character varying(255),
    port character varying(255),
    ssl boolean,
    domain character varying(255),
    username character varying(255),
    passcode character varying(255),
    starttls_auto boolean,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: mailboxes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mailboxes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mailboxes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mailboxes_id_seq OWNED BY mailboxes.id;


--
-- Name: messages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE messages (
    id integer NOT NULL,
    author_id integer,
    send_to character varying(255) DEFAULT ''::character varying,
    copy_to character varying(255) DEFAULT ''::character varying,
    blind_copy_to character varying(255) DEFAULT ''::character varying,
    subject character varying(255),
    body text,
    status character varying(255) DEFAULT 'draft'::character varying,
    importance character varying(255) DEFAULT 'normal'::character varying,
    sent_at timestamp without time zone,
    read_receipt_request boolean DEFAULT false,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: messages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE messages_id_seq OWNED BY messages.id;


--
-- Name: monthly_summaries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE monthly_summaries (
    id integer NOT NULL,
    club_id integer,
    month timestamp without time zone,
    business_days_in_month integer,
    membership_goal numeric(8,2),
    training_goal numeric(8,2),
    juice_bar_goal numeric(8,2),
    nursery_goal numeric(8,2),
    membership_draft_expected numeric(8,2),
    training_draft_expected numeric(8,2),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: monthly_summaries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE monthly_summaries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: monthly_summaries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE monthly_summaries_id_seq OWNED BY monthly_summaries.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE projects (
    id integer NOT NULL,
    name character varying(255),
    description text,
    owner_id integer,
    "position" integer,
    context_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE projects_id_seq OWNED BY projects.id;


--
-- Name: regions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE regions (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: regions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE regions_id_seq OWNED BY regions.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sys_logs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sys_logs (
    id integer NOT NULL,
    message text,
    message_type character varying(255),
    actioned_by character varying(255),
    loggable_id integer,
    loggable_type character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: sys_logs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sys_logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sys_logs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sys_logs_id_seq OWNED BY sys_logs.id;


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tasks (
    id integer NOT NULL,
    name character varying(255),
    due_at timestamp without time zone,
    completed_at timestamp without time zone,
    context_id integer,
    project_id integer,
    owner_id integer,
    notes text,
    state character varying(255),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    assignee_id integer,
    started_at timestamp without time zone,
    claimed_at timestamp without time zone,
    priority integer,
    department_id integer
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tasks_id_seq OWNED BY tasks.id;


--
-- Name: user_events; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE user_events (
    id integer NOT NULL,
    user_id integer,
    event_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_events_id_seq OWNED BY user_events.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255) DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying(255) DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying(255),
    reset_password_sent_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying(255),
    last_sign_in_ip character varying(255),
    failed_attempts integer DEFAULT 0,
    locked_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    employee_number character varying(255),
    title character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    roles_mask integer
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY active_admin_comments ALTER COLUMN id SET DEFAULT nextval('active_admin_comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_users ALTER COLUMN id SET DEFAULT nextval('admin_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY attachments ALTER COLUMN id SET DEFAULT nextval('attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY checklist_items ALTER COLUMN id SET DEFAULT nextval('checklist_items_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY checklists ALTER COLUMN id SET DEFAULT nextval('checklists_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY club_users ALTER COLUMN id SET DEFAULT nextval('club_users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY clubs ALTER COLUMN id SET DEFAULT nextval('clubs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY completes ALTER COLUMN id SET DEFAULT nextval('completes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY contexts ALTER COLUMN id SET DEFAULT nextval('contexts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY daily_summaries ALTER COLUMN id SET DEFAULT nextval('daily_summaries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY departments ALTER COLUMN id SET DEFAULT nextval('departments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY envelopes ALTER COLUMN id SET DEFAULT nextval('envelopes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY event_subscriptions ALTER COLUMN id SET DEFAULT nextval('event_subscriptions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events_save ALTER COLUMN id SET DEFAULT nextval('events_save_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mailboxes ALTER COLUMN id SET DEFAULT nextval('mailboxes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY messages ALTER COLUMN id SET DEFAULT nextval('messages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY monthly_summaries ALTER COLUMN id SET DEFAULT nextval('monthly_summaries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY projects ALTER COLUMN id SET DEFAULT nextval('projects_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY regions ALTER COLUMN id SET DEFAULT nextval('regions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sys_logs ALTER COLUMN id SET DEFAULT nextval('sys_logs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tasks ALTER COLUMN id SET DEFAULT nextval('tasks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_events ALTER COLUMN id SET DEFAULT nextval('user_events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: admin_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY active_admin_comments
    ADD CONSTRAINT admin_notes_pkey PRIMARY KEY (id);


--
-- Name: admin_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admin_users
    ADD CONSTRAINT admin_users_pkey PRIMARY KEY (id);


--
-- Name: attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: checklist_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY checklist_items
    ADD CONSTRAINT checklist_items_pkey PRIMARY KEY (id);


--
-- Name: checklists_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY checklists
    ADD CONSTRAINT checklists_pkey PRIMARY KEY (id);


--
-- Name: club_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY club_users
    ADD CONSTRAINT club_users_pkey PRIMARY KEY (id);


--
-- Name: clubs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY clubs
    ADD CONSTRAINT clubs_pkey PRIMARY KEY (id);


--
-- Name: completes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY completes
    ADD CONSTRAINT completes_pkey PRIMARY KEY (id);


--
-- Name: contexts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY contexts
    ADD CONSTRAINT contexts_pkey PRIMARY KEY (id);


--
-- Name: daily_summaries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY daily_summaries
    ADD CONSTRAINT daily_summaries_pkey PRIMARY KEY (id);


--
-- Name: departments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (id);


--
-- Name: envelopes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY envelopes
    ADD CONSTRAINT envelopes_pkey PRIMARY KEY (id);


--
-- Name: event_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY event_subscriptions
    ADD CONSTRAINT event_subscriptions_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events_save
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: events_pkey1; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey1 PRIMARY KEY (id);


--
-- Name: mailboxes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mailboxes
    ADD CONSTRAINT mailboxes_pkey PRIMARY KEY (id);


--
-- Name: messages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id);


--
-- Name: monthly_summaries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY monthly_summaries
    ADD CONSTRAINT monthly_summaries_pkey PRIMARY KEY (id);


--
-- Name: projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: regions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY regions
    ADD CONSTRAINT regions_pkey PRIMARY KEY (id);


--
-- Name: sys_logs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sys_logs
    ADD CONSTRAINT sys_logs_pkey PRIMARY KEY (id);


--
-- Name: tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: user_events_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY user_events
    ADD CONSTRAINT user_events_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_active_admin_comments_on_author_type_and_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_author_type_and_author_id ON active_admin_comments USING btree (author_type, author_id);


--
-- Name: index_active_admin_comments_on_namespace; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_active_admin_comments_on_namespace ON active_admin_comments USING btree (namespace);


--
-- Name: index_admin_notes_on_resource_type_and_resource_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_admin_notes_on_resource_type_and_resource_id ON active_admin_comments USING btree (resource_type, resource_id);


--
-- Name: index_admin_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_email ON admin_users USING btree (email);


--
-- Name: index_admin_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_admin_users_on_reset_password_token ON admin_users USING btree (reset_password_token);


--
-- Name: index_checklist_items_on_checklist_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_checklist_items_on_checklist_id ON checklist_items USING btree (checklist_id);


--
-- Name: index_checklist_items_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_checklist_items_on_name ON checklist_items USING btree (name);


--
-- Name: index_checklists_on_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_checklists_on_author_id ON checklists USING btree (author_id);


--
-- Name: index_checklists_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_checklists_on_name ON checklists USING btree (name);


--
-- Name: index_checklists_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_checklists_on_user_id ON checklists USING btree (user_id);


--
-- Name: index_club_users_on_user_id_and_club_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_club_users_on_user_id_and_club_id ON club_users USING btree (user_id, club_id);


--
-- Name: index_clubs_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_clubs_on_name ON clubs USING btree (name);


--
-- Name: index_clubs_on_region_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_clubs_on_region_id ON clubs USING btree (region_id);


--
-- Name: index_completes_on_completable_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_completes_on_completable_id ON completes USING btree (completable_id);


--
-- Name: index_contexts_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contexts_on_name ON contexts USING btree (name);


--
-- Name: index_contexts_on_owner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contexts_on_owner_id ON contexts USING btree (owner_id);


--
-- Name: index_contexts_on_owner_id_and_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_contexts_on_owner_id_and_name ON contexts USING btree (owner_id, name);


--
-- Name: index_daily_summaries_on_monthly_summary_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_daily_summaries_on_monthly_summary_id ON daily_summaries USING btree (monthly_summary_id);


--
-- Name: index_envelopes_on_message_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_envelopes_on_message_id ON envelopes USING btree (message_id);


--
-- Name: index_envelopes_on_recipient_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_envelopes_on_recipient_id ON envelopes USING btree (recipient_id);


--
-- Name: index_events_on_end_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_end_at ON events_save USING btree (end_at);


--
-- Name: index_events_on_organizer_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_organizer_id ON events USING btree (organizer_id);


--
-- Name: index_events_on_start_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_start_at ON events_save USING btree (start_at);


--
-- Name: index_events_on_starts_at_date; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_starts_at_date ON events USING btree (starts_at_date);


--
-- Name: index_events_on_starts_at_date_and_starts_at_time; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_starts_at_date_and_starts_at_time ON events USING btree (starts_at_date, starts_at_time);


--
-- Name: index_events_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_events_on_user_id ON events_save USING btree (user_id);


--
-- Name: index_mailboxes_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mailboxes_on_user_id ON mailboxes USING btree (user_id);


--
-- Name: index_messages_on_author_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_author_id ON messages USING btree (author_id);


--
-- Name: index_messages_on_sent_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_sent_at ON messages USING btree (sent_at);


--
-- Name: index_messages_on_subject; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_messages_on_subject ON messages USING btree (subject);


--
-- Name: index_monthly_summaries_on_club_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_monthly_summaries_on_club_id ON monthly_summaries USING btree (club_id);


--
-- Name: index_monthly_summaries_on_month; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_monthly_summaries_on_month ON monthly_summaries USING btree (month);


--
-- Name: index_projects_on_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_name ON projects USING btree (name);


--
-- Name: index_projects_on_owner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_owner_id ON projects USING btree (owner_id);


--
-- Name: index_projects_on_owner_id_and_name; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_projects_on_owner_id_and_name ON projects USING btree (owner_id, name);


--
-- Name: index_sys_logs_on_loggable_id_and_loggable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sys_logs_on_loggable_id_and_loggable_type ON sys_logs USING btree (loggable_id, loggable_type);


--
-- Name: index_tasks_on_assignee_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tasks_on_assignee_id ON tasks USING btree (assignee_id);


--
-- Name: index_tasks_on_assignee_id_and_due_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tasks_on_assignee_id_and_due_at ON tasks USING btree (assignee_id, due_at);


--
-- Name: index_tasks_on_context_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tasks_on_context_id ON tasks USING btree (context_id);


--
-- Name: index_tasks_on_owner_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tasks_on_owner_id ON tasks USING btree (owner_id);


--
-- Name: index_tasks_on_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tasks_on_priority ON tasks USING btree (priority);


--
-- Name: index_tasks_on_project_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tasks_on_project_id ON tasks USING btree (project_id);


--
-- Name: index_tasks_on_state; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_tasks_on_state ON tasks USING btree (state);


--
-- Name: index_user_events_on_event_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_events_on_event_id ON user_events USING btree (event_id);


--
-- Name: index_user_events_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_user_events_on_user_id ON user_events USING btree (user_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: trgm_idx; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX trgm_idx ON tasks USING gist (name gist_trgm_ops);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO schema_migrations (version) VALUES ('20120913022913');

INSERT INTO schema_migrations (version) VALUES ('20120913024934');

INSERT INTO schema_migrations (version) VALUES ('20120913164441');

INSERT INTO schema_migrations (version) VALUES ('20120913164443');

INSERT INTO schema_migrations (version) VALUES ('20120913164444');

INSERT INTO schema_migrations (version) VALUES ('20120913181840');

INSERT INTO schema_migrations (version) VALUES ('20120913181946');

INSERT INTO schema_migrations (version) VALUES ('20120913200816');

INSERT INTO schema_migrations (version) VALUES ('20120914160153');

INSERT INTO schema_migrations (version) VALUES ('20120914161125');

INSERT INTO schema_migrations (version) VALUES ('20120919010836');

INSERT INTO schema_migrations (version) VALUES ('20120925175824');

INSERT INTO schema_migrations (version) VALUES ('20120927203602');

INSERT INTO schema_migrations (version) VALUES ('20120928211322');

INSERT INTO schema_migrations (version) VALUES ('20121005143230');

INSERT INTO schema_migrations (version) VALUES ('20121019004508');

INSERT INTO schema_migrations (version) VALUES ('20121020212559');

INSERT INTO schema_migrations (version) VALUES ('20121101020923');

INSERT INTO schema_migrations (version) VALUES ('20121119002609');

INSERT INTO schema_migrations (version) VALUES ('20121127212201');

INSERT INTO schema_migrations (version) VALUES ('20121128024406');

INSERT INTO schema_migrations (version) VALUES ('20121218014944');

INSERT INTO schema_migrations (version) VALUES ('20121220205459');

INSERT INTO schema_migrations (version) VALUES ('20121221041916');

INSERT INTO schema_migrations (version) VALUES ('20121227180140');

INSERT INTO schema_migrations (version) VALUES ('20121227180356');

INSERT INTO schema_migrations (version) VALUES ('20121229194025');

INSERT INTO schema_migrations (version) VALUES ('20121230190106');

INSERT INTO schema_migrations (version) VALUES ('20130101213000');

INSERT INTO schema_migrations (version) VALUES ('20130123031110');

INSERT INTO schema_migrations (version) VALUES ('20130123033512');

INSERT INTO schema_migrations (version) VALUES ('20130203030519');

INSERT INTO schema_migrations (version) VALUES ('20130212021214');

INSERT INTO schema_migrations (version) VALUES ('20130313010011');

INSERT INTO schema_migrations (version) VALUES ('20130316203631');

INSERT INTO schema_migrations (version) VALUES ('20130329124400');

INSERT INTO schema_migrations (version) VALUES ('20130416012701');

INSERT INTO schema_migrations (version) VALUES ('20130416013823');

INSERT INTO schema_migrations (version) VALUES ('20130420011951');

INSERT INTO schema_migrations (version) VALUES ('20130420192030');

INSERT INTO schema_migrations (version) VALUES ('20130420200542');