--
-- PostgreSQL database dump
--

-- Dumped from database version 11.2 (Debian 11.2-1.pgdg90+1)
-- Dumped by pg_dump version 11.18 (Ubuntu 11.18-1.pgdg18.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.auth_group (
    group_id integer NOT NULL,
    group_uuid character(36) NOT NULL,
    group_name character varying(40) NOT NULL,
    description character varying(255),
    create_datetime timestamp without time zone NOT NULL
);


ALTER TABLE public.auth_group OWNER TO uudex_user;

--
-- Name: auth_group_group_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.auth_group_group_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_group_group_id_seq OWNER TO uudex_user;

--
-- Name: auth_group_group_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.auth_group_group_id_seq OWNED BY public.auth_group.group_id;


--
-- Name: auth_role; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.auth_role (
    role_id integer NOT NULL,
    role_uuid character(36) NOT NULL,
    role_name character varying(40) NOT NULL,
    description character varying(255),
    create_datetime timestamp without time zone NOT NULL
);


ALTER TABLE public.auth_role OWNER TO uudex_user;

--
-- Name: auth_role_role_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.auth_role_role_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.auth_role_role_id_seq OWNER TO uudex_user;

--
-- Name: auth_role_role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.auth_role_role_id_seq OWNED BY public.auth_role.role_id;


--
-- Name: casbin_rule; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.casbin_rule (
    id integer NOT NULL,
    ptype character varying(255),
    v0 character varying(255),
    v1 character varying(255),
    v2 character varying(255),
    v3 character varying(255),
    v4 character varying(255),
    v5 character varying(255)
);


ALTER TABLE public.casbin_rule OWNER TO uudex_user;

--
-- Name: casbin_rule_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.casbin_rule_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.casbin_rule_id_seq OWNER TO uudex_user;

--
-- Name: casbin_rule_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.casbin_rule_id_seq OWNED BY public.casbin_rule.id;


--
-- Name: contact; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.contact (
    contact_id integer NOT NULL,
    contact_name character varying(30) NOT NULL,
    contact_number character varying(15) NOT NULL,
    participant_id integer NOT NULL
);


ALTER TABLE public.contact OWNER TO uudex_user;

--
-- Name: contact_contact_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.contact_contact_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.contact_contact_id_seq OWNER TO uudex_user;

--
-- Name: contact_contact_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.contact_contact_id_seq OWNED BY public.contact.contact_id;


--
-- Name: dataset; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.dataset (
    dataset_id integer NOT NULL,
    dataset_uuid character(36) NOT NULL,
    dataset_name character varying(255) NOT NULL,
    description character varying(255) NOT NULL,
    properties character varying(1024),
    payload bytea NOT NULL,
    payload_size integer NOT NULL,
    payload_md5_hash character(32) NOT NULL,
    payload_compression_algorithm character varying(15) NOT NULL,
    version_number integer NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    owner_participant_id integer NOT NULL,
    subject_id integer NOT NULL,
    CONSTRAINT dataset_payload_compression_algorithm_check CHECK (((payload_compression_algorithm)::text = ANY ((ARRAY['LZMA'::character varying, 'NONE'::character varying, 'AVRO'::character varying])::text[])))
);


ALTER TABLE public.dataset OWNER TO uudex_user;

--
-- Name: dataset_dataset_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.dataset_dataset_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dataset_dataset_id_seq OWNER TO uudex_user;

--
-- Name: dataset_dataset_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.dataset_dataset_id_seq OWNED BY public.dataset.dataset_id;


--
-- Name: dataset_definition; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.dataset_definition (
    dataset_definition_id integer NOT NULL,
    dataset_definition_uuid character(36) NOT NULL,
    dataset_definition_name character varying(100) NOT NULL,
    description character varying(255),
    schema character varying(32768),
    create_datetime timestamp without time zone NOT NULL
);


ALTER TABLE public.dataset_definition OWNER TO uudex_user;

--
-- Name: dataset_definition_dataset_definition_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.dataset_definition_dataset_definition_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dataset_definition_dataset_definition_id_seq OWNER TO uudex_user;

--
-- Name: dataset_definition_dataset_definition_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.dataset_definition_dataset_definition_id_seq OWNED BY public.dataset_definition.dataset_definition_id;


--
-- Name: endpoint; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.endpoint (
    endpoint_id integer NOT NULL,
    endpoint_uuid character(36) NOT NULL,
    endpoint_user_name character varying(30) NOT NULL,
    certificate_dn character varying(255) NOT NULL,
    description character varying(255),
    active_sw character(1) NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    participant_id integer NOT NULL,
    CONSTRAINT endpoint_active_sw_check CHECK ((upper((active_sw)::text) = ANY (ARRAY['Y'::text, 'N'::text])))
);


ALTER TABLE public.endpoint OWNER TO uudex_user;

--
-- Name: endpoint_endpoint_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.endpoint_endpoint_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.endpoint_endpoint_id_seq OWNER TO uudex_user;

--
-- Name: endpoint_endpoint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.endpoint_endpoint_id_seq OWNED BY public.endpoint.endpoint_id;


--
-- Name: grant_scope; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.grant_scope (
    grant_scope_id integer NOT NULL,
    grant_scope_name character varying(40),
    CONSTRAINT grant_scope_grant_scope_name_check CHECK ((upper((grant_scope_name)::text) = ANY (ARRAY['ALLOW_ONLY'::text, 'ALLOW_EXCEPT'::text, 'ALLOW_ALL'::text, 'ALLOW_NONE'::text])))
);


ALTER TABLE public.grant_scope OWNER TO uudex_user;

--
-- Name: participant; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.participant (
    participant_id integer NOT NULL,
    participant_uuid character(36) NOT NULL,
    participant_short_name character varying(25) NOT NULL,
    participant_long_name character varying(50) NOT NULL,
    description character varying(255),
    root_org_sw character(1) NOT NULL,
    active_sw character(1) NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    CONSTRAINT participant_active_sw_check CHECK ((active_sw = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
    CONSTRAINT participant_root_org_sw_check CHECK ((upper((root_org_sw)::text) = ANY (ARRAY['Y'::text, 'N'::text])))
);


ALTER TABLE public.participant OWNER TO uudex_user;

--
-- Name: participant_participant_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.participant_participant_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.participant_participant_id_seq OWNER TO uudex_user;

--
-- Name: participant_participant_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.participant_participant_id_seq OWNED BY public.participant.participant_id;


--
-- Name: privilege_allowed; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.privilege_allowed (
    privilege_allowed_id integer NOT NULL,
    privilege_allowed_name character varying(40),
    CONSTRAINT privilege_allowed_privilege_allowed_name_check CHECK ((upper((privilege_allowed_name)::text) = ANY (ARRAY['BROADEST_ALLOWED_PUBLISHER_ACCESS'::text, 'BROADEST_ALLOWED_SUBSCRIBER_ACCESS'::text, 'BROADEST_ALLOWED_MANAGER_ACCESS'::text])))
);


ALTER TABLE public.privilege_allowed OWNER TO uudex_user;

--
-- Name: subject; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.subject (
    subject_id integer NOT NULL,
    subject_uuid character(36) NOT NULL,
    subject_name character varying(300) NOT NULL,
    dataset_instance_key character varying(100) NOT NULL,
    description character varying(300),
    subscription_type character(20) NOT NULL,
    fulfillment_types_available character varying(15) NOT NULL,
    full_queue_behavior character varying(20),
    max_queue_size_kb integer,
    max_message_count integer,
    priority integer,
    backing_exchange_name character varying(300),
    create_datetime timestamp without time zone NOT NULL,
    owner_participant_id integer NOT NULL,
    dataset_definition_id integer NOT NULL,
    CONSTRAINT subject_fulfillment_types_available_check CHECK ((upper((fulfillment_types_available)::text) = ANY (ARRAY['DATA_PUSH'::text, 'DATA_NOTIFY'::text, 'BOTH'::text]))),
    CONSTRAINT subject_full_queue_behavior_check CHECK ((upper((full_queue_behavior)::text) = ANY (ARRAY['BLOCK_NEW'::text, 'PURGE_OLD'::text, 'NO_CONSTRAINT'::text]))),
    CONSTRAINT subject_subscription_type_check CHECK ((upper((subscription_type)::text) = ANY (ARRAY['MEASUREMENT_VALUES'::text, 'EVENT'::text])))
);


ALTER TABLE public.subject OWNER TO uudex_user;

--
-- Name: subject_policy; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.subject_policy (
    subject_policy_id integer NOT NULL,
    subject_policy_uuid character(36) NOT NULL,
    subject_policy_type character varying(25) NOT NULL,
    subject_policy_type_sort integer NOT NULL,
    action character varying(10) NOT NULL,
    full_queue_behavior character varying(20),
    max_queue_size_kb integer,
    max_message_count integer,
    max_priority integer,
    target_participant_id integer,
    dataset_definition_id integer,
    CONSTRAINT subject_policy_action_check CHECK ((upper((action)::text) = ANY (ARRAY['ALLOW'::text, 'DENY'::text, 'REVIEW'::text]))),
    CONSTRAINT subject_policy_full_queue_behavior_check CHECK ((upper((full_queue_behavior)::text) = ANY (ARRAY['BLOCK_NEW'::text, 'PURGE_OLD'::text, 'NO_CONSTRAINT'::text]))),
    CONSTRAINT subject_policy_subject_policy_type_check CHECK ((upper((subject_policy_type)::text) = ANY (ARRAY['PARTICIPANT_AND_DATASET'::text, 'PARTICIPANT'::text, 'DATASET'::text, 'GLOBAL_DEFAULT'::text]))),
    CONSTRAINT subject_policy_subject_policy_type_sort_check CHECK ((subject_policy_type_sort = ANY (ARRAY[1, 2, 3, 4])))
);


ALTER TABLE public.subject_policy OWNER TO uudex_user;

--
-- Name: subject_policy_acl_constraint; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.subject_policy_acl_constraint (
    subject_policy_acl_constraint_id integer NOT NULL,
    subject_policy_id integer NOT NULL,
    privilege_allowed_id integer NOT NULL,
    grant_scope_id integer NOT NULL
);


ALTER TABLE public.subject_policy_acl_constraint OWNER TO uudex_user;

--
-- Name: subject_policy_acl_constraint_subject_policy_acl_constraint_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.subject_policy_acl_constraint_subject_policy_acl_constraint_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subject_policy_acl_constraint_subject_policy_acl_constraint_seq OWNER TO uudex_user;

--
-- Name: subject_policy_acl_constraint_subject_policy_acl_constraint_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.subject_policy_acl_constraint_subject_policy_acl_constraint_seq OWNED BY public.subject_policy_acl_constraint.subject_policy_acl_constraint_id;


--
-- Name: subject_policy_grant_allowed; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.subject_policy_grant_allowed (
    sp_grant_allowed_id integer NOT NULL,
    object_uuid character(36) NOT NULL,
    object_type character(1) NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    subject_policy_acl_constraint_id integer NOT NULL,
    CONSTRAINT subject_policy_grant_allowed_object_type_check CHECK ((lower((object_type)::text) = ANY (ARRAY['e'::text, 'p'::text, 'g'::text, 'r'::text])))
);


ALTER TABLE public.subject_policy_grant_allowed OWNER TO uudex_user;

--
-- Name: subject_policy_grant_allowed_sp_grant_allowed_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.subject_policy_grant_allowed_sp_grant_allowed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subject_policy_grant_allowed_sp_grant_allowed_id_seq OWNER TO uudex_user;

--
-- Name: subject_policy_grant_allowed_sp_grant_allowed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.subject_policy_grant_allowed_sp_grant_allowed_id_seq OWNED BY public.subject_policy_grant_allowed.sp_grant_allowed_id;


--
-- Name: subject_policy_subject_policy_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.subject_policy_subject_policy_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subject_policy_subject_policy_id_seq OWNER TO uudex_user;

--
-- Name: subject_policy_subject_policy_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.subject_policy_subject_policy_id_seq OWNED BY public.subject_policy.subject_policy_id;


--
-- Name: subject_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.subject_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subject_subject_id_seq OWNER TO uudex_user;

--
-- Name: subject_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.subject_subject_id_seq OWNED BY public.subject.subject_id;


--
-- Name: subscription; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.subscription (
    subscription_id integer NOT NULL,
    subscription_uuid character(36) NOT NULL,
    subscription_name character varying(30) NOT NULL,
    subscription_state character varying(10) NOT NULL,
    create_datetime timestamp without time zone NOT NULL,
    owner_endpoint_id integer NOT NULL,
    CONSTRAINT subscription_subscription_state_check CHECK (((subscription_state)::text = ANY ((ARRAY['ACTIVE'::character varying, 'PAUSED'::character varying])::text[])))
);


ALTER TABLE public.subscription OWNER TO uudex_user;

--
-- Name: subscription_subject; Type: TABLE; Schema: public; Owner: uudex_user
--

CREATE TABLE public.subscription_subject (
    subscription_subject_id integer NOT NULL,
    preferred_fulfillment_type character varying(15) NOT NULL,
    backing_queue_name character varying(255),
    subject_id integer NOT NULL,
    subscription_id integer NOT NULL,
    CONSTRAINT subscription_subject_preferred_fulfillment_type_check CHECK ((upper((preferred_fulfillment_type)::text) = ANY (ARRAY['DATA_PUSH'::text, 'DATA_NOTIFY'::text])))
);


ALTER TABLE public.subscription_subject OWNER TO uudex_user;

--
-- Name: subscription_subject_subscription_subject_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.subscription_subject_subscription_subject_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_subject_subscription_subject_id_seq OWNER TO uudex_user;

--
-- Name: subscription_subject_subscription_subject_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.subscription_subject_subscription_subject_id_seq OWNED BY public.subscription_subject.subscription_subject_id;


--
-- Name: subscription_subscription_id_seq; Type: SEQUENCE; Schema: public; Owner: uudex_user
--

CREATE SEQUENCE public.subscription_subscription_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.subscription_subscription_id_seq OWNER TO uudex_user;

--
-- Name: subscription_subscription_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: uudex_user
--

ALTER SEQUENCE public.subscription_subscription_id_seq OWNED BY public.subscription.subscription_id;


--
-- Name: auth_group group_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.auth_group ALTER COLUMN group_id SET DEFAULT nextval('public.auth_group_group_id_seq'::regclass);


--
-- Name: auth_role role_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.auth_role ALTER COLUMN role_id SET DEFAULT nextval('public.auth_role_role_id_seq'::regclass);


--
-- Name: casbin_rule id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.casbin_rule ALTER COLUMN id SET DEFAULT nextval('public.casbin_rule_id_seq'::regclass);


--
-- Name: contact contact_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.contact ALTER COLUMN contact_id SET DEFAULT nextval('public.contact_contact_id_seq'::regclass);


--
-- Name: dataset dataset_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.dataset ALTER COLUMN dataset_id SET DEFAULT nextval('public.dataset_dataset_id_seq'::regclass);


--
-- Name: dataset_definition dataset_definition_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.dataset_definition ALTER COLUMN dataset_definition_id SET DEFAULT nextval('public.dataset_definition_dataset_definition_id_seq'::regclass);


--
-- Name: endpoint endpoint_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.endpoint ALTER COLUMN endpoint_id SET DEFAULT nextval('public.endpoint_endpoint_id_seq'::regclass);


--
-- Name: participant participant_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.participant ALTER COLUMN participant_id SET DEFAULT nextval('public.participant_participant_id_seq'::regclass);


--
-- Name: subject subject_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject ALTER COLUMN subject_id SET DEFAULT nextval('public.subject_subject_id_seq'::regclass);


--
-- Name: subject_policy subject_policy_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy ALTER COLUMN subject_policy_id SET DEFAULT nextval('public.subject_policy_subject_policy_id_seq'::regclass);


--
-- Name: subject_policy_acl_constraint subject_policy_acl_constraint_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy_acl_constraint ALTER COLUMN subject_policy_acl_constraint_id SET DEFAULT nextval('public.subject_policy_acl_constraint_subject_policy_acl_constraint_seq'::regclass);


--
-- Name: subject_policy_grant_allowed sp_grant_allowed_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy_grant_allowed ALTER COLUMN sp_grant_allowed_id SET DEFAULT nextval('public.subject_policy_grant_allowed_sp_grant_allowed_id_seq'::regclass);


--
-- Name: subscription subscription_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subscription ALTER COLUMN subscription_id SET DEFAULT nextval('public.subscription_subscription_id_seq'::regclass);


--
-- Name: subscription_subject subscription_subject_id; Type: DEFAULT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subscription_subject ALTER COLUMN subscription_subject_id SET DEFAULT nextval('public.subscription_subject_subscription_subject_id_seq'::regclass);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.auth_group (group_id, group_uuid, group_name, description, create_datetime) FROM stdin;
1	61c080e5-c998-5dd9-bcc0-10062607650d	public	Built-in internal public group	2021-07-26 19:30:04
\.


--
-- Data for Name: auth_role; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.auth_role (role_id, role_uuid, role_name, description, create_datetime) FROM stdin;
1	3b185221-8867-4845-8754-5db30715791b	UUDEXAdmin	Built-in role that provides super-user access to the UUDEX instance	2021-07-26 19:49:39
2	a5c302cf-af34-4d10-a90a-c7677af57772	ParticipantAdmin	Built-in role that provides the ability to manage a participant	2021-07-26 19:50:06
3	2d3f389e-1d07-4aa0-8429-b1cd74e78099	SubjectAdmin	Built-in role that allows for the management of all subjects owned by participant	2021-07-26 19:51:39
4	9fa4c741-b9be-4a66-b714-195830865bb9	RoleAdmin	Built-in role that allows granting and revoking roles to the participant's endpoints	2021-07-26 19:52:34
\.


--
-- Data for Name: casbin_rule; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.casbin_rule (id, ptype, v0, v1, v2, v3, v4, v5) FROM stdin;
\.


--
-- Data for Name: contact; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.contact (contact_id, contact_name, contact_number, participant_id) FROM stdin;
\.


--
-- Data for Name: dataset; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.dataset (dataset_id, dataset_uuid, dataset_name, description, properties, payload, payload_size, payload_md5_hash, payload_compression_algorithm, version_number, create_datetime, owner_participant_id, subject_id) FROM stdin;
\.


--
-- Data for Name: dataset_definition; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.dataset_definition (dataset_definition_id, dataset_definition_uuid, dataset_definition_name, description, schema, create_datetime) FROM stdin;
2	68ce654c-a94e-4d3b-879a-fae76fa8963f	StatusDataset	CHESS node status	\N	2024-06-10 15:08:05.020946
1	68ce654c-a94e-4d3b-879a-fae76fa8963e	TelemetryDataset	Telemetry data	\N	2024-06-06 16:13:00.363453
\.


--
-- Data for Name: endpoint; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.endpoint (endpoint_id, endpoint_uuid, endpoint_user_name, certificate_dn, description, active_sw, create_datetime, participant_id) FROM stdin;
1	4b3b819e-94bd-4adf-b461-17ccb58ac870	active_sw_1	4b3b819e-94bd-4adf-b461-17ccb58ac870__app_rt_1	test	Y	2024-05-16 12:55:10.657121	1
2	4b3b819e-94bd-4adf-b461-17ccb58ac871	CHESSNode_1	*.umbrellaiot.com	CHESS Node	Y	2024-06-07 13:46:17.026719	2
3	4b3b819e-94bd-4adf-b461-17ccb58ac872	CHESSNode_2	cLtJVPhoOIhL33bZPIMoo9ShquYa.flexchess.com	CHESS Node	Y	2024-06-20 14:34:36.302122	3
4	4b3b819e-94bd-4adf-b461-17ccb58ac873	CHESSNode_3	AF7mlFj7ZH55hvoJ8k4Kl8owdY0a.flexchess.com	CHESS Node	Y	2024-06-20 14:35:56.422477	3
\.


--
-- Data for Name: grant_scope; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.grant_scope (grant_scope_id, grant_scope_name) FROM stdin;
1	ALLOW_ONLY
2	ALLOW_EXCEPT
3	ALLOW_ALL
4	ALLOW_NONE
\.


--
-- Data for Name: participant; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.participant (participant_id, participant_uuid, participant_short_name, participant_long_name, description, root_org_sw, active_sw, create_datetime) FROM stdin;
1	7ade620d-ab36-549a-8e7d-12ffcfee4900	TEST	TEST 123	testing	Y	Y	2024-05-16 12:55:03.647566
2	7ade620d-ab36-549a-8e7d-12ffcfee4901	CHESS Node	FlexCHESS CHESS Node version 1.0	CHESS node in VM	Y	Y	2024-06-07 13:46:09.314687
3	7ade620d-ab36-549a-8e7d-12ffcfee4902	AAServer	FlexCHESS CHESSNode v1	CHESS NODE	Y	Y	2024-06-20 14:32:58.117431
\.


--
-- Data for Name: privilege_allowed; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.privilege_allowed (privilege_allowed_id, privilege_allowed_name) FROM stdin;
1	BROADEST_ALLOWED_PUBLISHER_ACCESS
2	BROADEST_ALLOWED_SUBSCRIBER_ACCESS
3	BROADEST_ALLOWED_MANAGER_ACCESS
\.


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.subject (subject_id, subject_uuid, subject_name, dataset_instance_key, description, subscription_type, fulfillment_types_available, full_queue_behavior, max_queue_size_kb, max_message_count, priority, backing_exchange_name, create_datetime, owner_participant_id, dataset_definition_id) FROM stdin;
84	2be612b6-12d1-4ae1-9a6f-c9a5bc7734c4	es-huaweibess-bu32-chess1-simtelemetry	es-huaweibess-bu32-chess1-sim	Subject For CHESS	MEASUREMENT_VALUES  	DATA_PUSH	\N	\N	\N	\N	e_es-huaweibess-bu32-chess1-simtelemetry_2be612b6-12d1-4ae1-9a6f-c9a5bc7734c4	2024-09-09 11:01:59.626502	3	2
85	62be1f35-d769-471a-b959-83e36e34d8ce	es-huaweibess-bu32-chess1-sim	es-huaweibess-bu32-chess1-sim	Status For CHESS	MEASUREMENT_VALUES  	DATA_PUSH	\N	\N	\N	\N	e_es-huaweibess-bu32-chess1-sim_62be1f35-d769-471a-b959-83e36e34d8ce	2024-09-09 11:01:59.993299	3	1
86	69ff45ad-7031-451b-8db6-7fcb7bc56250	it-hvac-blg1-chess2-simtelemetry	it-hvac-blg1-chess2-sim	Subject For CHESS	MEASUREMENT_VALUES  	DATA_PUSH	\N	\N	\N	\N	e_it-hvac-blg1-chess2-simtelemetry_69ff45ad-7031-451b-8db6-7fcb7bc56250	2024-09-09 11:06:38.856329	3	2
87	1c047960-01c1-4fe8-9140-00dc0ef38307	it-hvac-blg1-chess2-sim	it-hvac-blg1-chess2-sim	Status For CHESS	MEASUREMENT_VALUES  	DATA_PUSH	\N	\N	\N	\N	e_it-hvac-blg1-chess2-sim_1c047960-01c1-4fe8-9140-00dc0ef38307	2024-09-09 11:06:39.340007	3	1
88	3dc8b4b8-d1bd-4240-bd6c-90cacef4e7f6	it-hvac-blg1-chess1-simtelemetry	it-hvac-blg1-chess1-sim	Subject For CHESS	MEASUREMENT_VALUES  	DATA_PUSH	\N	\N	\N	\N	e_it-hvac-blg1-chess1-simtelemetry_3dc8b4b8-d1bd-4240-bd6c-90cacef4e7f6	2024-10-03 15:59:13.571464	3	2
89	50d23f5f-447b-499e-b7d3-2b0b3abbfa7a	it-hvac-blg1-chess1-sim	it-hvac-blg1-chess1-sim	Status For CHESS	MEASUREMENT_VALUES  	DATA_PUSH	\N	\N	\N	\N	e_it-hvac-blg1-chess1-sim_50d23f5f-447b-499e-b7d3-2b0b3abbfa7a	2024-10-03 15:59:13.931997	3	1
93	88e5a8f7-7533-4df1-8d0c-8acb55fe8fd3	it-bess-blg1-chess1-simtelemetry	it-bess-blg1-chess1-sim	Subject For CHESS	MEASUREMENT_VALUES  	DATA_PUSH	\N	\N	\N	\N	e_it-bess-blg1-chess1-simtelemetry_88e5a8f7-7533-4df1-8d0c-8acb55fe8fd3	2024-10-18 10:16:01.112632	3	2
94	8b447d62-b628-4f00-9e36-1f5d876bcf28	it-bess-blg1-chess1-sim	it-bess-blg1-chess1-sim	Status For CHESS	MEASUREMENT_VALUES  	DATA_PUSH	\N	\N	\N	\N	e_it-bess-blg1-chess1-sim_8b447d62-b628-4f00-9e36-1f5d876bcf28	2024-10-18 10:16:01.57471	3	1
\.


--
-- Data for Name: subject_policy; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.subject_policy (subject_policy_id, subject_policy_uuid, subject_policy_type, subject_policy_type_sort, action, full_queue_behavior, max_queue_size_kb, max_message_count, max_priority, target_participant_id, dataset_definition_id) FROM stdin;
\.


--
-- Data for Name: subject_policy_acl_constraint; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.subject_policy_acl_constraint (subject_policy_acl_constraint_id, subject_policy_id, privilege_allowed_id, grant_scope_id) FROM stdin;
\.


--
-- Data for Name: subject_policy_grant_allowed; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.subject_policy_grant_allowed (sp_grant_allowed_id, object_uuid, object_type, create_datetime, subject_policy_acl_constraint_id) FROM stdin;
\.


--
-- Data for Name: subscription; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.subscription (subscription_id, subscription_uuid, subscription_name, subscription_state, create_datetime, owner_endpoint_id) FROM stdin;
533	12d100b3-fbbb-477c-ab8f-7a8b251fa9f6	00c9792c68b5AASServer	ACTIVE	2024-08-30 16:07:25.79125	3
534	4c6a4c6d-0650-4d72-9f22-795e1ff6fd56	d3fc2606edabAASServer	ACTIVE	2024-08-30 16:07:26.823548	3
535	b3cf6a6e-9046-4f51-a176-0640be483d64	2cb010f7fb2eAASServer	ACTIVE	2024-08-30 16:07:41.806311	3
536	d4653ed7-4983-40b5-b9e8-741bf782aa7b	387cd63188d6AASServer	ACTIVE	2024-08-30 16:08:05.810867	3
537	999559e2-40b0-44f4-b10f-3a0ff8493456	639c707f124dAASServer	ACTIVE	2024-08-30 16:08:47.908245	3
538	2eb297c5-dd98-4d8b-bf79-e27616445513	4ba744c97a01AASServer	ACTIVE	2024-08-30 16:10:10.84569	3
539	e958c6ae-29a9-45c6-9385-4d4bd069c643	CHESSNode22f7a7603f6eCHESSNode	ACTIVE	2024-08-30 16:10:53.874303	3
540	cbbdce70-67c2-43d5-abd9-a20775595ef7	14914d87c690AASServer	ACTIVE	2024-08-30 16:13:05.975234	3
541	f48ad554-7a63-40cc-8776-e6d9ca88aef3	CHESSNodea50cce595a8bCHESSNode	ACTIVE	2024-08-30 16:16:06.836956	3
542	3601905b-cc21-481e-a939-f5658bb0f86d	ac1c093776d6AASServer	ACTIVE	2024-08-30 16:18:21.882596	3
543	be043893-06d3-44a9-ba12-70274aaadac5	f7453bed187eAASServer	ACTIVE	2024-08-30 16:19:23.020988	3
544	57d6252c-26df-4c22-8627-887071a708c7	aa3b13122ff9AASServer	ACTIVE	2024-08-30 16:19:25.277383	3
545	f9a3ace9-3e13-4c2c-abb4-b05529250e5e	CHESSNode10cdc3f2ebd8CHESSNode	ACTIVE	2024-08-30 16:19:33.373	3
546	2a024970-30ed-4fe9-a283-547e4e23607c	CHESSNode5976472e55e8CHESSNode	ACTIVE	2024-08-30 16:19:36.20295	3
547	918fdea9-5368-447b-94fa-6d3df7328cb7	9adf8e4fe86bAASServer	ACTIVE	2024-08-30 16:19:39.771846	3
548	fdc009b0-8587-4338-91cb-c1b1dbdbb95b	CHESSNode47eddce96798CHESSNode	ACTIVE	2024-08-30 16:19:52.814677	3
549	0ccce5e5-4c56-4179-a038-df4d47e235a5	ed91e2215521AASServer	ACTIVE	2024-08-30 16:20:06.803367	3
550	ad431438-18fd-4081-ae8a-c8686a792c58	CHESSNodebf3149683090CHESSNode	ACTIVE	2024-08-30 16:20:22.762797	3
551	4caaf78f-55e0-445b-969c-cc4327e62c00	14c443d345c1AASServer	ACTIVE	2024-08-30 16:20:58.888963	3
552	e180650c-4a2e-47fa-8766-278e8becadcc	CHESSNode8778b5eea8c7CHESSNode	ACTIVE	2024-08-30 16:21:17.863348	3
553	fb0538aa-7845-4cad-a564-0cc8ba0398a9	2a65275faf59AASServer	ACTIVE	2024-08-30 16:22:09.551134	3
554	a37c7f24-82c9-4b1d-ac19-03215ee84d13	CHESSNode6883ebd8beabCHESSNode	ACTIVE	2024-08-30 16:22:23.527506	3
555	0782f776-e4dc-4f3b-b487-298ce157675f	80bd4240c5d1AASServer	ACTIVE	2024-09-06 15:58:12.907132	3
556	d6454578-5da3-46b3-b7f6-61d0ae90c212	CHESSNode19307043860aCHESSNode	ACTIVE	2024-10-03 15:57:53.531215	3
\.


--
-- Data for Name: subscription_subject; Type: TABLE DATA; Schema: public; Owner: uudex_user
--

COPY public.subscription_subject (subscription_subject_id, preferred_fulfillment_type, backing_queue_name, subject_id, subscription_id) FROM stdin;
690	DATA_PUSH	q_CHESSNode_2_es-huaweibess-bu32-chess1-simtelemetry_fb0538aa-7845-4cad-a564-0cc8ba0398a9	84	553
691	DATA_PUSH	q_CHESSNode_2_es-huaweibess-bu32-chess1-sim_a37c7f24-82c9-4b1d-ac19-03215ee84d13	85	554
692	DATA_PUSH	q_CHESSNode_2_it-hvac-blg1-chess2-simtelemetry_fb0538aa-7845-4cad-a564-0cc8ba0398a9	86	553
693	DATA_PUSH	q_CHESSNode_2_it-hvac-blg1-chess2-sim_a37c7f24-82c9-4b1d-ac19-03215ee84d13	87	554
694	DATA_PUSH	q_CHESSNode_2_it-hvac-blg1-chess1-simtelemetry_fb0538aa-7845-4cad-a564-0cc8ba0398a9	88	553
695	DATA_PUSH	q_CHESSNode_2_it-hvac-blg1-chess1-sim_d6454578-5da3-46b3-b7f6-61d0ae90c212	89	556
696	DATA_PUSH	q_CHESSNode_2_it-hvac-blg1-chess2-sim_d6454578-5da3-46b3-b7f6-61d0ae90c212	87	556
697	DATA_PUSH	q_CHESSNode_2_es-huaweibess-bu32-chess1-sim_d6454578-5da3-46b3-b7f6-61d0ae90c212	85	556
699	DATA_PUSH	q_CHESSNode_2_it-bess-blg1-chess1-simtelemetry_fb0538aa-7845-4cad-a564-0cc8ba0398a9	93	553
700	DATA_PUSH	q_CHESSNode_2_it-bess-blg1-chess1-sim_d6454578-5da3-46b3-b7f6-61d0ae90c212	94	556
\.


--
-- Name: auth_group_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.auth_group_group_id_seq', 1, false);


--
-- Name: auth_role_role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.auth_role_role_id_seq', 1, false);


--
-- Name: casbin_rule_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.casbin_rule_id_seq', 1, false);


--
-- Name: contact_contact_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.contact_contact_id_seq', 1, false);


--
-- Name: dataset_dataset_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.dataset_dataset_id_seq', 1, false);


--
-- Name: dataset_definition_dataset_definition_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.dataset_definition_dataset_definition_id_seq', 1, true);


--
-- Name: endpoint_endpoint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.endpoint_endpoint_id_seq', 1, false);


--
-- Name: participant_participant_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.participant_participant_id_seq', 1, false);


--
-- Name: subject_policy_acl_constraint_subject_policy_acl_constraint_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.subject_policy_acl_constraint_subject_policy_acl_constraint_seq', 1, false);


--
-- Name: subject_policy_grant_allowed_sp_grant_allowed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.subject_policy_grant_allowed_sp_grant_allowed_id_seq', 1, false);


--
-- Name: subject_policy_subject_policy_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.subject_policy_subject_policy_id_seq', 1, false);


--
-- Name: subject_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.subject_subject_id_seq', 94, true);


--
-- Name: subscription_subject_subscription_subject_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.subscription_subject_subscription_subject_id_seq', 700, true);


--
-- Name: subscription_subscription_id_seq; Type: SEQUENCE SET; Schema: public; Owner: uudex_user
--

SELECT pg_catalog.setval('public.subscription_subscription_id_seq', 556, true);


--
-- Name: casbin_rule casbin_rule_pkey; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.casbin_rule
    ADD CONSTRAINT casbin_rule_pkey PRIMARY KEY (id);


--
-- Name: auth_group pk_auth_group; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT pk_auth_group PRIMARY KEY (group_id);


--
-- Name: auth_role pk_auth_role; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.auth_role
    ADD CONSTRAINT pk_auth_role PRIMARY KEY (role_id);


--
-- Name: contact pk_contact; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT pk_contact PRIMARY KEY (contact_id);


--
-- Name: dataset pk_dataset; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT pk_dataset PRIMARY KEY (dataset_id);


--
-- Name: dataset_definition pk_dataset_definition; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.dataset_definition
    ADD CONSTRAINT pk_dataset_definition PRIMARY KEY (dataset_definition_id);


--
-- Name: endpoint pk_endpoint; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.endpoint
    ADD CONSTRAINT pk_endpoint PRIMARY KEY (endpoint_id);


--
-- Name: participant pk_participant; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.participant
    ADD CONSTRAINT pk_participant PRIMARY KEY (participant_id);


--
-- Name: grant_scope pk_permission_target_type; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.grant_scope
    ADD CONSTRAINT pk_permission_target_type PRIMARY KEY (grant_scope_id);


--
-- Name: privilege_allowed pk_privilege_constraint; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.privilege_allowed
    ADD CONSTRAINT pk_privilege_constraint PRIMARY KEY (privilege_allowed_id);


--
-- Name: subject_policy_acl_constraint pk_scp_constraint; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy_acl_constraint
    ADD CONSTRAINT pk_scp_constraint PRIMARY KEY (subject_policy_acl_constraint_id);


--
-- Name: subject_policy_grant_allowed pk_scp_permission_target; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy_grant_allowed
    ADD CONSTRAINT pk_scp_permission_target PRIMARY KEY (sp_grant_allowed_id);


--
-- Name: subject pk_subject; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT pk_subject PRIMARY KEY (subject_id);


--
-- Name: subject_policy pk_subject_creation_policy; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy
    ADD CONSTRAINT pk_subject_creation_policy PRIMARY KEY (subject_policy_id);


--
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (subscription_id);


--
-- Name: subscription_subject pk_subscription_subject; Type: CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subscription_subject
    ADD CONSTRAINT pk_subscription_subject PRIMARY KEY (subscription_subject_id);


--
-- Name: Ref164; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref164" ON public.subscription USING btree (owner_endpoint_id);


--
-- Name: Ref1829; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref1829" ON public.endpoint USING btree (participant_id);


--
-- Name: Ref1848; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref1848" ON public.contact USING btree (participant_id);


--
-- Name: Ref1852; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref1852" ON public.dataset USING btree (owner_participant_id);


--
-- Name: Ref1860; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref1860" ON public.subject USING btree (owner_participant_id);


--
-- Name: Ref1869; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref1869" ON public.subject_policy USING btree (target_participant_id);


--
-- Name: Ref2882; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref2882" ON public.subject_policy_acl_constraint USING btree (privilege_allowed_id);


--
-- Name: Ref3183; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref3183" ON public.subject_policy_acl_constraint USING btree (grant_scope_id);


--
-- Name: Ref3271; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref3271" ON public.subject_policy_acl_constraint USING btree (subject_policy_id);


--
-- Name: Ref3381; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref3381" ON public.subject_policy_grant_allowed USING btree (subject_policy_acl_constraint_id);


--
-- Name: Ref345; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref345" ON public.dataset USING btree (subject_id);


--
-- Name: Ref358; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref358" ON public.subscription_subject USING btree (subject_id);


--
-- Name: Ref4396; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref4396" ON public.subject_policy USING btree (dataset_definition_id);


--
-- Name: Ref4397; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref4397" ON public.subject USING btree (dataset_definition_id);


--
-- Name: Ref527; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE INDEX "Ref527" ON public.subscription_subject USING btree (subscription_id);


--
-- Name: scp_constraint_uk_1; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX scp_constraint_uk_1 ON public.subject_policy_acl_constraint USING btree (subject_policy_id, privilege_allowed_id);


--
-- Name: uk_auth_group_1; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_auth_group_1 ON public.auth_group USING btree (group_uuid);


--
-- Name: uk_auth_group_2; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_auth_group_2 ON public.auth_group USING btree (group_name);


--
-- Name: uk_auth_role2; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_auth_role2 ON public.auth_role USING btree (role_name);


--
-- Name: uk_auth_role_1; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_auth_role_1 ON public.auth_role USING btree (role_uuid);


--
-- Name: uk_dataset_1; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_dataset_1 ON public.dataset USING btree (dataset_uuid);


--
-- Name: uk_dataset_definition_1; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_dataset_definition_1 ON public.dataset_definition USING btree (dataset_definition_uuid);


--
-- Name: uk_dataset_definition_2; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_dataset_definition_2 ON public.dataset_definition USING btree (dataset_definition_name);


--
-- Name: uk_endpoint_1; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_endpoint_1 ON public.endpoint USING btree (certificate_dn);


--
-- Name: uk_endpoint_2; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_endpoint_2 ON public.endpoint USING btree (endpoint_uuid);


--
-- Name: uk_participant_1; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_participant_1 ON public.participant USING btree (participant_uuid);


--
-- Name: uk_subject_1; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_subject_1 ON public.subject USING btree (subject_name);


--
-- Name: uk_subject_2; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_subject_2 ON public.subject USING btree (subject_uuid);


--
-- Name: uk_subject_creation_policy_1; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_subject_creation_policy_1 ON public.subject_policy USING btree (subject_policy_uuid);


--
-- Name: uk_subscription; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_subscription ON public.subscription USING btree (subscription_name, owner_endpoint_id);


--
-- Name: uk_subscription_2; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_subscription_2 ON public.subscription USING btree (subscription_uuid);


--
-- Name: uk_subscription_subject_1; Type: INDEX; Schema: public; Owner: uudex_user
--

CREATE UNIQUE INDEX uk_subscription_subject_1 ON public.subscription_subject USING btree (subscription_id, subject_id);


--
-- Name: subject_policy Refdataset_definition96; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy
    ADD CONSTRAINT "Refdataset_definition96" FOREIGN KEY (dataset_definition_id) REFERENCES public.dataset_definition(dataset_definition_id) ON DELETE CASCADE;


--
-- Name: subject Refdataset_definition97; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT "Refdataset_definition97" FOREIGN KEY (dataset_definition_id) REFERENCES public.dataset_definition(dataset_definition_id);


--
-- Name: subscription Refendpoint64; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subscription
    ADD CONSTRAINT "Refendpoint64" FOREIGN KEY (owner_endpoint_id) REFERENCES public.endpoint(endpoint_id) ON DELETE CASCADE;


--
-- Name: subject_policy_acl_constraint Refgrant_scope83; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy_acl_constraint
    ADD CONSTRAINT "Refgrant_scope83" FOREIGN KEY (grant_scope_id) REFERENCES public.grant_scope(grant_scope_id);


--
-- Name: endpoint Refparticipant29; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.endpoint
    ADD CONSTRAINT "Refparticipant29" FOREIGN KEY (participant_id) REFERENCES public.participant(participant_id) ON DELETE CASCADE;


--
-- Name: contact Refparticipant48; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.contact
    ADD CONSTRAINT "Refparticipant48" FOREIGN KEY (participant_id) REFERENCES public.participant(participant_id) ON DELETE CASCADE;


--
-- Name: dataset Refparticipant52; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT "Refparticipant52" FOREIGN KEY (owner_participant_id) REFERENCES public.participant(participant_id);


--
-- Name: subject Refparticipant60; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT "Refparticipant60" FOREIGN KEY (owner_participant_id) REFERENCES public.participant(participant_id);


--
-- Name: subject_policy Refparticipant69; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy
    ADD CONSTRAINT "Refparticipant69" FOREIGN KEY (target_participant_id) REFERENCES public.participant(participant_id);


--
-- Name: subject_policy_acl_constraint Refprivilege_allowed82; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy_acl_constraint
    ADD CONSTRAINT "Refprivilege_allowed82" FOREIGN KEY (privilege_allowed_id) REFERENCES public.privilege_allowed(privilege_allowed_id);


--
-- Name: dataset Refsubject45; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.dataset
    ADD CONSTRAINT "Refsubject45" FOREIGN KEY (subject_id) REFERENCES public.subject(subject_id);


--
-- Name: subscription_subject Refsubject58; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subscription_subject
    ADD CONSTRAINT "Refsubject58" FOREIGN KEY (subject_id) REFERENCES public.subject(subject_id) ON DELETE CASCADE;


--
-- Name: subject_policy_acl_constraint Refsubject_policy71; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy_acl_constraint
    ADD CONSTRAINT "Refsubject_policy71" FOREIGN KEY (subject_policy_id) REFERENCES public.subject_policy(subject_policy_id) ON DELETE CASCADE;


--
-- Name: subject_policy_grant_allowed Refsubject_policy_acl_constraint81; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subject_policy_grant_allowed
    ADD CONSTRAINT "Refsubject_policy_acl_constraint81" FOREIGN KEY (subject_policy_acl_constraint_id) REFERENCES public.subject_policy_acl_constraint(subject_policy_acl_constraint_id) ON DELETE CASCADE;


--
-- Name: subscription_subject Refsubscription27; Type: FK CONSTRAINT; Schema: public; Owner: uudex_user
--

ALTER TABLE ONLY public.subscription_subject
    ADD CONSTRAINT "Refsubscription27" FOREIGN KEY (subscription_id) REFERENCES public.subscription(subscription_id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

