--
-- PostgreSQL database cluster dump
--

-- Started on 2023-05-18 22:08:32

SET default_transaction_read_only = off;

SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;

--
-- Roles
--

CREATE ROLE cloud_admin;
ALTER ROLE cloud_admin WITH SUPERUSER INHERIT CREATEROLE CREATEDB LOGIN REPLICATION BYPASSRLS;
CREATE ROLE "default";
ALTER ROLE "default" WITH NOSUPERUSER INHERIT NOCREATEROLE NOCREATEDB LOGIN NOREPLICATION NOBYPASSRLS;

--
-- User Configurations
--


--
-- Role memberships
--

GRANT pg_read_all_data TO "default" GRANTED BY cloud_admin;
GRANT pg_write_all_data TO "default" GRANTED BY cloud_admin;






--
-- Databases
--

--
-- Database "template1" dump
--

\connect template1

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-05-18 22:08:34

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

-- Completed on 2023-05-18 22:08:53

--
-- PostgreSQL database dump complete
--

--
-- Database "postgres" dump
--

\connect postgres

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-05-18 22:08:53

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

--
-- TOC entry 2 (class 3079 OID 16386)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA public;


--
-- TOC entry 2558 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 32769)
-- Name: health_check; Type: TABLE; Schema: public; Owner: cloud_admin
--

CREATE TABLE public.health_check (
    id integer NOT NULL,
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.health_check OWNER TO cloud_admin;

--
-- TOC entry 217 (class 1259 OID 32768)
-- Name: health_check_id_seq; Type: SEQUENCE; Schema: public; Owner: cloud_admin
--

CREATE SEQUENCE public.health_check_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.health_check_id_seq OWNER TO cloud_admin;

--
-- TOC entry 2559 (class 0 OID 0)
-- Dependencies: 217
-- Name: health_check_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: cloud_admin
--

ALTER SEQUENCE public.health_check_id_seq OWNED BY public.health_check.id;


--
-- TOC entry 2403 (class 2604 OID 32772)
-- Name: health_check id; Type: DEFAULT; Schema: public; Owner: cloud_admin
--

ALTER TABLE ONLY public.health_check ALTER COLUMN id SET DEFAULT nextval('public.health_check_id_seq'::regclass);


--
-- TOC entry 2552 (class 0 OID 32769)
-- Dependencies: 218
-- Data for Name: health_check; Type: TABLE DATA; Schema: public; Owner: cloud_admin
--

COPY public.health_check (id, updated_at) FROM stdin;
1	2023-05-18 14:11:07.449779+00
\.


--
-- TOC entry 2560 (class 0 OID 0)
-- Dependencies: 217
-- Name: health_check_id_seq; Type: SEQUENCE SET; Schema: public; Owner: cloud_admin
--

SELECT pg_catalog.setval('public.health_check_id_seq', 1, false);


--
-- TOC entry 2406 (class 2606 OID 32775)
-- Name: health_check health_check_pkey; Type: CONSTRAINT; Schema: public; Owner: cloud_admin
--

ALTER TABLE ONLY public.health_check
    ADD CONSTRAINT health_check_pkey PRIMARY KEY (id);


-- Completed on 2023-05-18 22:09:23

--
-- PostgreSQL database dump complete
--

--
-- Database "verceldb" dump
--

--
-- PostgreSQL database dump
--

-- Dumped from database version 15.2
-- Dumped by pg_dump version 15.2

-- Started on 2023-05-18 22:09:23

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

--
-- TOC entry 3138 (class 1262 OID 16385)
-- Name: verceldb; Type: DATABASE; Schema: -; Owner: default
--

CREATE DATABASE verceldb WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'C';


ALTER DATABASE verceldb OWNER TO "default";

\connect verceldb

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

SET default_table_access_method = heap;

--
-- TOC entry 259 (class 1259 OID 25297)
-- Name: actions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.actions (
    id character varying(24) NOT NULL,
    resource_id character varying(24),
    resource_type character varying(50) NOT NULL,
    actor_id character varying(24) NOT NULL,
    actor_type character varying(50) NOT NULL,
    event character varying(50) NOT NULL,
    context text,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.actions OWNER TO "default";

--
-- TOC entry 233 (class 1259 OID 24850)
-- Name: api_keys; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.api_keys (
    id character varying(24) NOT NULL,
    type character varying(50) NOT NULL,
    secret character varying(191) NOT NULL,
    role_id character varying(24),
    integration_id character varying(24),
    user_id character varying(24),
    last_seen_at timestamp without time zone,
    last_seen_version character varying(50),
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.api_keys OWNER TO "default";

--
-- TOC entry 239 (class 1259 OID 24904)
-- Name: benefits; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.benefits (
    id character varying(24) NOT NULL,
    name character varying(191) NOT NULL,
    slug character varying(191) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.benefits OWNER TO "default";

--
-- TOC entry 229 (class 1259 OID 24816)
-- Name: brute; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.brute (
    key character varying(191) NOT NULL,
    firstrequest bigint NOT NULL,
    lastrequest bigint NOT NULL,
    lifetime bigint NOT NULL,
    count integer NOT NULL
);


ALTER TABLE public.brute OWNER TO "default";

--
-- TOC entry 269 (class 1259 OID 25502)
-- Name: comment_likes; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.comment_likes (
    id character varying(24) NOT NULL,
    comment_id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.comment_likes OWNER TO "default";

--
-- TOC entry 270 (class 1259 OID 25517)
-- Name: comment_reports; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.comment_reports (
    id character varying(24) NOT NULL,
    comment_id character varying(24) NOT NULL,
    member_id character varying(24),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.comment_reports OWNER TO "default";

--
-- TOC entry 268 (class 1259 OID 25479)
-- Name: comments; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.comments (
    id character varying(24) NOT NULL,
    post_id character varying(24) NOT NULL,
    member_id character varying(24),
    parent_id character varying(24),
    status character varying(50) DEFAULT 'published'::character varying NOT NULL,
    html text,
    edited_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.comments OWNER TO "default";

--
-- TOC entry 262 (class 1259 OID 25319)
-- Name: custom_theme_settings; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.custom_theme_settings (
    id character varying(24) NOT NULL,
    theme character varying(191) NOT NULL,
    key character varying(191) NOT NULL,
    type character varying(50) NOT NULL,
    value text
);


ALTER TABLE public.custom_theme_settings OWNER TO "default";

--
-- TOC entry 264 (class 1259 OID 25416)
-- Name: email_batches; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.email_batches (
    id character varying(24) NOT NULL,
    email_id character varying(24) NOT NULL,
    provider_id character varying(255),
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    member_segment text,
    error_status_code integer,
    error_message character varying(2000),
    error_data text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


ALTER TABLE public.email_batches OWNER TO "default";

--
-- TOC entry 266 (class 1259 OID 25446)
-- Name: email_recipient_failures; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.email_recipient_failures (
    id character varying(24) NOT NULL,
    email_id character varying(24) NOT NULL,
    member_id character varying(24),
    email_recipient_id character varying(24) NOT NULL,
    code integer NOT NULL,
    enhanced_code character varying(50),
    message character varying(2000) NOT NULL,
    severity character varying(50) DEFAULT 'permanent'::character varying NOT NULL,
    failed_at timestamp without time zone NOT NULL,
    event_id character varying(255)
);


ALTER TABLE public.email_recipient_failures OWNER TO "default";

--
-- TOC entry 265 (class 1259 OID 25429)
-- Name: email_recipients; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.email_recipients (
    id character varying(24) NOT NULL,
    email_id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    batch_id character varying(24) NOT NULL,
    processed_at timestamp without time zone,
    delivered_at timestamp without time zone,
    opened_at timestamp without time zone,
    failed_at timestamp without time zone,
    member_uuid character varying(36) NOT NULL,
    member_email character varying(191) NOT NULL,
    member_name character varying(191)
);


ALTER TABLE public.email_recipients OWNER TO "default";

--
-- TOC entry 276 (class 1259 OID 25592)
-- Name: email_spam_complaint_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.email_spam_complaint_events (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    email_id character varying(24) NOT NULL,
    email_address character varying(191) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.email_spam_complaint_events OWNER TO "default";

--
-- TOC entry 263 (class 1259 OID 25395)
-- Name: emails; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.emails (
    id character varying(24) NOT NULL,
    post_id character varying(24) NOT NULL,
    uuid character varying(36) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    recipient_filter text NOT NULL,
    error character varying(2000),
    error_data text,
    email_count integer DEFAULT 0 NOT NULL,
    delivered_count integer DEFAULT 0 NOT NULL,
    opened_count integer DEFAULT 0 NOT NULL,
    failed_count integer DEFAULT 0 NOT NULL,
    subject character varying(300),
    "from" character varying(2000),
    reply_to character varying(2000),
    html text,
    plaintext text,
    source text,
    source_type character varying(50) DEFAULT 'html'::character varying NOT NULL,
    track_opens boolean DEFAULT false NOT NULL,
    track_clicks boolean DEFAULT false NOT NULL,
    feedback_enabled boolean DEFAULT false NOT NULL,
    submitted_at timestamp without time zone NOT NULL,
    newsletter_id character varying(24),
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.emails OWNER TO "default";

--
-- TOC entry 231 (class 1259 OID 24829)
-- Name: integrations; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.integrations (
    id character varying(24) NOT NULL,
    type character varying(50) DEFAULT 'custom'::character varying NOT NULL,
    name character varying(191) NOT NULL,
    slug character varying(191) NOT NULL,
    icon_image character varying(2000),
    description character varying(2000),
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.integrations OWNER TO "default";

--
-- TOC entry 228 (class 1259 OID 24808)
-- Name: invites; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.invites (
    id character varying(24) NOT NULL,
    role_id character varying(24) NOT NULL,
    status character varying(50) DEFAULT 'pending'::character varying NOT NULL,
    token character varying(191) NOT NULL,
    email character varying(191) NOT NULL,
    expires bigint NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.invites OWNER TO "default";

--
-- TOC entry 271 (class 1259 OID 25532)
-- Name: jobs; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.jobs (
    id character varying(24) NOT NULL,
    name character varying(191) NOT NULL,
    status character varying(50) DEFAULT 'queued'::character varying NOT NULL,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.jobs OWNER TO "default";

--
-- TOC entry 251 (class 1259 OID 25046)
-- Name: labels; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.labels (
    id character varying(24) NOT NULL,
    name character varying(191) NOT NULL,
    slug character varying(191) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.labels OWNER TO "default";

--
-- TOC entry 236 (class 1259 OID 24869)
-- Name: members; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members (
    id character varying(24) NOT NULL,
    uuid character varying(36),
    email character varying(191) NOT NULL,
    status character varying(50) DEFAULT 'free'::character varying NOT NULL,
    name character varying(191),
    expertise character varying(191),
    note character varying(2000),
    geolocation character varying(2000),
    enable_comment_notifications boolean DEFAULT true NOT NULL,
    email_count integer DEFAULT 0 NOT NULL,
    email_opened_count integer DEFAULT 0 NOT NULL,
    email_open_rate integer,
    last_seen_at timestamp without time zone,
    last_commented_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.members OWNER TO "default";

--
-- TOC entry 244 (class 1259 OID 24969)
-- Name: members_cancel_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_cancel_events (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    from_plan character varying(255) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.members_cancel_events OWNER TO "default";

--
-- TOC entry 273 (class 1259 OID 25551)
-- Name: members_click_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_click_events (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    redirect_id character varying(24) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.members_click_events OWNER TO "default";

--
-- TOC entry 243 (class 1259 OID 24957)
-- Name: members_created_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_created_events (
    id character varying(24) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    member_id character varying(24) NOT NULL,
    attribution_id character varying(24),
    attribution_type character varying(50),
    attribution_url character varying(2000),
    referrer_source character varying(191),
    referrer_medium character varying(191),
    referrer_url character varying(2000),
    source character varying(50) NOT NULL,
    batch_id character varying(24)
);


ALTER TABLE public.members_created_events OWNER TO "default";

--
-- TOC entry 247 (class 1259 OID 24999)
-- Name: members_email_change_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_email_change_events (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    to_email character varying(191) NOT NULL,
    from_email character varying(191) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.members_email_change_events OWNER TO "default";

--
-- TOC entry 274 (class 1259 OID 25566)
-- Name: members_feedback; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_feedback (
    id character varying(24) NOT NULL,
    score integer DEFAULT 0 NOT NULL,
    member_id character varying(24) NOT NULL,
    post_id character varying(24) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.members_feedback OWNER TO "default";

--
-- TOC entry 252 (class 1259 OID 25112)
-- Name: members_labels; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_labels (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    label_id character varying(24) NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.members_labels OWNER TO "default";

--
-- TOC entry 246 (class 1259 OID 24989)
-- Name: members_login_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_login_events (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.members_login_events OWNER TO "default";

--
-- TOC entry 267 (class 1259 OID 25464)
-- Name: members_newsletters; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_newsletters (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    newsletter_id character varying(24) NOT NULL
);


ALTER TABLE public.members_newsletters OWNER TO "default";

--
-- TOC entry 250 (class 1259 OID 25034)
-- Name: members_paid_subscription_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_paid_subscription_events (
    id character varying(24) NOT NULL,
    type character varying(50),
    member_id character varying(24) NOT NULL,
    subscription_id character varying(24),
    from_plan character varying(255),
    to_plan character varying(255),
    currency character varying(191) NOT NULL,
    source character varying(50) NOT NULL,
    mrr_delta integer NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.members_paid_subscription_events OWNER TO "default";

--
-- TOC entry 245 (class 1259 OID 24979)
-- Name: members_payment_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_payment_events (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    amount integer NOT NULL,
    currency character varying(191) NOT NULL,
    source character varying(50) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.members_payment_events OWNER TO "default";

--
-- TOC entry 249 (class 1259 OID 25019)
-- Name: members_product_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_product_events (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    product_id character varying(24) NOT NULL,
    action character varying(50),
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.members_product_events OWNER TO "default";

--
-- TOC entry 241 (class 1259 OID 24925)
-- Name: members_products; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_products (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    product_id character varying(24) NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    expiry_at timestamp without time zone
);


ALTER TABLE public.members_products OWNER TO "default";

--
-- TOC entry 248 (class 1259 OID 25009)
-- Name: members_status_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_status_events (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    from_status character varying(50),
    to_status character varying(50),
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.members_status_events OWNER TO "default";

--
-- TOC entry 253 (class 1259 OID 25128)
-- Name: members_stripe_customers; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_stripe_customers (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    customer_id character varying(255) NOT NULL,
    name character varying(191),
    email character varying(191),
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.members_stripe_customers OWNER TO "default";

--
-- TOC entry 255 (class 1259 OID 25214)
-- Name: members_stripe_customers_subscriptions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_stripe_customers_subscriptions (
    id character varying(24) NOT NULL,
    customer_id character varying(255) NOT NULL,
    ghost_subscription_id character varying(24),
    subscription_id character varying(255) NOT NULL,
    stripe_price_id character varying(255) DEFAULT ''::character varying NOT NULL,
    status character varying(50) NOT NULL,
    cancel_at_period_end boolean DEFAULT false NOT NULL,
    cancellation_reason character varying(500),
    current_period_end timestamp without time zone NOT NULL,
    start_date timestamp without time zone NOT NULL,
    default_payment_card_last4 character varying(4),
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24),
    mrr integer DEFAULT 0 NOT NULL,
    offer_id character varying(24),
    trial_start_at timestamp without time zone,
    trial_end_at timestamp without time zone,
    plan_id character varying(255) NOT NULL,
    plan_nickname character varying(50) NOT NULL,
    plan_interval character varying(50) NOT NULL,
    plan_amount integer NOT NULL,
    plan_currency character varying(191) NOT NULL
);


ALTER TABLE public.members_stripe_customers_subscriptions OWNER TO "default";

--
-- TOC entry 258 (class 1259 OID 25281)
-- Name: members_subscribe_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_subscribe_events (
    id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    subscribed boolean DEFAULT true NOT NULL,
    created_at timestamp without time zone NOT NULL,
    source character varying(50),
    newsletter_id character varying(24)
);


ALTER TABLE public.members_subscribe_events OWNER TO "default";

--
-- TOC entry 256 (class 1259 OID 25244)
-- Name: members_subscription_created_events; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.members_subscription_created_events (
    id character varying(24) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    member_id character varying(24) NOT NULL,
    subscription_id character varying(24) NOT NULL,
    attribution_id character varying(24),
    attribution_type character varying(50),
    attribution_url character varying(2000),
    referrer_source character varying(191),
    referrer_medium character varying(191),
    referrer_url character varying(2000),
    batch_id character varying(24)
);


ALTER TABLE public.members_subscription_created_events OWNER TO "default";

--
-- TOC entry 277 (class 1259 OID 25607)
-- Name: mentions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.mentions (
    id character varying(24) NOT NULL,
    source character varying(2000) NOT NULL,
    source_title character varying(2000),
    source_site_title character varying(2000),
    source_excerpt character varying(2000),
    source_author character varying(2000),
    source_featured_image character varying(2000),
    source_favicon character varying(2000),
    target character varying(2000) NOT NULL,
    resource_id character varying(24),
    resource_type character varying(50),
    created_at timestamp without time zone NOT NULL,
    payload text,
    deleted boolean DEFAULT false NOT NULL,
    verified boolean DEFAULT false NOT NULL
);


ALTER TABLE public.mentions OWNER TO "default";

--
-- TOC entry 280 (class 1259 OID 25622)
-- Name: migrations; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    name character varying(120) NOT NULL,
    version character varying(70) NOT NULL,
    currentversion character varying(255)
);


ALTER TABLE public.migrations OWNER TO "default";

--
-- TOC entry 279 (class 1259 OID 25621)
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: default
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO "default";

--
-- TOC entry 3139 (class 0 OID 0)
-- Dependencies: 279
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: default
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 214 (class 1259 OID 24576)
-- Name: migrations_lock; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.migrations_lock (
    lock_key character varying(191) NOT NULL,
    locked boolean DEFAULT false,
    acquired_at timestamp without time zone,
    released_at timestamp without time zone
);


ALTER TABLE public.migrations_lock OWNER TO "default";

--
-- TOC entry 278 (class 1259 OID 25616)
-- Name: milestones; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.milestones (
    id character varying(24) NOT NULL,
    type character varying(24) NOT NULL,
    value integer NOT NULL,
    currency character varying(24),
    created_at timestamp without time zone NOT NULL,
    email_sent_at timestamp without time zone
);


ALTER TABLE public.milestones OWNER TO "default";

--
-- TOC entry 234 (class 1259 OID 24855)
-- Name: mobiledoc_revisions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.mobiledoc_revisions (
    id character varying(24) NOT NULL,
    post_id character varying(24) NOT NULL,
    mobiledoc text,
    created_at_ts bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.mobiledoc_revisions OWNER TO "default";

--
-- TOC entry 215 (class 1259 OID 24582)
-- Name: newsletters; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.newsletters (
    id character varying(24) NOT NULL,
    uuid character varying(36) NOT NULL,
    name character varying(191) NOT NULL,
    description character varying(2000),
    feedback_enabled boolean DEFAULT false NOT NULL,
    slug character varying(191) NOT NULL,
    sender_name character varying(191),
    sender_email character varying(191),
    sender_reply_to character varying(191) DEFAULT 'newsletter'::character varying NOT NULL,
    status character varying(50) DEFAULT 'active'::character varying NOT NULL,
    visibility character varying(50) DEFAULT 'members'::character varying NOT NULL,
    subscribe_on_signup boolean DEFAULT true NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL,
    header_image character varying(2000),
    show_header_icon boolean DEFAULT true NOT NULL,
    show_header_title boolean DEFAULT true NOT NULL,
    title_font_category character varying(191) DEFAULT 'sans_serif'::character varying NOT NULL,
    title_alignment character varying(191) DEFAULT 'center'::character varying NOT NULL,
    show_feature_image boolean DEFAULT true NOT NULL,
    body_font_category character varying(191) DEFAULT 'sans_serif'::character varying NOT NULL,
    footer_content text,
    show_badge boolean DEFAULT true NOT NULL,
    show_header_name boolean DEFAULT true NOT NULL,
    show_post_title_section boolean DEFAULT true NOT NULL,
    show_comment_cta boolean DEFAULT true NOT NULL,
    show_subscription_details boolean DEFAULT false NOT NULL,
    show_latest_posts boolean DEFAULT false NOT NULL,
    background_color character varying(50) DEFAULT 'light'::character varying NOT NULL,
    border_color character varying(50),
    title_color character varying(50),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.newsletters OWNER TO "default";

--
-- TOC entry 257 (class 1259 OID 25261)
-- Name: offer_redemptions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.offer_redemptions (
    id character varying(24) NOT NULL,
    offer_id character varying(24) NOT NULL,
    member_id character varying(24) NOT NULL,
    subscription_id character varying(24) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.offer_redemptions OWNER TO "default";

--
-- TOC entry 238 (class 1259 OID 24891)
-- Name: offers; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.offers (
    id character varying(24) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    name character varying(191) NOT NULL,
    code character varying(191) NOT NULL,
    product_id character varying(24) NOT NULL,
    stripe_coupon_id character varying(255),
    "interval" character varying(50) NOT NULL,
    currency character varying(50),
    discount_type character varying(50) NOT NULL,
    discount_amount integer NOT NULL,
    duration character varying(50) NOT NULL,
    duration_in_months integer,
    portal_title character varying(191),
    portal_description character varying(2000),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.offers OWNER TO "default";

--
-- TOC entry 223 (class 1259 OID 24745)
-- Name: permissions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.permissions (
    id character varying(24) NOT NULL,
    name character varying(50) NOT NULL,
    object_type character varying(50) NOT NULL,
    action_type character varying(50) NOT NULL,
    object_id character varying(24),
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.permissions OWNER TO "default";

--
-- TOC entry 221 (class 1259 OID 24720)
-- Name: permissions_roles; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.permissions_roles (
    id character varying(24) NOT NULL,
    role_id character varying(24) NOT NULL,
    permission_id character varying(24) NOT NULL
);


ALTER TABLE public.permissions_roles OWNER TO "default";

--
-- TOC entry 224 (class 1259 OID 24750)
-- Name: permissions_users; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.permissions_users (
    id character varying(24) NOT NULL,
    user_id character varying(24) NOT NULL,
    permission_id character varying(24) NOT NULL
);


ALTER TABLE public.permissions_users OWNER TO "default";

--
-- TOC entry 235 (class 1259 OID 24862)
-- Name: post_revisions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.post_revisions (
    id character varying(24) NOT NULL,
    post_id character varying(24) NOT NULL,
    lexical text,
    created_at_ts bigint NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.post_revisions OWNER TO "default";

--
-- TOC entry 216 (class 1259 OID 24608)
-- Name: posts; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.posts (
    id character varying(24) NOT NULL,
    uuid character varying(36) NOT NULL,
    title character varying(2000) NOT NULL,
    slug character varying(191) NOT NULL,
    mobiledoc text,
    lexical text,
    html text,
    comment_id character varying(50),
    plaintext text,
    feature_image character varying(2000),
    featured boolean DEFAULT false NOT NULL,
    type character varying(50) DEFAULT 'post'::character varying NOT NULL,
    status character varying(50) DEFAULT 'draft'::character varying NOT NULL,
    locale character varying(6),
    visibility character varying(50) DEFAULT 'public'::character varying NOT NULL,
    email_recipient_filter text NOT NULL,
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24),
    published_at timestamp without time zone,
    published_by character varying(24),
    custom_excerpt character varying(2000),
    codeinjection_head text,
    codeinjection_foot text,
    custom_template character varying(100),
    canonical_url text,
    newsletter_id character varying(24)
);


ALTER TABLE public.posts OWNER TO "default";

--
-- TOC entry 219 (class 1259 OID 24697)
-- Name: posts_authors; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.posts_authors (
    id character varying(24) NOT NULL,
    post_id character varying(24) NOT NULL,
    author_id character varying(24) NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.posts_authors OWNER TO "default";

--
-- TOC entry 217 (class 1259 OID 24648)
-- Name: posts_meta; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.posts_meta (
    id character varying(24) NOT NULL,
    post_id character varying(24) NOT NULL,
    og_image character varying(2000),
    og_title character varying(300),
    og_description character varying(500),
    twitter_image character varying(2000),
    twitter_title character varying(300),
    twitter_description character varying(500),
    meta_title character varying(2000),
    meta_description character varying(2000),
    email_subject character varying(300),
    frontmatter text,
    feature_image_alt character varying(191),
    feature_image_caption text,
    email_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.posts_meta OWNER TO "default";

--
-- TOC entry 242 (class 1259 OID 24941)
-- Name: posts_products; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.posts_products (
    id character varying(24) NOT NULL,
    post_id character varying(24) NOT NULL,
    product_id character varying(24) NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.posts_products OWNER TO "default";

--
-- TOC entry 227 (class 1259 OID 24792)
-- Name: posts_tags; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.posts_tags (
    id character varying(24) NOT NULL,
    post_id character varying(24) NOT NULL,
    tag_id character varying(24) NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.posts_tags OWNER TO "default";

--
-- TOC entry 237 (class 1259 OID 24880)
-- Name: products; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.products (
    id character varying(24) NOT NULL,
    name character varying(191) NOT NULL,
    slug character varying(191) NOT NULL,
    active boolean DEFAULT true NOT NULL,
    welcome_page_url character varying(2000),
    visibility character varying(50) DEFAULT 'none'::character varying NOT NULL,
    trial_days integer DEFAULT 0 NOT NULL,
    description character varying(191),
    type character varying(50) DEFAULT 'paid'::character varying NOT NULL,
    currency character varying(50),
    monthly_price integer,
    yearly_price integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    monthly_price_id character varying(24),
    yearly_price_id character varying(24)
);


ALTER TABLE public.products OWNER TO "default";

--
-- TOC entry 240 (class 1259 OID 24909)
-- Name: products_benefits; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.products_benefits (
    id character varying(24) NOT NULL,
    product_id character varying(24) NOT NULL,
    benefit_id character varying(24) NOT NULL,
    sort_order integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.products_benefits OWNER TO "default";

--
-- TOC entry 272 (class 1259 OID 25539)
-- Name: redirects; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.redirects (
    id character varying(24) NOT NULL,
    "from" character varying(2000) NOT NULL,
    "to" character varying(2000) NOT NULL,
    post_id character varying(24),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.redirects OWNER TO "default";

--
-- TOC entry 220 (class 1259 OID 24713)
-- Name: roles; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.roles (
    id character varying(24) NOT NULL,
    name character varying(50) NOT NULL,
    description character varying(2000),
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.roles OWNER TO "default";

--
-- TOC entry 222 (class 1259 OID 24740)
-- Name: roles_users; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.roles_users (
    id character varying(24) NOT NULL,
    role_id character varying(24) NOT NULL,
    user_id character varying(24) NOT NULL
);


ALTER TABLE public.roles_users OWNER TO "default";

--
-- TOC entry 230 (class 1259 OID 24822)
-- Name: sessions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.sessions (
    id character varying(24) NOT NULL,
    session_id character varying(32) NOT NULL,
    user_id character varying(24) NOT NULL,
    session_data character varying(2000) NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.sessions OWNER TO "default";

--
-- TOC entry 225 (class 1259 OID 24755)
-- Name: settings; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.settings (
    id character varying(24) NOT NULL,
    "group" character varying(50) DEFAULT 'core'::character varying NOT NULL,
    key character varying(50) NOT NULL,
    value text,
    type character varying(50) NOT NULL,
    flags character varying(50),
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.settings OWNER TO "default";

--
-- TOC entry 261 (class 1259 OID 25312)
-- Name: snippets; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.snippets (
    id character varying(24) NOT NULL,
    name character varying(191) NOT NULL,
    mobiledoc text NOT NULL,
    lexical text,
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.snippets OWNER TO "default";

--
-- TOC entry 254 (class 1259 OID 25140)
-- Name: subscriptions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.subscriptions (
    id character varying(24) NOT NULL,
    type character varying(50) NOT NULL,
    status character varying(50) NOT NULL,
    member_id character varying(24) NOT NULL,
    tier_id character varying(24) NOT NULL,
    cadence character varying(50),
    currency character varying(50),
    amount integer,
    payment_provider character varying(50),
    payment_subscription_url character varying(2000),
    payment_user_url character varying(2000),
    offer_id character varying(24),
    expires_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone
);


ALTER TABLE public.subscriptions OWNER TO "default";

--
-- TOC entry 275 (class 1259 OID 25582)
-- Name: suppressions; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.suppressions (
    id character varying(24) NOT NULL,
    email character varying(191) NOT NULL,
    email_id character varying(24),
    reason character varying(50) NOT NULL,
    created_at timestamp without time zone NOT NULL
);


ALTER TABLE public.suppressions OWNER TO "default";

--
-- TOC entry 226 (class 1259 OID 24774)
-- Name: tags; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.tags (
    id character varying(24) NOT NULL,
    name character varying(191),
    slug character varying(191),
    description text,
    feature_image character varying(2000),
    parent_id character varying(191),
    visibility character varying(50) DEFAULT 'public'::character varying,
    og_image character varying(2000),
    og_title character varying(300),
    og_description character varying(500),
    twitter_image character varying(2000),
    twitter_title character varying(300),
    twitter_description character varying(500),
    meta_title character varying(2000),
    meta_description character varying(2000),
    codeinjection_head text,
    codeinjection_foot text,
    canonical_url character varying(2000),
    accent_color character varying(50),
    created_at timestamp without time zone,
    created_by character varying(24),
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.tags OWNER TO "default";

--
-- TOC entry 260 (class 1259 OID 25304)
-- Name: tokens; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.tokens (
    id character varying(24) NOT NULL,
    token character varying(32) NOT NULL,
    data character varying(2000),
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone,
    first_used_at timestamp without time zone,
    used_count integer DEFAULT 0 NOT NULL,
    created_by character varying(24) NOT NULL
);


ALTER TABLE public.tokens OWNER TO "default";

--
-- TOC entry 218 (class 1259 OID 24672)
-- Name: users; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.users (
    id character varying NOT NULL,
    name character varying,
    slug character varying,
    password character varying,
    email character varying,
    profile_image character varying,
    cover_image character varying,
    bio text,
    website character varying,
    location text,
    facebook character varying,
    twitter character varying,
    accessibility text,
    status character varying DEFAULT 'active'::character varying,
    locale character varying,
    visibility character varying DEFAULT 'public'::character varying,
    meta_title character varying,
    meta_description character varying,
    tour text,
    last_seen timestamp without time zone,
    comment_notifications boolean DEFAULT true,
    free_member_signup_notification boolean DEFAULT true,
    paid_subscription_started_notification boolean DEFAULT true,
    paid_subscription_canceled_notification boolean DEFAULT false,
    mention_notifications boolean DEFAULT true,
    milestone_notifications boolean DEFAULT true,
    created_at timestamp without time zone,
    created_by character varying,
    updated_at timestamp without time zone,
    updated_by character varying
);


ALTER TABLE public.users OWNER TO "default";

--
-- TOC entry 232 (class 1259 OID 24837)
-- Name: webhooks; Type: TABLE; Schema: public; Owner: default
--

CREATE TABLE public.webhooks (
    id character varying(24) NOT NULL,
    event character varying(50) NOT NULL,
    target_url character varying(2000) NOT NULL,
    name character varying(191),
    secret character varying(191),
    api_version character varying(50) DEFAULT 'v2'::character varying NOT NULL,
    integration_id character varying(24) NOT NULL,
    last_triggered_at timestamp without time zone,
    last_triggered_status character varying(50),
    last_triggered_error character varying(50),
    created_at timestamp without time zone NOT NULL,
    created_by character varying(24) NOT NULL,
    updated_at timestamp without time zone,
    updated_by character varying(24)
);


ALTER TABLE public.webhooks OWNER TO "default";

--
-- TOC entry 2725 (class 2604 OID 25625)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 3111 (class 0 OID 25297)
-- Dependencies: 259
-- Data for Name: actions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.actions (id, resource_id, resource_type, actor_id, actor_type, event, context, created_at) FROM stdin;
\.


--
-- TOC entry 3085 (class 0 OID 24850)
-- Dependencies: 233
-- Data for Name: api_keys; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.api_keys (id, type, secret, role_id, integration_id, user_id, last_seen_at, last_seen_version, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- TOC entry 3091 (class 0 OID 24904)
-- Dependencies: 239
-- Data for Name: benefits; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.benefits (id, name, slug, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3081 (class 0 OID 24816)
-- Dependencies: 229
-- Data for Name: brute; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.brute (key, firstrequest, lastrequest, lifetime, count) FROM stdin;
\.


--
-- TOC entry 3121 (class 0 OID 25502)
-- Dependencies: 269
-- Data for Name: comment_likes; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.comment_likes (id, comment_id, member_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3122 (class 0 OID 25517)
-- Dependencies: 270
-- Data for Name: comment_reports; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.comment_reports (id, comment_id, member_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3120 (class 0 OID 25479)
-- Dependencies: 268
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.comments (id, post_id, member_id, parent_id, status, html, edited_at, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3114 (class 0 OID 25319)
-- Dependencies: 262
-- Data for Name: custom_theme_settings; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.custom_theme_settings (id, theme, key, type, value) FROM stdin;
643c3277002137342cf32536	casper	navigation_layout	select	Logo on cover
643c3277002137342cf32537	casper	title_font	select	Modern sans-serif
643c3277002137342cf32538	casper	body_font	select	Elegant serif
643c3277002137342cf32539	casper	show_publication_cover	boolean	true
643c3277002137342cf3253a	casper	header_style	select	Center aligned
643c3277002137342cf3253b	casper	feed_layout	select	Classic
643c3277002137342cf3253c	casper	color_scheme	select	Light
643c3277002137342cf3253d	casper	post_image_style	select	Wide
643c3277002137342cf3253e	casper	email_signup_text	text	Sign up for more like this.
643c3277002137342cf3253f	casper	show_recent_posts_footer	boolean	true
\.


--
-- TOC entry 3116 (class 0 OID 25416)
-- Dependencies: 264
-- Data for Name: email_batches; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.email_batches (id, email_id, provider_id, status, member_segment, error_status_code, error_message, error_data, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3118 (class 0 OID 25446)
-- Dependencies: 266
-- Data for Name: email_recipient_failures; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.email_recipient_failures (id, email_id, member_id, email_recipient_id, code, enhanced_code, message, severity, failed_at, event_id) FROM stdin;
\.


--
-- TOC entry 3117 (class 0 OID 25429)
-- Dependencies: 265
-- Data for Name: email_recipients; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.email_recipients (id, email_id, member_id, batch_id, processed_at, delivered_at, opened_at, failed_at, member_uuid, member_email, member_name) FROM stdin;
\.


--
-- TOC entry 3128 (class 0 OID 25592)
-- Dependencies: 276
-- Data for Name: email_spam_complaint_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.email_spam_complaint_events (id, member_id, email_id, email_address, created_at) FROM stdin;
\.


--
-- TOC entry 3115 (class 0 OID 25395)
-- Dependencies: 263
-- Data for Name: emails; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.emails (id, post_id, uuid, status, recipient_filter, error, error_data, email_count, delivered_count, opened_count, failed_count, subject, "from", reply_to, html, plaintext, source, source_type, track_opens, track_clicks, feedback_enabled, submitted_at, newsletter_id, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- TOC entry 3083 (class 0 OID 24829)
-- Dependencies: 231
-- Data for Name: integrations; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.integrations (id, type, name, slug, icon_image, description, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- TOC entry 3080 (class 0 OID 24808)
-- Dependencies: 228
-- Data for Name: invites; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.invites (id, role_id, status, token, email, expires, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- TOC entry 3123 (class 0 OID 25532)
-- Dependencies: 271
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.jobs (id, name, status, started_at, finished_at, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3103 (class 0 OID 25046)
-- Dependencies: 251
-- Data for Name: labels; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.labels (id, name, slug, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- TOC entry 3088 (class 0 OID 24869)
-- Dependencies: 236
-- Data for Name: members; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members (id, uuid, email, status, name, expertise, note, geolocation, enable_comment_notifications, email_count, email_opened_count, email_open_rate, last_seen_at, last_commented_at, created_at, created_by, updated_at, updated_by) FROM stdin;
643c340e002137342cf3254b	3d20cfd5-a347-497d-8a1d-7ea637628904	i.love.to.smile.around@gmail.com	free	Huy Nguyen	\N	Hello note	\N	t	0	0	\N	\N	\N	2023-04-16 17:44:46	1	2023-04-16 17:44:46	1
\.


--
-- TOC entry 3096 (class 0 OID 24969)
-- Dependencies: 244
-- Data for Name: members_cancel_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_cancel_events (id, member_id, from_plan, created_at) FROM stdin;
\.


--
-- TOC entry 3125 (class 0 OID 25551)
-- Dependencies: 273
-- Data for Name: members_click_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_click_events (id, member_id, redirect_id, created_at) FROM stdin;
\.


--
-- TOC entry 3095 (class 0 OID 24957)
-- Dependencies: 243
-- Data for Name: members_created_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_created_events (id, created_at, member_id, attribution_id, attribution_type, attribution_url, referrer_source, referrer_medium, referrer_url, source, batch_id) FROM stdin;
\.


--
-- TOC entry 3099 (class 0 OID 24999)
-- Dependencies: 247
-- Data for Name: members_email_change_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_email_change_events (id, member_id, to_email, from_email, created_at) FROM stdin;
\.


--
-- TOC entry 3126 (class 0 OID 25566)
-- Dependencies: 274
-- Data for Name: members_feedback; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_feedback (id, score, member_id, post_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3104 (class 0 OID 25112)
-- Dependencies: 252
-- Data for Name: members_labels; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_labels (id, member_id, label_id, sort_order) FROM stdin;
\.


--
-- TOC entry 3098 (class 0 OID 24989)
-- Dependencies: 246
-- Data for Name: members_login_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_login_events (id, member_id, created_at) FROM stdin;
\.


--
-- TOC entry 3119 (class 0 OID 25464)
-- Dependencies: 267
-- Data for Name: members_newsletters; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_newsletters (id, member_id, newsletter_id) FROM stdin;
643c340e002137342cf3254c	643c340e002137342cf3254b	643c3268002137342cf32337
\.


--
-- TOC entry 3102 (class 0 OID 25034)
-- Dependencies: 250
-- Data for Name: members_paid_subscription_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_paid_subscription_events (id, type, member_id, subscription_id, from_plan, to_plan, currency, source, mrr_delta, created_at) FROM stdin;
\.


--
-- TOC entry 3097 (class 0 OID 24979)
-- Dependencies: 245
-- Data for Name: members_payment_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_payment_events (id, member_id, amount, currency, source, created_at) FROM stdin;
\.


--
-- TOC entry 3101 (class 0 OID 25019)
-- Dependencies: 249
-- Data for Name: members_product_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_product_events (id, member_id, product_id, action, created_at) FROM stdin;
\.


--
-- TOC entry 3093 (class 0 OID 24925)
-- Dependencies: 241
-- Data for Name: members_products; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_products (id, member_id, product_id, sort_order, expiry_at) FROM stdin;
\.


--
-- TOC entry 3100 (class 0 OID 25009)
-- Dependencies: 248
-- Data for Name: members_status_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_status_events (id, member_id, from_status, to_status, created_at) FROM stdin;
\.


--
-- TOC entry 3105 (class 0 OID 25128)
-- Dependencies: 253
-- Data for Name: members_stripe_customers; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_stripe_customers (id, member_id, customer_id, name, email, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- TOC entry 3107 (class 0 OID 25214)
-- Dependencies: 255
-- Data for Name: members_stripe_customers_subscriptions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_stripe_customers_subscriptions (id, customer_id, ghost_subscription_id, subscription_id, stripe_price_id, status, cancel_at_period_end, cancellation_reason, current_period_end, start_date, default_payment_card_last4, created_at, created_by, updated_at, updated_by, mrr, offer_id, trial_start_at, trial_end_at, plan_id, plan_nickname, plan_interval, plan_amount, plan_currency) FROM stdin;
\.


--
-- TOC entry 3110 (class 0 OID 25281)
-- Dependencies: 258
-- Data for Name: members_subscribe_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_subscribe_events (id, member_id, subscribed, created_at, source, newsletter_id) FROM stdin;
\.


--
-- TOC entry 3108 (class 0 OID 25244)
-- Dependencies: 256
-- Data for Name: members_subscription_created_events; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.members_subscription_created_events (id, created_at, member_id, subscription_id, attribution_id, attribution_type, attribution_url, referrer_source, referrer_medium, referrer_url, batch_id) FROM stdin;
\.


--
-- TOC entry 3129 (class 0 OID 25607)
-- Dependencies: 277
-- Data for Name: mentions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.mentions (id, source, source_title, source_site_title, source_excerpt, source_author, source_featured_image, source_favicon, target, resource_id, resource_type, created_at, payload, deleted, verified) FROM stdin;
\.


--
-- TOC entry 3132 (class 0 OID 25622)
-- Dependencies: 280
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.migrations (id, name, version, currentversion) FROM stdin;
\.


--
-- TOC entry 3066 (class 0 OID 24576)
-- Dependencies: 214
-- Data for Name: migrations_lock; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.migrations_lock (lock_key, locked, acquired_at, released_at) FROM stdin;
km01	f	2023-04-16 17:37:40	2023-04-16 17:37:50
\.


--
-- TOC entry 3130 (class 0 OID 25616)
-- Dependencies: 278
-- Data for Name: milestones; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.milestones (id, type, value, currency, created_at, email_sent_at) FROM stdin;
\.


--
-- TOC entry 3086 (class 0 OID 24855)
-- Dependencies: 234
-- Data for Name: mobiledoc_revisions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.mobiledoc_revisions (id, post_id, mobiledoc, created_at_ts, created_at) FROM stdin;
\.


--
-- TOC entry 3067 (class 0 OID 24582)
-- Dependencies: 215
-- Data for Name: newsletters; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.newsletters (id, uuid, name, description, feedback_enabled, slug, sender_name, sender_email, sender_reply_to, status, visibility, subscribe_on_signup, sort_order, header_image, show_header_icon, show_header_title, title_font_category, title_alignment, show_feature_image, body_font_category, footer_content, show_badge, show_header_name, show_post_title_section, show_comment_cta, show_subscription_details, show_latest_posts, background_color, border_color, title_color, created_at, updated_at) FROM stdin;
643c3268002137342cf32337	7e9766f0-9c32-42b1-a393-d83a184354aa	Ghost Demo	\N	f	default-newsletter	\N	\N	newsletter	active	members	t	0	\N	t	t	sans_serif	center	t	sans_serif	\N	t	f	t	t	f	f	light	\N	\N	2023-04-16 17:37:44	2023-04-16 17:42:16
\.


--
-- TOC entry 3109 (class 0 OID 25261)
-- Dependencies: 257
-- Data for Name: offer_redemptions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.offer_redemptions (id, offer_id, member_id, subscription_id, created_at) FROM stdin;
\.


--
-- TOC entry 3090 (class 0 OID 24891)
-- Dependencies: 238
-- Data for Name: offers; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.offers (id, active, name, code, product_id, stripe_coupon_id, "interval", currency, discount_type, discount_amount, duration, duration_in_months, portal_title, portal_description, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3075 (class 0 OID 24745)
-- Dependencies: 223
-- Data for Name: permissions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.permissions (id, name, object_type, action_type, object_id, created_at, created_by, updated_at, updated_by) FROM stdin;
643c3268002137342cf32339	Read explore data	explore	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3233a	Export database	db	exportContent	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3233b	Import database	db	importContent	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3233c	Delete all content	db	deleteAllContent	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3233d	Send mail	mail	send	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3233e	Browse notifications	notification	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3233f	Add notifications	notification	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32340	Delete notifications	notification	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32341	Browse posts	post	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32342	Read posts	post	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32343	Edit posts	post	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32344	Add posts	post	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32345	Delete posts	post	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32346	Browse settings	setting	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32347	Read settings	setting	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32348	Edit settings	setting	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32349	Generate slugs	slug	generate	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3234a	Browse tags	tag	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3234b	Read tags	tag	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3234c	Edit tags	tag	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3234d	Add tags	tag	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3234e	Delete tags	tag	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3234f	Browse themes	theme	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32350	Edit themes	theme	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32351	Activate themes	theme	activate	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32352	View active theme details	theme	readActive	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32353	Upload themes	theme	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32354	Download themes	theme	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32355	Delete themes	theme	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32356	Browse users	user	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32357	Read users	user	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32358	Edit users	user	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32359	Add users	user	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3235a	Delete users	user	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3235b	Assign a role	role	assign	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3235c	Browse roles	role	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3235d	Browse invites	invite	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3235e	Read invites	invite	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3235f	Edit invites	invite	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32360	Add invites	invite	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32361	Delete invites	invite	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32362	Download redirects	redirect	download	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32363	Upload redirects	redirect	upload	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32364	Add webhooks	webhook	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32365	Edit webhooks	webhook	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32366	Delete webhooks	webhook	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32367	Browse integrations	integration	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32368	Read integrations	integration	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32369	Edit integrations	integration	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3236a	Add integrations	integration	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3236b	Delete integrations	integration	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3236c	Browse API keys	api_key	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3236d	Read API keys	api_key	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3236e	Edit API keys	api_key	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3236f	Add API keys	api_key	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32370	Delete API keys	api_key	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32371	Browse Actions	action	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32372	Browse Members	member	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32373	Read Members	member	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32374	Edit Members	member	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32375	Add Members	member	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32376	Delete Members	member	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32377	Browse Products	product	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32378	Read Products	product	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32379	Edit Products	product	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3237a	Add Products	product	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3237b	Delete Products	product	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3237c	Publish posts	post	publish	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3237d	Backup database	db	backupContent	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3237e	Email preview	email_preview	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3237f	Send test email	email_preview	sendTestEmail	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32380	Browse emails	email	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32381	Read emails	email	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32382	Retry emails	email	retry	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32383	Browse labels	label	browse	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32384	Read labels	label	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32385	Edit labels	label	edit	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32386	Add labels	label	add	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32387	Delete labels	label	destroy	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32388	Read member signin urls	member_signin_url	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32389	Read identities	identity	read	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3269002137342cf3238a	Auth Stripe Connect for Members	members_stripe_connect	auth	\N	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3269002137342cf3238b	Browse snippets	snippet	browse	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf3238c	Read snippets	snippet	read	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf3238d	Edit snippets	snippet	edit	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf3238e	Add snippets	snippet	add	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf3238f	Delete snippets	snippet	destroy	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf32390	Browse offers	offer	browse	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf32391	Read offers	offer	read	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf32392	Edit offers	offer	edit	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf32393	Add offers	offer	add	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf32394	Reset all passwords	authentication	resetAllPasswords	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf32395	Browse custom theme settings	custom_theme_setting	browse	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf32396	Edit custom theme settings	custom_theme_setting	edit	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf32397	Browse newsletters	newsletter	browse	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf32398	Read newsletters	newsletter	read	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf32399	Add newsletters	newsletter	add	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf3239a	Edit newsletters	newsletter	edit	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf3239b	Browse comments	comment	browse	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf3239c	Read comments	comment	read	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf3239d	Edit comments	comment	edit	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf3239e	Add comments	comment	add	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf3239f	Delete comments	comment	destroy	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf323a0	Moderate comments	comment	moderate	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf323a1	Like comments	comment	like	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf323a2	Unlike comments	comment	unlike	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf323a3	Report comments	comment	report	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf323a4	Browse links	link	browse	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf323a5	Edit links	link	edit	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
643c3269002137342cf323a6	Browse mentions	mention	browse	\N	2023-04-16 17:37:45	1	2023-04-16 17:37:45	1
\.


--
-- TOC entry 3073 (class 0 OID 24720)
-- Dependencies: 221
-- Data for Name: permissions_roles; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.permissions_roles (id, role_id, permission_id) FROM stdin;
643c326e002137342cf323b8	643c3268002137342cf3232a	643c3268002137342cf3233b
643c326e002137342cf323b9	643c3268002137342cf3232a	643c3268002137342cf3233c
643c326e002137342cf323b7	643c3268002137342cf3232a	643c3268002137342cf3233a
643c326e002137342cf323ba	643c3268002137342cf3232a	643c3268002137342cf3237d
643c326e002137342cf323bb	643c3268002137342cf3232a	643c3268002137342cf3233d
643c326e002137342cf323bc	643c3268002137342cf3232a	643c3268002137342cf3233e
643c326e002137342cf323bd	643c3268002137342cf3232a	643c3268002137342cf3233f
643c326e002137342cf323be	643c3268002137342cf3232a	643c3268002137342cf32340
643c326e002137342cf323bf	643c3268002137342cf3232a	643c3268002137342cf32341
643c326e002137342cf323c1	643c3268002137342cf3232a	643c3268002137342cf32343
643c326e002137342cf323c0	643c3268002137342cf3232a	643c3268002137342cf32342
643c326e002137342cf323c4	643c3268002137342cf3232a	643c3268002137342cf3237c
643c326e002137342cf323c2	643c3268002137342cf3232a	643c3268002137342cf32344
643c326e002137342cf323c3	643c3268002137342cf3232a	643c3268002137342cf32345
643c326e002137342cf323c5	643c3268002137342cf3232a	643c3268002137342cf32346
643c326e002137342cf323c6	643c3268002137342cf3232a	643c3268002137342cf32347
643c326e002137342cf323c7	643c3268002137342cf3232a	643c3268002137342cf32348
643c326e002137342cf323c8	643c3268002137342cf3232a	643c3268002137342cf32349
643c326e002137342cf323c9	643c3268002137342cf3232a	643c3268002137342cf3234a
643c326e002137342cf323ca	643c3268002137342cf3232a	643c3268002137342cf3234b
643c326e002137342cf323cc	643c3268002137342cf3232a	643c3268002137342cf3234d
643c326e002137342cf323cb	643c3268002137342cf3232a	643c3268002137342cf3234c
643c326e002137342cf323cd	643c3268002137342cf3232a	643c3268002137342cf3234e
643c326e002137342cf323ce	643c3268002137342cf3232a	643c3268002137342cf3234f
643c326e002137342cf323cf	643c3268002137342cf3232a	643c3268002137342cf32350
643c326e002137342cf323d0	643c3268002137342cf3232a	643c3268002137342cf32351
643c326e002137342cf323d1	643c3268002137342cf3232a	643c3268002137342cf32352
643c326e002137342cf323d2	643c3268002137342cf3232a	643c3268002137342cf32353
643c326e002137342cf323d3	643c3268002137342cf3232a	643c3268002137342cf32354
643c326e002137342cf323d4	643c3268002137342cf3232a	643c3268002137342cf32355
643c326e002137342cf323d5	643c3268002137342cf3232a	643c3268002137342cf32356
643c326e002137342cf323d7	643c3268002137342cf3232a	643c3268002137342cf32358
643c326e002137342cf323d8	643c3268002137342cf3232a	643c3268002137342cf32359
643c326e002137342cf323d9	643c3268002137342cf3232a	643c3268002137342cf3235a
643c326e002137342cf323d6	643c3268002137342cf3232a	643c3268002137342cf32357
643c326e002137342cf323da	643c3268002137342cf3232a	643c3268002137342cf3235b
643c326e002137342cf323db	643c3268002137342cf3232a	643c3268002137342cf3235c
643c326e002137342cf323de	643c3268002137342cf3232a	643c3268002137342cf3235f
643c326e002137342cf323df	643c3268002137342cf3232a	643c3268002137342cf32360
643c326e002137342cf323dc	643c3268002137342cf3232a	643c3268002137342cf3235d
643c326e002137342cf323dd	643c3268002137342cf3232a	643c3268002137342cf3235e
643c326e002137342cf323e0	643c3268002137342cf3232a	643c3268002137342cf32361
643c326e002137342cf323e1	643c3268002137342cf3232a	643c3268002137342cf32362
643c326e002137342cf323e2	643c3268002137342cf3232a	643c3268002137342cf32363
643c326e002137342cf323e3	643c3268002137342cf3232a	643c3268002137342cf32364
643c326e002137342cf323e4	643c3268002137342cf3232a	643c3268002137342cf32365
643c326e002137342cf323e5	643c3268002137342cf3232a	643c3268002137342cf32366
643c326e002137342cf323e6	643c3268002137342cf3232a	643c3268002137342cf32367
643c326e002137342cf323e8	643c3268002137342cf3232a	643c3268002137342cf32369
643c326e002137342cf323e9	643c3268002137342cf3232a	643c3268002137342cf3236a
643c326e002137342cf323ea	643c3268002137342cf3232a	643c3268002137342cf3236b
643c326e002137342cf323e7	643c3268002137342cf3232a	643c3268002137342cf32368
643c326e002137342cf323eb	643c3268002137342cf3232a	643c3268002137342cf3236c
643c326e002137342cf323ee	643c3268002137342cf3232a	643c3268002137342cf3236f
643c326e002137342cf323ed	643c3268002137342cf3232a	643c3268002137342cf3236e
643c326e002137342cf323ec	643c3268002137342cf3232a	643c3268002137342cf3236d
643c326e002137342cf323ef	643c3268002137342cf3232a	643c3268002137342cf32370
643c326e002137342cf323f0	643c3268002137342cf3232a	643c3268002137342cf32371
643c326e002137342cf323f2	643c3268002137342cf3232a	643c3268002137342cf32373
643c326e002137342cf323f3	643c3268002137342cf3232a	643c3268002137342cf32374
643c326e002137342cf323f5	643c3268002137342cf3232a	643c3268002137342cf32376
643c326e002137342cf323f1	643c3268002137342cf3232a	643c3268002137342cf32372
643c326e002137342cf323f4	643c3268002137342cf3232a	643c3268002137342cf32375
643c326e002137342cf323f6	643c3268002137342cf3232a	643c3268002137342cf32377
643c326e002137342cf323f7	643c3268002137342cf3232a	643c3268002137342cf32378
643c326e002137342cf323f8	643c3268002137342cf3232a	643c3268002137342cf32379
643c326e002137342cf323f9	643c3268002137342cf3232a	643c3268002137342cf3237a
643c326e002137342cf323fa	643c3268002137342cf3232a	643c3268002137342cf3237b
643c326e002137342cf323fb	643c3268002137342cf3232a	643c3268002137342cf32383
643c326e002137342cf323fc	643c3268002137342cf3232a	643c3268002137342cf32384
643c326e002137342cf323fd	643c3268002137342cf3232a	643c3268002137342cf32385
643c326e002137342cf323fe	643c3268002137342cf3232a	643c3268002137342cf32386
643c326e002137342cf323ff	643c3268002137342cf3232a	643c3268002137342cf32387
643c326e002137342cf32400	643c3268002137342cf3232a	643c3268002137342cf3237e
643c326e002137342cf32401	643c3268002137342cf3232a	643c3268002137342cf3237f
643c326e002137342cf32403	643c3268002137342cf3232a	643c3268002137342cf32381
643c326e002137342cf32402	643c3268002137342cf3232a	643c3268002137342cf32380
643c326e002137342cf32404	643c3268002137342cf3232a	643c3268002137342cf32382
643c326e002137342cf32405	643c3268002137342cf3232a	643c3268002137342cf32388
643c326e002137342cf32408	643c3268002137342cf3232a	643c3269002137342cf3238d
643c326e002137342cf32409	643c3268002137342cf3232a	643c3269002137342cf3238e
643c326e002137342cf32406	643c3268002137342cf3232a	643c3269002137342cf3238b
643c326e002137342cf32407	643c3268002137342cf3232a	643c3269002137342cf3238c
643c326e002137342cf3240a	643c3268002137342cf3232a	643c3269002137342cf3238f
643c326e002137342cf3240b	643c3268002137342cf3232a	643c3269002137342cf32395
643c326e002137342cf3240c	643c3268002137342cf3232a	643c3269002137342cf32396
643c326e002137342cf3240d	643c3268002137342cf3232a	643c3269002137342cf32390
643c326e002137342cf3240e	643c3268002137342cf3232a	643c3269002137342cf32391
643c326e002137342cf32410	643c3268002137342cf3232a	643c3269002137342cf32393
643c326e002137342cf3240f	643c3268002137342cf3232a	643c3269002137342cf32392
643c326e002137342cf32411	643c3268002137342cf3232a	643c3269002137342cf32394
643c326e002137342cf32412	643c3268002137342cf3232a	643c3269002137342cf3238a
643c326e002137342cf32413	643c3268002137342cf3232a	643c3269002137342cf32397
643c326e002137342cf32415	643c3268002137342cf3232a	643c3269002137342cf32399
643c326e002137342cf32414	643c3268002137342cf3232a	643c3269002137342cf32398
643c326e002137342cf32416	643c3268002137342cf3232a	643c3269002137342cf3239a
643c326e002137342cf32417	643c3268002137342cf3232a	643c3268002137342cf32339
643c326e002137342cf32418	643c3268002137342cf3232a	643c3269002137342cf3239b
643c326e002137342cf32419	643c3268002137342cf3232a	643c3269002137342cf3239c
643c326e002137342cf3241a	643c3268002137342cf3232a	643c3269002137342cf3239d
643c326e002137342cf3241b	643c3268002137342cf3232a	643c3269002137342cf3239e
643c326e002137342cf3241c	643c3268002137342cf3232a	643c3269002137342cf3239f
643c326e002137342cf3241d	643c3268002137342cf3232a	643c3269002137342cf323a0
643c326e002137342cf3241e	643c3268002137342cf3232a	643c3269002137342cf323a1
643c326e002137342cf3241f	643c3268002137342cf3232a	643c3269002137342cf323a2
643c326e002137342cf32420	643c3268002137342cf3232a	643c3269002137342cf323a3
643c326e002137342cf32421	643c3268002137342cf3232a	643c3269002137342cf323a4
643c326e002137342cf32422	643c3268002137342cf3232a	643c3269002137342cf323a5
643c326e002137342cf32423	643c3268002137342cf3232a	643c3269002137342cf323a6
643c326e002137342cf32424	643c3268002137342cf32332	643c3268002137342cf3233a
643c326e002137342cf32425	643c3268002137342cf32332	643c3268002137342cf3233b
643c326e002137342cf32427	643c3268002137342cf32332	643c3268002137342cf3237d
643c326e002137342cf32426	643c3268002137342cf32332	643c3268002137342cf3233c
643c326e002137342cf32428	643c3268002137342cf32333	643c3268002137342cf3237c
643c326e002137342cf32429	643c3268002137342cf32330	643c3268002137342cf32339
643c326e002137342cf3242a	643c3268002137342cf32331	643c3268002137342cf3233b
643c326e002137342cf3242b	643c3268002137342cf32331	643c3268002137342cf32375
643c326e002137342cf3242c	643c3268002137342cf32331	643c3268002137342cf3234b
643c326e002137342cf3242d	643c3268002137342cf3232f	643c3268002137342cf3233d
643c326e002137342cf3242e	643c3268002137342cf3232f	643c3268002137342cf3233e
643c326e002137342cf32430	643c3268002137342cf3232f	643c3268002137342cf32340
643c326e002137342cf3242f	643c3268002137342cf3232f	643c3268002137342cf3233f
643c326e002137342cf32432	643c3268002137342cf3232f	643c3268002137342cf32342
643c326e002137342cf32434	643c3268002137342cf3232f	643c3268002137342cf32344
643c326e002137342cf32435	643c3268002137342cf3232f	643c3268002137342cf32345
643c326e002137342cf32431	643c3268002137342cf3232f	643c3268002137342cf32341
643c326e002137342cf32433	643c3268002137342cf3232f	643c3268002137342cf32343
643c326e002137342cf32436	643c3268002137342cf3232f	643c3268002137342cf3237c
643c326e002137342cf32437	643c3268002137342cf3232f	643c3268002137342cf32346
643c326e002137342cf32438	643c3268002137342cf3232f	643c3268002137342cf32347
643c326e002137342cf32439	643c3268002137342cf3232f	643c3268002137342cf32348
643c326e002137342cf3243a	643c3268002137342cf3232f	643c3268002137342cf32349
643c326e002137342cf3243b	643c3268002137342cf3232f	643c3268002137342cf3234a
643c326e002137342cf3243c	643c3268002137342cf3232f	643c3268002137342cf3234b
643c326e002137342cf3243d	643c3268002137342cf3232f	643c3268002137342cf3234c
643c326e002137342cf3243e	643c3268002137342cf3232f	643c3268002137342cf3234d
643c326e002137342cf3243f	643c3268002137342cf3232f	643c3268002137342cf3234e
643c326e002137342cf32440	643c3268002137342cf3232f	643c3268002137342cf3234f
643c326e002137342cf32443	643c3268002137342cf3232f	643c3268002137342cf32352
643c326e002137342cf32441	643c3268002137342cf3232f	643c3268002137342cf32350
643c326e002137342cf32445	643c3268002137342cf3232f	643c3268002137342cf32354
643c326e002137342cf32446	643c3268002137342cf3232f	643c3268002137342cf32355
643c326e002137342cf32442	643c3268002137342cf3232f	643c3268002137342cf32351
643c326e002137342cf32444	643c3268002137342cf3232f	643c3268002137342cf32353
643c326e002137342cf32448	643c3268002137342cf3232f	643c3268002137342cf32357
643c326e002137342cf3244a	643c3268002137342cf3232f	643c3268002137342cf32359
643c326e002137342cf32449	643c3268002137342cf3232f	643c3268002137342cf32358
643c326e002137342cf3244b	643c3268002137342cf3232f	643c3268002137342cf3235a
643c326e002137342cf32447	643c3268002137342cf3232f	643c3268002137342cf32356
643c326e002137342cf3244c	643c3268002137342cf3232f	643c3268002137342cf3235b
643c326e002137342cf3244d	643c3268002137342cf3232f	643c3268002137342cf3235c
643c326e002137342cf3244e	643c3268002137342cf3232f	643c3268002137342cf3235d
643c326e002137342cf3244f	643c3268002137342cf3232f	643c3268002137342cf3235e
643c326e002137342cf32450	643c3268002137342cf3232f	643c3268002137342cf3235f
643c326e002137342cf32451	643c3268002137342cf3232f	643c3268002137342cf32360
643c326e002137342cf32452	643c3268002137342cf3232f	643c3268002137342cf32361
643c326e002137342cf32453	643c3268002137342cf3232f	643c3268002137342cf32362
643c326e002137342cf32454	643c3268002137342cf3232f	643c3268002137342cf32363
643c326e002137342cf32455	643c3268002137342cf3232f	643c3268002137342cf32364
643c326e002137342cf32456	643c3268002137342cf3232f	643c3268002137342cf32365
643c326e002137342cf32457	643c3268002137342cf3232f	643c3268002137342cf32366
643c326e002137342cf32458	643c3268002137342cf3232f	643c3268002137342cf32371
643c326e002137342cf32459	643c3268002137342cf3232f	643c3268002137342cf32372
643c326e002137342cf3245a	643c3268002137342cf3232f	643c3268002137342cf32373
643c326e002137342cf3245d	643c3268002137342cf3232f	643c3268002137342cf32376
643c326e002137342cf3245c	643c3268002137342cf3232f	643c3268002137342cf32375
643c326e002137342cf3245b	643c3268002137342cf3232f	643c3268002137342cf32374
643c326e002137342cf3245f	643c3268002137342cf3232f	643c3268002137342cf32384
643c326e002137342cf32460	643c3268002137342cf3232f	643c3268002137342cf32385
643c326e002137342cf3245e	643c3268002137342cf3232f	643c3268002137342cf32383
643c326e002137342cf32462	643c3268002137342cf3232f	643c3268002137342cf32387
643c326e002137342cf32461	643c3268002137342cf3232f	643c3268002137342cf32386
643c326e002137342cf32463	643c3268002137342cf3232f	643c3268002137342cf3237e
643c326e002137342cf32464	643c3268002137342cf3232f	643c3268002137342cf3237f
643c326e002137342cf32465	643c3268002137342cf3232f	643c3268002137342cf32380
643c326e002137342cf32466	643c3268002137342cf3232f	643c3268002137342cf32381
643c326e002137342cf32467	643c3268002137342cf3232f	643c3268002137342cf32382
643c326e002137342cf32468	643c3268002137342cf3232f	643c3269002137342cf3238b
643c326e002137342cf32469	643c3268002137342cf3232f	643c3269002137342cf3238c
643c326e002137342cf3246a	643c3268002137342cf3232f	643c3269002137342cf3238d
643c326e002137342cf3246b	643c3268002137342cf3232f	643c3269002137342cf3238e
643c326e002137342cf3246c	643c3268002137342cf3232f	643c3269002137342cf3238f
643c326e002137342cf3246d	643c3268002137342cf3232f	643c3268002137342cf32377
643c326e002137342cf3246e	643c3268002137342cf3232f	643c3268002137342cf32378
643c326e002137342cf3246f	643c3268002137342cf3232f	643c3268002137342cf32379
643c326e002137342cf32470	643c3268002137342cf3232f	643c3268002137342cf3237a
643c326e002137342cf32471	643c3268002137342cf3232f	643c3269002137342cf32390
643c326e002137342cf32472	643c3268002137342cf3232f	643c3269002137342cf32391
643c326e002137342cf32473	643c3268002137342cf3232f	643c3269002137342cf32392
643c326e002137342cf32474	643c3268002137342cf3232f	643c3269002137342cf32393
643c326e002137342cf32475	643c3268002137342cf3232f	643c3269002137342cf32397
643c326e002137342cf32476	643c3268002137342cf3232f	643c3269002137342cf32398
643c326e002137342cf32478	643c3268002137342cf3232f	643c3269002137342cf3239a
643c326e002137342cf32477	643c3268002137342cf3232f	643c3269002137342cf32399
643c326e002137342cf32479	643c3268002137342cf3232f	643c3268002137342cf32339
643c326e002137342cf3247b	643c3268002137342cf3232f	643c3269002137342cf3239c
643c326e002137342cf3247e	643c3268002137342cf3232f	643c3269002137342cf3239f
643c326e002137342cf3247f	643c3268002137342cf3232f	643c3269002137342cf323a0
643c326e002137342cf32480	643c3268002137342cf3232f	643c3269002137342cf323a1
643c326e002137342cf32481	643c3268002137342cf3232f	643c3269002137342cf323a2
643c326e002137342cf32482	643c3268002137342cf3232f	643c3269002137342cf323a3
643c326e002137342cf3247a	643c3268002137342cf3232f	643c3269002137342cf3239b
643c326e002137342cf3247d	643c3268002137342cf3232f	643c3269002137342cf3239e
643c326e002137342cf3247c	643c3268002137342cf3232f	643c3269002137342cf3239d
643c326e002137342cf32483	643c3268002137342cf3232f	643c3269002137342cf323a4
643c326e002137342cf32484	643c3268002137342cf3232f	643c3269002137342cf323a5
643c326e002137342cf32485	643c3268002137342cf3232f	643c3269002137342cf323a6
643c326e002137342cf32486	643c3268002137342cf3232b	643c3268002137342cf3233e
643c326e002137342cf32487	643c3268002137342cf3232b	643c3268002137342cf3233f
643c326e002137342cf32488	643c3268002137342cf3232b	643c3268002137342cf32340
643c326e002137342cf32489	643c3268002137342cf3232b	643c3268002137342cf32341
643c326e002137342cf3248d	643c3268002137342cf3232b	643c3268002137342cf32345
643c326e002137342cf3248e	643c3268002137342cf3232b	643c3268002137342cf3237c
643c326e002137342cf3248a	643c3268002137342cf3232b	643c3268002137342cf32342
643c326e002137342cf3248c	643c3268002137342cf3232b	643c3268002137342cf32344
643c326e002137342cf3248b	643c3268002137342cf3232b	643c3268002137342cf32343
643c326e002137342cf3248f	643c3268002137342cf3232b	643c3268002137342cf32346
643c326e002137342cf32490	643c3268002137342cf3232b	643c3268002137342cf32347
643c326e002137342cf32491	643c3268002137342cf3232b	643c3268002137342cf32349
643c326e002137342cf32492	643c3268002137342cf3232b	643c3268002137342cf3234a
643c326e002137342cf32493	643c3268002137342cf3232b	643c3268002137342cf3234b
643c326e002137342cf32494	643c3268002137342cf3232b	643c3268002137342cf3234c
643c326e002137342cf32495	643c3268002137342cf3232b	643c3268002137342cf3234d
643c326e002137342cf32496	643c3268002137342cf3232b	643c3268002137342cf3234e
643c326e002137342cf32497	643c3268002137342cf3232b	643c3268002137342cf32356
643c326e002137342cf32498	643c3268002137342cf3232b	643c3268002137342cf32357
643c326e002137342cf3249a	643c3268002137342cf3232b	643c3268002137342cf32359
643c326e002137342cf3249b	643c3268002137342cf3232b	643c3268002137342cf3235a
643c326e002137342cf32499	643c3268002137342cf3232b	643c3268002137342cf32358
643c326e002137342cf3249c	643c3268002137342cf3232b	643c3268002137342cf3235b
643c326e002137342cf3249d	643c3268002137342cf3232b	643c3268002137342cf3235c
643c326e002137342cf3249e	643c3268002137342cf3232b	643c3268002137342cf3235d
643c326e002137342cf3249f	643c3268002137342cf3232b	643c3268002137342cf3235e
643c326e002137342cf324a2	643c3268002137342cf3232b	643c3268002137342cf32361
643c326e002137342cf324a0	643c3268002137342cf3232b	643c3268002137342cf3235f
643c326e002137342cf324a1	643c3268002137342cf3232b	643c3268002137342cf32360
643c326e002137342cf324a3	643c3268002137342cf3232b	643c3268002137342cf3234f
643c326e002137342cf324a4	643c3268002137342cf3232b	643c3268002137342cf32352
643c326e002137342cf324a5	643c3268002137342cf3232b	643c3268002137342cf3237e
643c326e002137342cf324a6	643c3268002137342cf3232b	643c3268002137342cf3237f
643c326e002137342cf324a8	643c3268002137342cf3232b	643c3268002137342cf32381
643c326e002137342cf324a9	643c3268002137342cf3232b	643c3268002137342cf32382
643c326e002137342cf324a7	643c3268002137342cf3232b	643c3268002137342cf32380
643c326e002137342cf324aa	643c3268002137342cf3232b	643c3269002137342cf3238b
643c326e002137342cf324ab	643c3268002137342cf3232b	643c3269002137342cf3238c
643c326e002137342cf324ac	643c3268002137342cf3232b	643c3269002137342cf3238d
643c326e002137342cf324ad	643c3268002137342cf3232b	643c3269002137342cf3238e
643c326e002137342cf324ae	643c3268002137342cf3232b	643c3269002137342cf3238f
643c326e002137342cf324af	643c3268002137342cf3232b	643c3268002137342cf32383
643c326e002137342cf324b0	643c3268002137342cf3232b	643c3268002137342cf32384
643c326e002137342cf324b1	643c3268002137342cf3232b	643c3268002137342cf32377
643c326e002137342cf324b2	643c3268002137342cf3232b	643c3268002137342cf32378
643c326e002137342cf324b3	643c3268002137342cf3232b	643c3269002137342cf32397
643c326e002137342cf324b4	643c3268002137342cf3232b	643c3269002137342cf32398
643c326e002137342cf324b5	643c3268002137342cf3232c	643c3268002137342cf32341
643c326e002137342cf324b6	643c3268002137342cf3232c	643c3268002137342cf32342
643c326e002137342cf324b7	643c3268002137342cf3232c	643c3268002137342cf32344
643c326e002137342cf324b8	643c3268002137342cf3232c	643c3268002137342cf32346
643c326e002137342cf324b9	643c3268002137342cf3232c	643c3268002137342cf32347
643c326e002137342cf324ba	643c3268002137342cf3232c	643c3268002137342cf32349
643c326e002137342cf324bc	643c3268002137342cf3232c	643c3268002137342cf3234b
643c326e002137342cf324bb	643c3268002137342cf3232c	643c3268002137342cf3234a
643c326e002137342cf324bd	643c3268002137342cf3232c	643c3268002137342cf3234d
643c326e002137342cf324be	643c3268002137342cf3232c	643c3268002137342cf32356
643c326e002137342cf324bf	643c3268002137342cf3232c	643c3268002137342cf32357
643c326e002137342cf324c0	643c3268002137342cf3232c	643c3268002137342cf3235c
643c326e002137342cf324c1	643c3268002137342cf3232c	643c3268002137342cf3234f
643c326e002137342cf324c2	643c3268002137342cf3232c	643c3268002137342cf32352
643c326e002137342cf324c3	643c3268002137342cf3232c	643c3268002137342cf3237e
643c326e002137342cf324c4	643c3268002137342cf3232c	643c3268002137342cf32381
643c326e002137342cf324c5	643c3268002137342cf3232c	643c3269002137342cf3238b
643c326e002137342cf324c6	643c3268002137342cf3232c	643c3269002137342cf3238c
643c326e002137342cf324c7	643c3268002137342cf3232c	643c3268002137342cf32383
643c326e002137342cf324c8	643c3268002137342cf3232c	643c3268002137342cf32384
643c326e002137342cf324c9	643c3268002137342cf3232c	643c3268002137342cf32377
643c326e002137342cf324ca	643c3268002137342cf3232c	643c3268002137342cf32378
643c326e002137342cf324cb	643c3268002137342cf3232c	643c3269002137342cf32397
643c326e002137342cf324cc	643c3268002137342cf3232c	643c3269002137342cf32398
643c326e002137342cf324cd	643c3268002137342cf3232d	643c3268002137342cf32341
643c326e002137342cf324ce	643c3268002137342cf3232d	643c3268002137342cf32342
643c326e002137342cf324cf	643c3268002137342cf3232d	643c3268002137342cf32344
643c326e002137342cf324d0	643c3268002137342cf3232d	643c3268002137342cf32346
643c326e002137342cf324d1	643c3268002137342cf3232d	643c3268002137342cf32347
643c326e002137342cf324d2	643c3268002137342cf3232d	643c3268002137342cf32349
643c326e002137342cf324d3	643c3268002137342cf3232d	643c3268002137342cf3234a
643c326e002137342cf324d4	643c3268002137342cf3232d	643c3268002137342cf3234b
643c326e002137342cf324d5	643c3268002137342cf3232d	643c3268002137342cf32356
643c326e002137342cf324d6	643c3268002137342cf3232d	643c3268002137342cf32357
643c326e002137342cf324d7	643c3268002137342cf3232d	643c3268002137342cf3235c
643c326e002137342cf324d8	643c3268002137342cf3232d	643c3268002137342cf3234f
643c326e002137342cf324d9	643c3268002137342cf3232d	643c3268002137342cf3237e
643c326e002137342cf324da	643c3268002137342cf3232d	643c3268002137342cf32381
643c326e002137342cf324db	643c3268002137342cf3232d	643c3269002137342cf3238b
643c326e002137342cf324dc	643c3268002137342cf3232d	643c3269002137342cf3238c
\.


--
-- TOC entry 3076 (class 0 OID 24750)
-- Dependencies: 224
-- Data for Name: permissions_users; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.permissions_users (id, user_id, permission_id) FROM stdin;
\.


--
-- TOC entry 3087 (class 0 OID 24862)
-- Dependencies: 235
-- Data for Name: post_revisions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.post_revisions (id, post_id, lexical, created_at_ts, created_at) FROM stdin;
\.


--
-- TOC entry 3068 (class 0 OID 24608)
-- Dependencies: 216
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.posts (id, uuid, title, slug, mobiledoc, lexical, html, comment_id, plaintext, feature_image, featured, type, status, locale, visibility, email_recipient_filter, created_at, created_by, updated_at, updated_by, published_at, published_by, custom_excerpt, codeinjection_head, codeinjection_foot, custom_template, canonical_url, newsletter_id) FROM stdin;
643c3269002137342cf323a7	e152566d-4077-4747-b6e4-eaf0a9bbfbd2	Coming soon	coming-soon	{"type":"doc","content":[{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"This is Vontigo Demo Site, a brand-new site by a Vontigoers that's just getting started. Things will be up and running here shortly, but you can subscribe in the meantime if you'd like to stay up to date and receive emails when new content is published!"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Or you can create another site using Vontigo CMS via https://vontigo.org."}]}]}	\N	<p>This is Vontigo Demo Site, a brand-new site by a Vontigoers that's just getting started. Things will be up and running here shortly, but you can subscribe in the meantime if you'd like to stay up to date and receive emails when new content is published!</p><p>Or you can create another site using Vontigo CMS via https://vontigo.org.</p>	643c3269002137342cf323a7	This is Vontigo Demo Site, a brand-new site by a Vontigoers that's just getting started. Things will be up and running here shortly, but you can subscribe in the meantime if you'd like to stay up to date and receive emails when new content is published!\\n\\nOr you can create another site using Vontigo CMS via https://vontigo.org.	/content/en-us/images/size/_raw/2023/05/643c3269002137342cf323a7_3d-render-futuristic-modern-network-communications-design.jpg	t	post	published	en-us	public	all	2023-04-16 17:37:45	1	2023-04-16 17:42:16	643c3269002137342cf323a7	2023-04-16 17:37:45	1	We've crammed the most important information to help you get started with Vontigo into this one post. It's your cheat-sheet to get started, and your shortcut to advanced features.	\N	\N		\N	\N
645cf2a06c7c7c2738978099	f7cbe440-b793-4554-a689-236b3a51442e	The next of future Content Management System Powered by AI.	the-next-of-future-content-management-system-powered-by-ai	{"type":"doc","content":[{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"The new generation of CMS powered by AI is revolutionizing the way we create and manage content. With the help of artificial intelligence, CMS platforms are becoming more intelligent, intuitive, and efficient than ever before."}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"One of the key benefits of AI-powered CMS is the ability to automate repetitive tasks, such as content creation, curation, and optimization. This frees up time for content creators to focus on more strategic tasks, such as developing new ideas and engaging with their audience."}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Another advantage of AI-powered CMS is the ability to personalize content for individual users. By analyzing user data, AI algorithms can deliver personalized content recommendations, tailored to each user's interests and preferences. This not only improves the user experience but also increases engagement and conversions."}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered CMS also offers advanced analytics and reporting capabilities, allowing content creators to track and analyze the performance of their content in real-time. This data can be used to optimize content for better engagement and conversions, as well as to identify new opportunities for growth and expansion."}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Overall, the new generation of CMS powered by AI is transforming the way we create, manage, and optimize content. By automating repetitive tasks, personalizing content, and providing advanced analytics, AI-powered CMS platforms are helping content creators to work smarter, not harder. As AI technology continues to evolve, we can expect to see even more innovative features and capabilities in the future. "}]},{"type":"paragraph","attrs":{"textAlign":"center"},"content":[{"type":"text","marks":[{"type":"italic"}],"text":"\\"The stuff shown above is solely for demonstration purposes. To receive the authentic ChatGPT content, please enter your OpenAI key in Settings > BrainiacMinds > Aim Key area!\\" "}]}]}	\N	<p>The new generation of CMS powered by AI is revolutionizing the way we create and manage content. With the help of artificial intelligence, CMS platforms are becoming more intelligent, intuitive, and efficient than ever before.</p><p>One of the key benefits of AI-powered CMS is the ability to automate repetitive tasks, such as content creation, curation, and optimization. This frees up time for content creators to focus on more strategic tasks, such as developing new ideas and engaging with their audience.</p><p>Another advantage of AI-powered CMS is the ability to personalize content for individual users. By analyzing user data, AI algorithms can deliver personalized content recommendations, tailored to each user's interests and preferences. This not only improves the user experience but also increases engagement and conversions.</p><p>AI-powered CMS also offers advanced analytics and reporting capabilities, allowing content creators to track and analyze the performance of their content in real-time. This data can be used to optimize content for better engagement and conversions, as well as to identify new opportunities for growth and expansion.</p><p>Overall, the new generation of CMS powered by AI is transforming the way we create, manage, and optimize content. By automating repetitive tasks, personalizing content, and providing advanced analytics, AI-powered CMS platforms are helping content creators to work smarter, not harder. As AI technology continues to evolve, we can expect to see even more innovative features and capabilities in the future. </p><p style="text-align: center"><em>"The stuff shown above is solely for demonstration purposes. To receive the authentic ChatGPT content, please enter your OpenAI key in Settings &gt; BrainiacMinds &gt; Aim Key area!" </em></p>	645cf2a06c7c7c273897809a	The new generation of CMS powered by AI is revolutionizing the way we create and manage content. With the help of artificial intelligence, CMS platforms are becoming more intelligent, intuitive, and efficient than ever before.\\n\\nOne of the key benefits of AI-powered CMS is the ability to automate repetitive tasks, such as content creation, curation, and optimization. This frees up time for content creators to focus on more strategic tasks, such as developing new ideas and engaging with their audience.\\n\\nAnother advantage of AI-powered CMS is the ability to personalize content for individual users. By analyzing user data, AI algorithms can deliver personalized content recommendations, tailored to each user's interests and preferences. This not only improves the user experience but also increases engagement and conversions.\\n\\nAI-powered CMS also offers advanced analytics and reporting capabilities, allowing content creators to track and analyze the performance of their content in real-time. This data can be used to optimize content for better engagement and conversions, as well as to identify new opportunities for growth and expansion.\\n\\nOverall, the new generation of CMS powered by AI is transforming the way we create, manage, and optimize content. By automating repetitive tasks, personalizing content, and providing advanced analytics, AI-powered CMS platforms are helping content creators to work smarter, not harder. As AI technology continues to evolve, we can expect to see even more innovative features and capabilities in the future. \\n\\n"The stuff shown above is solely for demonstration purposes. To receive the authentic ChatGPT content, please enter your OpenAI key in Settings > BrainiacMinds > Aim Key area!" 	/content/en-us/images/size/_raw/2023/05/645cf2a06c7c7c2738978099_feature-image.png	t	post	published	en-us	public	all	2023-05-11 13:50:00	1	2023-05-11 13:50:00	1	2023-05-12 13:55:00	1	The new generation of CMS powered by AI is revolutionizing the way we create and manage content. With the help of artificial intelligence, CMS platforms are becoming more intelligent, intuitive, and efficient than ever before.	\N	\N	\N	\N	\N
645cf4656c7c7c273897809b	04cdfef5-740a-432a-8407-f55075022443	A.I. is revolutionizing the world in various industries, including CMS	ai-is-revolutionizing-the-world-in-various-industries-including-cms-1	{"type":"doc","content":[{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Artificial Intelligence (AI) is revolutionizing the world in various industries, including content management systems (CMS). AI has the power to analyze large amounts of data and make predictions, allowing businesses to make data-driven decisions. In this article, we will explore the benefits of AI with CMS and how it can improve your content creation and management."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Personalization"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Improved Search"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Content Creation"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI can help in creating content by generating ideas, identifying trending topics, and even writing content. AI algorithms can analyze user behavior and content trends to generate content ideas that are more likely to engage and resonate with the target audience."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Content Optimization"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Predictive Analytics"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Chatbots"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues."}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"In conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From personalization to predictive analytics, AI can help businesses make data-driven decisions and improve user engagement. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS."}]}]}	\N	<p>Artificial Intelligence (AI) is revolutionizing the world in various industries, including content management systems (CMS). AI has the power to analyze large amounts of data and make predictions, allowing businesses to make data-driven decisions. In this article, we will explore the benefits of AI with CMS and how it can improve your content creation and management.</p><h2>Personalization</h2><p>AI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales.</p><h2>Improved Search</h2><p>AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates.</p><h2>Content Creation</h2><p>AI can help in creating content by generating ideas, identifying trending topics, and even writing content. AI algorithms can analyze user behavior and content trends to generate content ideas that are more likely to engage and resonate with the target audience.</p><h2>Content Optimization</h2><p>AI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.</p><h2>Predictive Analytics</h2><p>AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Chatbots</h2><p>AI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues.</p><p>In conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From personalization to predictive analytics, AI can help businesses make data-driven decisions and improve user engagement. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS.</p>	645cf4656c7c7c273897809c	Artificial Intelligence (AI) is revolutionizing the world in various industries, including content management systems (CMS). AI has the power to analyze large amounts of data and make predictions, allowing businesses to make data-driven decisions. In this article, we will explore the benefits of AI with CMS and how it can improve your content creation and management.\\n\\nPersonalization\\n\\nAI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales.\\n\\nImproved Search\\n\\nAI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates.\\n\\nContent Creation\\n\\nAI can help in creating content by generating ideas, identifying trending topics, and even writing content. AI algorithms can analyze user behavior and content trends to generate content ideas that are more likely to engage and resonate with the target audience.\\n\\nContent Optimization\\n\\nAI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.\\n\\nPredictive Analytics\\n\\nAI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\\n\\nChatbots\\n\\nAI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues.\\n\\nIn conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From personalization to predictive analytics, AI can help businesses make data-driven decisions and improve user engagement. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS.	/content/en-us/images/size/_raw/2023/05/645cf4656c7c7c273897809b_cool-geometric-triangular-figure-neon-laser-light-great-backgrounds.jpg	f	post	published	en-us	public	all	2023-05-11 13:57:00	1	2023-05-11 13:57:00	1	2023-05-11 14:02:00	1	Artificial Intelligence (AI) is revolutionizing the world in various industries, including content management systems (CMS). AI has the power to analyze large amounts of data and make predictions, allowing businesses to make data-driven decisions. In this article, we will explore the benefits of AI 	\N	\N	\N	\N	\N
645cf6336c7c7c273897809d	c9af9ce4-ae04-4d88-b156-6d223b1dd9ec	How AI is Transforming Content Creation with CMS	how-ai-is-transforming-content-creation-with-cms	{"type":"doc","content":[{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Artificial Intelligence (AI) has the potential to revolutionize content creation with content management systems (CMS). AI-powered CMS can improve the efficiency and effectiveness of content creation by automating certain tasks and providing data-driven insights. In this article, we will explore how AI is transforming content creation with CMS."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Automated Content Creation"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI algorithms can analyze user behavior and content trends to generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Content Optimization"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Personalization"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Improved Search"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Predictive Analytics"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Chatbots"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues."}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"In conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From automated content creation to personalized experiences, AI can help businesses create content that is engaging, relevant, and optimized for success. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS."}]}]}	\N	<p>Artificial Intelligence (AI) has the potential to revolutionize content creation with content management systems (CMS). AI-powered CMS can improve the efficiency and effectiveness of content creation by automating certain tasks and providing data-driven insights. In this article, we will explore how AI is transforming content creation with CMS.</p><h2>Automated Content Creation</h2><p>AI algorithms can analyze user behavior and content trends to generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging.</p><h2>Content Optimization</h2><p>AI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.</p><h2>Personalization</h2><p>AI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales.</p><h2>Improved Search</h2><p>AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates.</p><h2>Predictive Analytics</h2><p>AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Chatbots</h2><p>AI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues.</p><p>In conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From automated content creation to personalized experiences, AI can help businesses create content that is engaging, relevant, and optimized for success. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS.</p>	645cf6336c7c7c273897809e	Artificial Intelligence (AI) has the potential to revolutionize content creation with content management systems (CMS). AI-powered CMS can improve the efficiency and effectiveness of content creation by automating certain tasks and providing data-driven insights. In this article, we will explore how AI is transforming content creation with CMS.\\n\\nAutomated Content Creation\\n\\nAI algorithms can analyze user behavior and content trends to generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging.\\n\\nContent Optimization\\n\\nAI-powered CMS can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.\\n\\nPersonalization\\n\\nAI-powered CMS can personalize content to individual users. AI algorithms can analyze user data, such as browsing behavior and previous interactions, to create a personalized experience for each user. Personalization can improve engagement and increase user satisfaction, leading to higher conversion rates and sales.\\n\\nImproved Search\\n\\nAI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. This can enhance user experience and reduce bounce rates.\\n\\nPredictive Analytics\\n\\nAI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\\n\\nChatbots\\n\\nAI-powered chatbots can provide a personalized and responsive customer service experience. Chatbots can answer customer queries, provide information, and even handle basic transactions, freeing up customer service representatives to handle more complex issues.\\n\\nIn conclusion, AI with CMS can provide numerous benefits for businesses looking to improve their content creation and management. From automated content creation to personalized experiences, AI can help businesses create content that is engaging, relevant, and optimized for success. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS.	/content/en-us/images/size/_raw/2023/05/645cf6336c7c7c273897809d_3d-abstract-background-with-futuristic-particles.jpg	t	post	published	en-us	public	all	2023-05-11 14:05:00	1	2023-05-11 14:05:00	1	2023-05-11 14:07:00	1	\N	\N	\N	\N	\N	\N
645cf6c76c7c7c273897809f	411b022a-1d87-42c6-9b3c-6e849d38bc2e	How AI is Revolutionizing Blogger Support	how-ai-is-revolutionizing-blogger-support	{"type":"doc","content":[{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Artificial Intelligence (AI) has the potential to revolutionize the way bloggers receive support. AI-powered support tools can provide faster and more accurate solutions to common problems, improving the overall experience for bloggers. In this article, we will explore how AI is revolutionizing blogger support."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Automated Support"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"AI-powered support tools can automate certain tasks, such as providing answers to frequently asked questions or resolving common issues. This can save time and resources for support teams while ensuring that bloggers receive quick and accurate solutions to their problems."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Personalized Support"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"AI algorithms can analyze blogger data, such as browsing behavior and previous interactions, to create a personalized support experience for each blogger. Personalization can improve engagement and increase blogger satisfaction, leading to higher retention rates."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Improved Search"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"AI algorithms can improve search capabilities within support systems by analyzing blogger search queries and providing relevant results. This can enhance the blogger experience and reduce frustration."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Predictive Analytics"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"AI algorithms can analyze data to predict future trends and behavior. This can help support teams proactively address potential issues before they become problems. Predictive analytics can also help in identifying opportunities for improvement in the support process."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Chatbots"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"AI-powered chatbots can provide a personalized and responsive support experience. Chatbots can answer blogger queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems."}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"In conclusion, AI support tools can provide numerous benefits for bloggers looking for fast and accurate solutions to their problems. From automated support to personalized experiences, AI can help bloggers get the support they need to succeed. As AI technology continues to evolve, bloggers can expect even more advanced capabilities and benefits from AI-powered support systems."}]}]}	\N	<p>Artificial Intelligence (AI) has the potential to revolutionize the way bloggers receive support. AI-powered support tools can provide faster and more accurate solutions to common problems, improving the overall experience for bloggers. In this article, we will explore how AI is revolutionizing blogger support.</p><h2>Automated Support</h2><p style="text-align: start">AI-powered support tools can automate certain tasks, such as providing answers to frequently asked questions or resolving common issues. This can save time and resources for support teams while ensuring that bloggers receive quick and accurate solutions to their problems.</p><h2>Personalized Support</h2><p style="text-align: start">AI algorithms can analyze blogger data, such as browsing behavior and previous interactions, to create a personalized support experience for each blogger. Personalization can improve engagement and increase blogger satisfaction, leading to higher retention rates.</p><h2>Improved Search</h2><p style="text-align: start">AI algorithms can improve search capabilities within support systems by analyzing blogger search queries and providing relevant results. This can enhance the blogger experience and reduce frustration.</p><h2>Predictive Analytics</h2><p style="text-align: start">AI algorithms can analyze data to predict future trends and behavior. This can help support teams proactively address potential issues before they become problems. Predictive analytics can also help in identifying opportunities for improvement in the support process.</p><h2>Chatbots</h2><p style="text-align: start">AI-powered chatbots can provide a personalized and responsive support experience. Chatbots can answer blogger queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems.</p><p style="text-align: start">In conclusion, AI support tools can provide numerous benefits for bloggers looking for fast and accurate solutions to their problems. From automated support to personalized experiences, AI can help bloggers get the support they need to succeed. As AI technology continues to evolve, bloggers can expect even more advanced capabilities and benefits from AI-powered support systems.</p>	645cf6c76c7c7c27389780a0	Artificial Intelligence (AI) has the potential to revolutionize the way bloggers receive support. AI-powered support tools can provide faster and more accurate solutions to common problems, improving the overall experience for bloggers. In this article, we will explore how AI is revolutionizing blogger support.\\n\\nAutomated Support\\n\\nAI-powered support tools can automate certain tasks, such as providing answers to frequently asked questions or resolving common issues. This can save time and resources for support teams while ensuring that bloggers receive quick and accurate solutions to their problems.\\n\\nPersonalized Support\\n\\nAI algorithms can analyze blogger data, such as browsing behavior and previous interactions, to create a personalized support experience for each blogger. Personalization can improve engagement and increase blogger satisfaction, leading to higher retention rates.\\n\\nImproved Search\\n\\nAI algorithms can improve search capabilities within support systems by analyzing blogger search queries and providing relevant results. This can enhance the blogger experience and reduce frustration.\\n\\nPredictive Analytics\\n\\nAI algorithms can analyze data to predict future trends and behavior. This can help support teams proactively address potential issues before they become problems. Predictive analytics can also help in identifying opportunities for improvement in the support process.\\n\\nChatbots\\n\\nAI-powered chatbots can provide a personalized and responsive support experience. Chatbots can answer blogger queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems.\\n\\nIn conclusion, AI support tools can provide numerous benefits for bloggers looking for fast and accurate solutions to their problems. From automated support to personalized experiences, AI can help bloggers get the support they need to succeed. As AI technology continues to evolve, bloggers can expect even more advanced capabilities and benefits from AI-powered support systems.	/content/en-us/images/size/_raw/2023/05/645cf6c76c7c7c273897809f_technology-network-background-connection-cyber-space-ai-generative.jpg	t	post	published	en-us	public	all	2023-05-11 14:08:00	1	2023-05-11 14:08:00	1	2023-05-11 14:11:00	1	Artificial Intelligence (AI) has the potential to revolutionize the way bloggers receive support.	\N	\N	\N	\N	\N
645cf7e86c7c7c27389780a1	c8d67409-0e7c-46d0-98a6-36b0ec4431c9	How AI is Bringing Benefits to the Digital Content Industry	how-ai-is-bringing-benefits-to-the-digital-content-industry	{"type":"doc","content":[{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Artificial Intelligence (AI) is transforming the digital content industry by enabling content creators and marketers to create, manage, and distribute content more efficiently and effectively. AI-powered tools are making it possible to personalize content for individual users, optimize content for search engines, and even automate content creation. In this article, we will explore how AI is bringing benefits to the digital content industry."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Personalization"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"AI algorithms can analyze user data, such as browsing behavior and past interactions, to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Optimization"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"AI-powered tools can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Automated Content Creation"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"AI algorithms can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Content Distribution"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"AI-powered tools can analyze user data to determine the best channels and times to distribute content for maximum engagement. This can improve the effectiveness of content distribution and increase reach and visibility."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Predictive Analytics"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Improved User Experience"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"AI-powered tools can improve the overall user experience by providing personalized recommendations, streamlined navigation, and more relevant content. This can increase user satisfaction and loyalty, leading to higher retention rates and revenue."}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"In conclusion, AI is bringing numerous benefits to the digital content industry. From personalized content experiences to automated content creation, AI-powered tools are making it possible for businesses to create, manage, and distribute content more efficiently and effectively. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered digital content solutions."}]}]}	\N	<p>Artificial Intelligence (AI) is transforming the digital content industry by enabling content creators and marketers to create, manage, and distribute content more efficiently and effectively. AI-powered tools are making it possible to personalize content for individual users, optimize content for search engines, and even automate content creation. In this article, we will explore how AI is bringing benefits to the digital content industry.</p><h2>Personalization</h2><p style="text-align: start">AI algorithms can analyze user data, such as browsing behavior and past interactions, to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions.</p><h2>Optimization</h2><p style="text-align: start">AI-powered tools can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.</p><h2>Automated Content Creation</h2><p style="text-align: start">AI algorithms can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging.</p><h2>Content Distribution</h2><p style="text-align: start">AI-powered tools can analyze user data to determine the best channels and times to distribute content for maximum engagement. This can improve the effectiveness of content distribution and increase reach and visibility.</p><h2>Predictive Analytics</h2><p style="text-align: start">AI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Improved User Experience</h2><p style="text-align: start">AI-powered tools can improve the overall user experience by providing personalized recommendations, streamlined navigation, and more relevant content. This can increase user satisfaction and loyalty, leading to higher retention rates and revenue.</p><p style="text-align: start">In conclusion, AI is bringing numerous benefits to the digital content industry. From personalized content experiences to automated content creation, AI-powered tools are making it possible for businesses to create, manage, and distribute content more efficiently and effectively. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered digital content solutions.</p>	645cf7e86c7c7c27389780a2	Artificial Intelligence (AI) is transforming the digital content industry by enabling content creators and marketers to create, manage, and distribute content more efficiently and effectively. AI-powered tools are making it possible to personalize content for individual users, optimize content for search engines, and even automate content creation. In this article, we will explore how AI is bringing benefits to the digital content industry.\\n\\nPersonalization\\n\\nAI algorithms can analyze user data, such as browsing behavior and past interactions, to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions.\\n\\nOptimization\\n\\nAI-powered tools can analyze content and provide recommendations for optimization. This includes identifying keywords, improving readability, and enhancing the overall structure and flow of the content. AI can also analyze user behavior to determine which content performs best and provide insights for future content creation.\\n\\nAutomated Content Creation\\n\\nAI algorithms can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging.\\n\\nContent Distribution\\n\\nAI-powered tools can analyze user data to determine the best channels and times to distribute content for maximum engagement. This can improve the effectiveness of content distribution and increase reach and visibility.\\n\\nPredictive Analytics\\n\\nAI algorithms can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\\n\\nImproved User Experience\\n\\nAI-powered tools can improve the overall user experience by providing personalized recommendations, streamlined navigation, and more relevant content. This can increase user satisfaction and loyalty, leading to higher retention rates and revenue.\\n\\nIn conclusion, AI is bringing numerous benefits to the digital content industry. From personalized content experiences to automated content creation, AI-powered tools are making it possible for businesses to create, manage, and distribute content more efficiently and effectively. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered digital content solutions.	/content/en-us/images/size/_raw/2023/05/645cf7e86c7c7c27389780a1_blurred-night-lights.jpg	t	post	published	en-us	public	all	2023-05-11 14:12:00	1	2023-05-11 14:12:00	1	2023-05-11 14:13:00	1	Artificial Intelligence (AI) is transforming the digital content industry by enabling content creators and marketers to create, manage, and distribute content more efficiently and effectively.	\N	\N	\N	\N	\N
645cf86e6c7c7c27389780a3	2360b917-41f4-44ca-8a0a-057a6b24fcd3	How AI Integration with CMS will Bring a Bright Future to Any System	how-ai-integration-with-cms-will-bring-a-bright-future-to-any-system	{"type":"doc","content":[{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Artificial Intelligence (AI) is transforming the way businesses operate and is becoming increasingly integrated with Content Management Systems (CMS). By combining AI with CMS, businesses can unlock new capabilities and insights that were previously impossible to achieve. In this article, we will explore how AI integration with CMS will bring a bright future to any system."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Automated Content Creation"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI algorithms can generate content ideas and even write content. By integrating AI with CMS, businesses can automate the content creation process, saving time and resources while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Personalized Content Delivery"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI algorithms can analyze user data to create personalized content experiences for individual users. By integrating AI with CMS, businesses can deliver content that is tailored to each user's preferences, interests, and needs. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Predictive Analytics"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI algorithms can analyze data to predict future trends and behavior. By integrating AI with CMS, businesses can use predictive analytics to make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Improved Search"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. By integrating AI with CMS, businesses can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Chatbots"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered chatbots can provide a personalized and responsive support experience. By integrating AI with CMS, businesses can use chatbots to answer user queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems."}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"In conclusion, integrating AI with CMS can bring numerous benefits to any system. From automated content creation to personalized content delivery, predictive analytics, improved search, and chatbots, businesses can use AI to unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions."}]}]}	\N	<p>Artificial Intelligence (AI) is transforming the way businesses operate and is becoming increasingly integrated with Content Management Systems (CMS). By combining AI with CMS, businesses can unlock new capabilities and insights that were previously impossible to achieve. In this article, we will explore how AI integration with CMS will bring a bright future to any system.</p><h2>Automated Content Creation</h2><p>AI algorithms can generate content ideas and even write content. By integrating AI with CMS, businesses can automate the content creation process, saving time and resources while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.</p><h2>Personalized Content Delivery</h2><p>AI algorithms can analyze user data to create personalized content experiences for individual users. By integrating AI with CMS, businesses can deliver content that is tailored to each user's preferences, interests, and needs. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions.</p><h2>Predictive Analytics</h2><p>AI algorithms can analyze data to predict future trends and behavior. By integrating AI with CMS, businesses can use predictive analytics to make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Improved Search</h2><p>AI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. By integrating AI with CMS, businesses can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.</p><h2>Chatbots</h2><p>AI-powered chatbots can provide a personalized and responsive support experience. By integrating AI with CMS, businesses can use chatbots to answer user queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems.</p><p>In conclusion, integrating AI with CMS can bring numerous benefits to any system. From automated content creation to personalized content delivery, predictive analytics, improved search, and chatbots, businesses can use AI to unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions.</p>	645cf86e6c7c7c27389780a4	Artificial Intelligence (AI) is transforming the way businesses operate and is becoming increasingly integrated with Content Management Systems (CMS). By combining AI with CMS, businesses can unlock new capabilities and insights that were previously impossible to achieve. In this article, we will explore how AI integration with CMS will bring a bright future to any system.\\n\\nAutomated Content Creation\\n\\nAI algorithms can generate content ideas and even write content. By integrating AI with CMS, businesses can automate the content creation process, saving time and resources while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.\\n\\nPersonalized Content Delivery\\n\\nAI algorithms can analyze user data to create personalized content experiences for individual users. By integrating AI with CMS, businesses can deliver content that is tailored to each user's preferences, interests, and needs. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions.\\n\\nPredictive Analytics\\n\\nAI algorithms can analyze data to predict future trends and behavior. By integrating AI with CMS, businesses can use predictive analytics to make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\\n\\nImproved Search\\n\\nAI algorithms can improve search capabilities within CMS by analyzing user search queries and providing relevant results. By integrating AI with CMS, businesses can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.\\n\\nChatbots\\n\\nAI-powered chatbots can provide a personalized and responsive support experience. By integrating AI with CMS, businesses can use chatbots to answer user queries, provide information, and even handle basic issues, freeing up support teams to handle more complex problems.\\n\\nIn conclusion, integrating AI with CMS can bring numerous benefits to any system. From automated content creation to personalized content delivery, predictive analytics, improved search, and chatbots, businesses can use AI to unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions.	/content/en-us/images/size/_raw/2023/05/645cf86e6c7c7c27389780a3_3d-digital-landscape-modern-technology-background.jpg	f	post	published	en-us	public	all	2023-05-11 14:15:00	1	2023-05-11 14:15:00	1	2023-05-11 14:17:00	1	Artificial Intelligence (AI) is transforming the way businesses operate and is becoming increasingly integrated with Content Management Systems (CMS).	\N	\N	\N	\N	\N
645cf95c6c7c7c27389780a5	ac3b959e-71dc-449c-a818-c709faa0b075	How CMS Powered by AI will Change the World	how-cms-powered-by-ai-will-change-the-world	{"type":"doc","content":[{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Content Management Systems (CMS) are an essential part of many businesses, enabling them to create, manage, and distribute content. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. AI-powered CMS will change the way businesses operate, interact with customers, and even impact society as a whole. In this article, we will explore how CMS powered by AI will change the world."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Automated Content Creation"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered CMS can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Personalized Content Delivery"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered CMS can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Predictive Analytics"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered CMS can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Improved Search"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered CMS can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Chatbots"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered chatbots can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Social Media Management"}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"AI-powered CMS can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth."}]},{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"In conclusion, CMS powered by AI has the potential to revolutionize the way businesses operate and interact with customers. From automated content creation to personalized content delivery, predictive analytics, improved search, chatbots, and social media management, AI-powered CMS can unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions. The future of CMS is AI, and the possibilities are limitless."}]}]}	\N	<p>Content Management Systems (CMS) are an essential part of many businesses, enabling them to create, manage, and distribute content. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. AI-powered CMS will change the way businesses operate, interact with customers, and even impact society as a whole. In this article, we will explore how CMS powered by AI will change the world.</p><h2>Automated Content Creation</h2><p>AI-powered CMS can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.</p><h2>Personalized Content Delivery</h2><p>AI-powered CMS can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth.</p><h2>Predictive Analytics</h2><p>AI-powered CMS can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Improved Search</h2><p>AI-powered CMS can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.</p><h2>Chatbots</h2><p>AI-powered chatbots can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs.</p><h2>Social Media Management</h2><p>AI-powered CMS can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth.</p><p>In conclusion, CMS powered by AI has the potential to revolutionize the way businesses operate and interact with customers. From automated content creation to personalized content delivery, predictive analytics, improved search, chatbots, and social media management, AI-powered CMS can unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions. The future of CMS is AI, and the possibilities are limitless.</p>	645cf95c6c7c7c27389780a6	Content Management Systems (CMS) are an essential part of many businesses, enabling them to create, manage, and distribute content. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. AI-powered CMS will change the way businesses operate, interact with customers, and even impact society as a whole. In this article, we will explore how CMS powered by AI will change the world.\\n\\nAutomated Content Creation\\n\\nAI-powered CMS can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.\\n\\nPersonalized Content Delivery\\n\\nAI-powered CMS can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth.\\n\\nPredictive Analytics\\n\\nAI-powered CMS can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\\n\\nImproved Search\\n\\nAI-powered CMS can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.\\n\\nChatbots\\n\\nAI-powered chatbots can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs.\\n\\nSocial Media Management\\n\\nAI-powered CMS can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth.\\n\\nIn conclusion, CMS powered by AI has the potential to revolutionize the way businesses operate and interact with customers. From automated content creation to personalized content delivery, predictive analytics, improved search, chatbots, and social media management, AI-powered CMS can unlock new capabilities and insights that were previously impossible to achieve. As AI technology continues to evolve, businesses can expect even more advanced capabilities and benefits from AI-powered CMS solutions. The future of CMS is AI, and the possibilities are limitless.	/content/en-us/images/size/_raw/2023/05/645cf95c6c7c7c27389780a5_abstract-blue-background-with-many-small-details-generative-ai.jpg	f	post	published	en-us	public	all	2023-05-11 14:19:00	1	2023-05-11 14:19:00	1	2023-05-11 14:21:00	1	Content Management Systems (CMS) are an essential part of many businesses, enabling them to create, manage, and distribute content. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. 	\N	\N	\N	\N	\N
645cfb656c7c7c27389780a9	87d96d6c-e28d-4d75-91cf-1cab2d7658e4	Vontigo is the 1st open-source CMS with AI feature out of the box!	vontigo-is-the-1st-open-source-cms-with-ai-feature-out-of-the-box	{"type":"doc","content":[{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Open-Source Vontigo CMS with AI Out of the Box Core Features will Bring a lot of Benefits for Businesses and Users Around the World"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"Content Management Systems (CMS) have become essential for businesses of all sizes. They enable businesses to create, manage, and distribute content effectively. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. Open-source Vontigo CMS with AI out of the box core features is a game-changer. It will bring a lot of benefits for businesses and users around the world."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Automated Content Creation"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"Open-source Vontigo CMS with AI out of the box core features can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Personalized Content Delivery"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"Open-source Vontigo CMS with AI out of the box core features can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Predictive Analytics"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"Open-source Vontigo CMS with AI out of the box core features can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Improved Search"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"Open-source Vontigo CMS with AI out of the box core features can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Chatbots"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"Open-source Vontigo CMS with AI out of the box core features can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Social Media Management"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"Open-source Vontigo CMS with AI out of the box core features can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth."}]},{"type":"heading","attrs":{"textAlign":"left","level":2},"content":[{"type":"text","text":"Cost-Effective Solution"}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"Open-source Vontigo CMS with AI out of the box core features is a cost-effective solution for businesses of all sizes. It is an open-source platform, which means businesses do not have to pay for expensive licenses. Additionally, the AI features are built into the core of the CMS, eliminating the need for additional plugins or third-party software."}]},{"type":"paragraph","attrs":{"textAlign":"start"},"content":[{"type":"text","text":"In conclusion, open-source Vontigo CMS with AI out of the box core features is a game-changer for businesses and users around the world. It offers numerous benefits, including automated content creation, personalized content delivery, predictive analytics, improved search, chatbots, social media management, and a cost-effective solution. This CMS provides businesses with the tools they need to stay ahead of the competition and provide"}]}]}	\N	<p>Open-Source Vontigo CMS with AI Out of the Box Core Features will Bring a lot of Benefits for Businesses and Users Around the World</p><p style="text-align: start">Content Management Systems (CMS) have become essential for businesses of all sizes. They enable businesses to create, manage, and distribute content effectively. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. Open-source Vontigo CMS with AI out of the box core features is a game-changer. It will bring a lot of benefits for businesses and users around the world.</p><h2>Automated Content Creation</h2><p style="text-align: start">Open-source Vontigo CMS with AI out of the box core features can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.</p><h2>Personalized Content Delivery</h2><p style="text-align: start">Open-source Vontigo CMS with AI out of the box core features can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth.</p><h2>Predictive Analytics</h2><p style="text-align: start">Open-source Vontigo CMS with AI out of the box core features can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.</p><h2>Improved Search</h2><p style="text-align: start">Open-source Vontigo CMS with AI out of the box core features can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.</p><h2>Chatbots</h2><p style="text-align: start">Open-source Vontigo CMS with AI out of the box core features can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs.</p><h2>Social Media Management</h2><p style="text-align: start">Open-source Vontigo CMS with AI out of the box core features can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth.</p><h2>Cost-Effective Solution</h2><p style="text-align: start">Open-source Vontigo CMS with AI out of the box core features is a cost-effective solution for businesses of all sizes. It is an open-source platform, which means businesses do not have to pay for expensive licenses. Additionally, the AI features are built into the core of the CMS, eliminating the need for additional plugins or third-party software.</p><p style="text-align: start">In conclusion, open-source Vontigo CMS with AI out of the box core features is a game-changer for businesses and users around the world. It offers numerous benefits, including automated content creation, personalized content delivery, predictive analytics, improved search, chatbots, social media management, and a cost-effective solution. This CMS provides businesses with the tools they need to stay ahead of the competition and provide</p>	645cfb656c7c7c27389780aa	Open-Source Vontigo CMS with AI Out of the Box Core Features will Bring a lot of Benefits for Businesses and Users Around the World\\n\\nContent Management Systems (CMS) have become essential for businesses of all sizes. They enable businesses to create, manage, and distribute content effectively. However, the integration of Artificial Intelligence (AI) with CMS is set to revolutionize the digital landscape. Open-source Vontigo CMS with AI out of the box core features is a game-changer. It will bring a lot of benefits for businesses and users around the world.\\n\\nAutomated Content Creation\\n\\nOpen-source Vontigo CMS with AI out of the box core features can generate content ideas and even write content. This can save time and resources for content creators while ensuring that the content is relevant and engaging. This can also free up content creators to focus on higher-level tasks, such as strategy and planning.\\n\\nPersonalized Content Delivery\\n\\nOpen-source Vontigo CMS with AI out of the box core features can analyze user data to create personalized content experiences for individual users. This can improve engagement and increase user satisfaction, leading to higher retention rates and conversions. Personalized content delivery can also improve customer loyalty and drive revenue growth.\\n\\nPredictive Analytics\\n\\nOpen-source Vontigo CMS with AI out of the box core features can analyze data to predict future trends and behavior. This can help businesses make data-driven decisions and improve their content strategies. Predictive analytics can also help in identifying potential issues or opportunities, allowing businesses to make proactive changes.\\n\\nImproved Search\\n\\nOpen-source Vontigo CMS with AI out of the box core features can improve search capabilities by analyzing user search queries and providing relevant results. This can enhance the user experience by providing accurate and timely search results, reducing frustration and improving engagement.\\n\\nChatbots\\n\\nOpen-source Vontigo CMS with AI out of the box core features can provide a personalized and responsive support experience. This can help businesses provide support around the clock, improving customer satisfaction and reducing support costs.\\n\\nSocial Media Management\\n\\nOpen-source Vontigo CMS with AI out of the box core features can analyze social media data and provide insights into customer behavior and preferences. This can help businesses optimize their social media strategies, improve engagement, and drive revenue growth.\\n\\nCost-Effective Solution\\n\\nOpen-source Vontigo CMS with AI out of the box core features is a cost-effective solution for businesses of all sizes. It is an open-source platform, which means businesses do not have to pay for expensive licenses. Additionally, the AI features are built into the core of the CMS, eliminating the need for additional plugins or third-party software.\\n\\nIn conclusion, open-source Vontigo CMS with AI out of the box core features is a game-changer for businesses and users around the world. It offers numerous benefits, including automated content creation, personalized content delivery, predictive analytics, improved search, chatbots, social media management, and a cost-effective solution. This CMS provides businesses with the tools they need to stay ahead of the competition and provide	/content/en-us/images/size/_raw/2023/05/645cfb656c7c7c27389780a9_glowing-blue-molecular-structure-laboratory-research-generated-by-ai.jpg	f	post	published	en-us	public	all	2023-05-11 14:27:00	1	2023-05-11 14:27:00	1	2023-05-11 14:29:00	1	Open-source Vontigo CMS with AI out of the box core features is a game-changer. It will bring a lot of benefits for businesses and users around the world.	\N	\N	\N	\N	\N
643c326e002137342cf323a9	118e29cd-b606-4467-b668-1f8471869469	About Us	about-us	{"type":"doc","content":[{"type":"paragraph","attrs":{"textAlign":"left"},"content":[{"type":"text","text":"Hello world!"}]}]}	\N	<p>Hello world!</p>	643c326e002137342cf323a9	Hello world!	https://static.ghost.org/v4.0.0/images/feature-image.jpg	f	page	published	en-us	public	all	2023-04-16 17:37:50	1	2023-04-16 17:42:16	643c326e002137342cf323a9	2023-04-16 17:37:46	1	sadfasdfasdfas	\N	\N	\N	\N	\N
645cfbf96c7c7c27389780ab	8f410b8f-2e8f-4dd1-9918-4fb70eb0a143	Your new post is here...	draft-slug-645cfbf96c7c7c27389780ab	\N	\N	\N	645cfbf96c7c7c27389780ac	\N	\N	t	post	scheduled	en-us	public	all	2023-05-11 14:30:00	1	2023-05-11 14:30:00	1	2023-05-18 02:57:00	1	\N	\N	\N	\N	\N	\N
6465e3fe29127f0d309b6d8c	a15a7b43-bb03-412a-ac9d-3e59e9ed635c	Hello!	hello	\N	\N	\N	6465e3fe29127f0d309b6d8d	\N		f	post	draft	en-us	public	all	2023-05-18 08:38:00	1	2023-05-18 08:38:00	1	2023-05-18 10:08:00	1	\N	\N	\N	\N	\N	\N
\.


--
-- TOC entry 3071 (class 0 OID 24697)
-- Dependencies: 219
-- Data for Name: posts_authors; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.posts_authors (id, post_id, author_id, sort_order) FROM stdin;
643c326e002137342cf323aa	643c326e002137342cf323a9	1	0
644e4d4e97ea9a7e217d2469	643c3269002137342cf323a7	1	0
645cf3e8c64ba87568acb096	645cf2a06c7c7c2738978099	1	0
645cf6b59c446481ba914917	645cf6336c7c7c273897809d	1	0
645cf77e9c446481ba914919	645cf6c76c7c7c273897809f	1	0
645cf8209c446481ba91491b	645cf7e86c7c7c27389780a1	1	0
645cfa09463678c1113997f7	645cf95c6c7c7c27389780a5	1	0
\.


--
-- TOC entry 3069 (class 0 OID 24648)
-- Dependencies: 217
-- Data for Name: posts_meta; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.posts_meta (id, post_id, og_image, og_title, og_description, twitter_image, twitter_title, twitter_description, meta_title, meta_description, email_subject, frontmatter, feature_image_alt, feature_image_caption, email_only) FROM stdin;
\.


--
-- TOC entry 3094 (class 0 OID 24941)
-- Dependencies: 242
-- Data for Name: posts_products; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.posts_products (id, post_id, product_id, sort_order) FROM stdin;
\.


--
-- TOC entry 3079 (class 0 OID 24792)
-- Dependencies: 227
-- Data for Name: posts_tags; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.posts_tags (id, post_id, tag_id, sort_order) FROM stdin;
644e4ff35de44f549d24230f	643c3269002137342cf323a7	643c3268002137342cf32338	0
645cf3e4c64ba87568acb095	645cf2a06c7c7c2738978099	643c3268002137342cf32338	0
645cf6b29c446481ba914916	645cf6336c7c7c273897809d	643c3268002137342cf32338	0
645cf77c9c446481ba914918	645cf6c76c7c7c273897809f	64415203f228f05bd1c8e111	0
645cf81d9c446481ba91491a	645cf7e86c7c7c27389780a1	643c3268002137342cf32338	0
645cf91b9c446481ba91491c	645cf86e6c7c7c27389780a3	643c3268002137342cf32338	0
645cf9f2463678c1113997f6	645cf95c6c7c7c27389780a5	643c3268002137342cf32338	0
\.


--
-- TOC entry 3089 (class 0 OID 24880)
-- Dependencies: 237
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.products (id, name, slug, active, welcome_page_url, visibility, trial_days, description, type, currency, monthly_price, yearly_price, created_at, updated_at, monthly_price_id, yearly_price_id) FROM stdin;
\.


--
-- TOC entry 3092 (class 0 OID 24909)
-- Dependencies: 240
-- Data for Name: products_benefits; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.products_benefits (id, product_id, benefit_id, sort_order) FROM stdin;
\.


--
-- TOC entry 3124 (class 0 OID 25539)
-- Dependencies: 272
-- Data for Name: redirects; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.redirects (id, "from", "to", post_id, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3072 (class 0 OID 24713)
-- Dependencies: 220
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.roles (id, name, description, created_at, created_by, updated_at, updated_by) FROM stdin;
643c3268002137342cf3232a	Administrator	Administrators	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3232b	Editor	Editors	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3232c	Author	Authors	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3232d	Contributor	Contributors	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3232e	Owner	Blog Owner	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf3232f	Admin Integration	External Apps	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32330	Ghost Explore Integration	Internal Integration for the Ghost Explore directory	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32331	Self-Serve Migration Integration	Internal Integration for the Self-Serve migration tool	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32332	DB Backup Integration	Internal DB Backup Client	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
643c3268002137342cf32333	Scheduler Integration	Internal Scheduler Client	2023-04-16 17:37:44	1	2023-04-16 17:37:44	1
\.


--
-- TOC entry 3074 (class 0 OID 24740)
-- Dependencies: 222
-- Data for Name: roles_users; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.roles_users (id, role_id, user_id) FROM stdin;
643c3268002137342cf32334	643c3268002137342cf3232e	1
\.


--
-- TOC entry 3082 (class 0 OID 24822)
-- Dependencies: 230
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.sessions (id, session_id, user_id, session_data, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3077 (class 0 OID 24755)
-- Dependencies: 225
-- Data for Name: settings; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.settings (id, "group", key, value, type, flags, created_at, created_by, updated_at, updated_by) FROM stdin;
643c326f002137342cf324de	core	last_mentions_report_email_timestamp	\N	number	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324df	core	db_hash	f498cb9f-b0f5-48b9-ad1b-4731d7ec5853	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324e0	core	routes_hash	3d180d52c663d173a6be791ef411ed01	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:38:05	1
643c326f002137342cf324e1	core	next_update_check	1682088301	number	\N	2023-04-16 17:37:51	1	2023-04-20 14:45:01	1
643c326f002137342cf324e2	core	notifications	[{"dismissible":true,"location":"bottom","status":"alert","id":"643c337a002137342cf32548","createdAtVersion":"5.44.0","type":"warn","message":"Ghost is currently unable to send email. See https://ghost.org/docs/concepts/config/#mail for instructions.","seen":false,"addedAt":"2023-04-16T17:42:18.515Z"}]	array	\N	2023-04-16 17:37:51	1	2023-04-16 17:42:18	1
643c326f002137342cf324e3	core	version_notifications	[]	array	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324e4	core	admin_session_secret	6d9eec27160e049a245ca071f29073b71cdeaf5873585c513fb040f1b93a28b6	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324e5	core	theme_session_secret	0a12a610e02e7dab2c927ae7cdd13a302b8989e5d2a632cf37d80b972f2c120f	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324e6	core	vontigo_public_key	-----BEGIN RSA PUBLIC KEY-----\\nMIGJAoGBALbjvGV/wJzHg8Y5pGD8Z+F2fFYslunEbV33DKvSno1+H6y5uTA04sF+9ImEpq3U\\nzgDEvSOprmCzWJErvFe+nOCC6SfIIHeSTDEvJ7wiN5pSrVlTFLyYY3X5E5VOYTvUub9giXrb\\nv7c1qMXlDNPYz3yMac4dsVhbtUKlZLpkeSFFAgMBAAE=\\n-----END RSA PUBLIC KEY-----\\n	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324e7	core	vontigo_private_key	-----BEGIN RSA PRIVATE KEY-----\\nMIICXQIBAAKBgQC247xlf8Ccx4PGOaRg/GfhdnxWLJbpxG1d9wyr0p6Nfh+subkwNOLBfvSJ\\nhKat1M4AxL0jqa5gs1iRK7xXvpzgguknyCB3kkwxLye8IjeaUq1ZUxS8mGN1+ROVTmE71Lm/\\nYIl627+3NajF5QzT2M98jGnOHbFYW7VCpWS6ZHkhRQIDAQABAoGBAILSbm3wLzg2YyVFEDcr\\n9abKWXBO3viCwHSphk/WDgJKSKAGDdjUy6r7hDJmR9AqW90i3eSHuKuFPoJBVa0yNQYRty8N\\nYG+J6stibg9E6DiwMH8PHSxxgyVfD9xW6TPISvTK12jOu18X+kEPvWDntSaxlbo5BtghnKoJ\\nJLmLeqVhAkEA5KHqfcvcboCnbFYwJ9fjhSl4J+PDxZIDYcDbQtsw39Ybc1ViY57wWlFK7OyC\\nBUcgRaCqjMxAfElGUcQeq6JM+QJBAMzIGcwPyH2K6DjMU+2IX1hCJrWjr3P4eLvDIvGuCM7K\\nSPoYcvoVs/45Tap5zEIrZd4C3ecug4U0NdSlqrBsRa0CQQCprbkXzzozEGwwrO5kQ4bphtNT\\n12etsyWrYLPZNE9bb81DlTTF9mkuvnI6z3PXcufyhMDOaa/aDY+Qk1qnynYRAkATlEYzJocq\\nya8uTwrvOQy0qY5962qJEgapHR0oMlWRP/H+R3wmwRB2jBAK7p5C7VdOBMQmqGHWyIklDbnm\\nKFP5AkAGCJpz9TeCtuyzF/KgkmVjQAFdzA0oPCBF2e9yMC4t87J5Tiouy9idxwQxczNvo2a4\\nWcCZ2trtS8GVQvVVRWmC\\n-----END RSA PRIVATE KEY-----\\n	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32519	portal	portal_products	[]	array	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3251a	portal	portal_button_style	icon-and-text	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3251b	portal	portal_button_icon	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3251c	portal	portal_button_signup_text	Subscribe	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3251d	portal	portal_signup_terms_html	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3251e	portal	portal_signup_checkbox_required	false	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3251f	email	mailgun_domain	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32520	email	mailgun_api_key	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32521	email	mailgun_base_url	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32522	email	email_track_opens	true	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32523	email	email_track_clicks	true	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32524	email	email_verification_required	false	boolean	RO	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32525	amp	amp	false	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32526	amp	amp_gtag_id	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32527	firstpromoter	firstpromoter	false	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32528	firstpromoter	firstpromoter_id	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32529	labs	labs	{}	object	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3252a	slack	slack_url		string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3252b	slack	slack_username	Ghost	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3252c	unsplash	unsplash	true	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3252d	views	shared_views	[]	array	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3252e	editor	editor_default_email_recipients	visibility	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3252f	editor	editor_default_email_recipients_filter	all	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32530	comments	comments_enabled	off	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32531	analytics	outbound_link_tagging	true	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32532	brainiacminds	aim_url	https://vontigo.services.brainiacminds.com/beta	string	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf32533	brainiacminds	aim_key	YOUR_OPENAI_KEY	string	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf32534	brainiacminds	aim_mainpoints	technology	string	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf32535	brainiacminds	aim_topics	artificial intelligence, ai	string	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf32536	brainiacminds	aim_custom_prompt	Write a high-quality article on "{{title}}" that is engaging and informative for readers. 	text	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf32537	brainiacminds	aim_using_custom_prompt	false	boolean	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf32538	brainiacminds	aim_temperature	0.1	number	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf32539	brainiacminds	aim_max_tokens	1000	number	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf32540	brainiacminds	aim_article_max_words	250	number	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf32541	google	iam_service_account_client_email	XXX.iam.gserviceaccount.com	string	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf32542	google	iam_service_account_private_key	-----BEGIN PRIVATE...	string	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf324e8	core	members_public_key	-----BEGIN RSA PUBLIC KEY-----\\nMIGJAoGBAMIPiSiRmxt3s8EAbttaaqSk9PDuHG3TODDLcrguqwdw/1vvl8UhmM0ElepOBT6X\\nI6CAiGm+PCLrIF9/tuBO+MFRA3IYr16UjjyMGcCiEgcWteefTKGfwj4WNk0vGbaQ5H9Nmuuc\\nG73HKZSFrZjkc6N6vTNAG2V8F3g4JYcVVsfrAgMBAAE=\\n-----END RSA PUBLIC KEY-----\\n	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324e9	core	members_private_key	-----BEGIN RSA PRIVATE KEY-----\\nMIICXQIBAAKBgQDCD4kokZsbd7PBAG7bWmqkpPTw7hxt0zgwy3K4LqsHcP9b75fFIZjNBJXq\\nTgU+lyOggIhpvjwi6yBff7bgTvjBUQNyGK9elI48jBnAohIHFrXnn0yhn8I+FjZNLxm2kOR/\\nTZrrnBu9xymUha2Y5HOjer0zQBtlfBd4OCWHFVbH6wIDAQABAoGBAIlOOLutmlNq9JJgXg9x\\n//aSiIRX1WGXizBrIrZSvsw7FVLVSUs/pD+bOP9ZSLiqc5jCmMJIyX/jYTpwwNIgzjuuTKjH\\nXHYwC6DaO5lnQXkkjEiTKnzaKtMveWvpYSCq+pIjhJcXCRvfb2y+iMPk8GgK7Qp1Nb2WkaMm\\nBxIK8HlxAkEA4MGGtzZymF5Pqx/Cgdq+erR+4mtvncgm+d7mr3keO1DGiPtui7TkxOP6Syi3\\nlQtadozhnc+xoHuXv4gjSLwubwJBAN0JpTjgYmGxoFP498LarOOoYqgrtxPmNTg1BSmHsij5\\nHFztVvNRKCye0Vk9U/qjoOZ7Fcl4ZQeuJvwbt3Yn/EUCQFnUv9Vmi7LerxUEYqeoGE3O6o/w\\nxPHZV8qzDpy/2hd3F4MUi4CHUpBnVljH82g823Faqap7otEz1NkWvpOJsz0CQANEpj2+C5ZY\\nMv+q2bb21sGS9sp3wwA3UigfmJDxoa+7ZzD0jWmRlJ98RaolHv3At5tQzJSrBAtmBsuJeV/0\\n3WUCQQDeG8RRhe8qsnAyOIC3hL7na5HbVE+fIsVLgE32Sdl5GrnOQrgK1qjBM6aSkWzm40ax\\n8YBa6oIC7TSALkYbADWv\\n-----END RSA PRIVATE KEY-----\\n	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324ea	core	members_email_auth_secret	22503539446411f2853eec5720d8e92a97972c41214dc1772f54b3fadb92b6b6274446cb51f18ab13bab3d5efce733ec8a177acc1095ec83c2e3813678a5d7d9	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324eb	core	members_stripe_webhook_id	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324ec	core	members_stripe_webhook_secret	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324ed	site	title	Vontigo	string	PUBLIC	2023-04-16 17:37:51	1	2023-04-20 14:46:30	1
643c326f002137342cf324ee	site	description	Empower Your Content with AI: The Future-Ready Publishing Platform	string	PUBLIC	2023-04-16 17:37:51	1	2023-04-20 14:46:30	1
643c326f002137342cf324ef	site	logo		string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324f0	site	cover_image	/content/en-us/images/size/_raw/2023/04/643c326f002137342cf324f0_main__share.jpg	string	\N	2023-04-16 17:37:51	1	2023-04-20 14:51:10	1
643c326f002137342cf324f1	site	icon		string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324f3	site	locale	en-us	string	\N	2023-04-16 17:37:51	1	2023-04-20 14:46:30	1
643c326f002137342cf324f4	site	timezone	Etc/UTC	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324f5	site	codeinjection_head		string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324f6	site	codeinjection_foot		string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324f7	site	facebook	vontigo	string	\N	2023-04-16 17:37:51	1	2023-04-20 14:46:30	1
643c326f002137342cf324f8	site	twitter	@vontigo	string	\N	2023-04-16 17:37:51	1	2023-04-20 14:46:30	1
643c326f002137342cf324f9	site	navigation	[{"label":"Home","url":"/"},{"label":"About us","url":"/about-us/"},{"label":"Collection","url":"/tag/getting-started/"},{"label":"Author","url":"/author/vontigo/"}]	array	\N	2023-04-16 17:37:51	1	2023-04-20 15:00:01	1
643c326f002137342cf324f2	site	accent_color	#000000	string	PUBLIC	2023-04-16 17:37:51	1	2023-04-20 14:51:10	1
643c326f002137342cf32543	google	analytics_measurement_id	G-1VTZ4YXXXX	string	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf32544	google	analytics_view_id	189586732	string	\N	2023-05-08 17:37:51	1	2023-05-08 17:37:51	1
643c326f002137342cf324fa	site	secondary_navigation	[   {     "label": "Data & privacy",     "url": "/privacy/"   },   {     "label": "Contact",     "url": "/contact/"   },   {     "label": "Login",     "url": "/vontigo/"   },   {     "label": "Contribute →",     "url": "/contribute/"   } ]	array	\N	2023-04-16 17:37:51	1	2023-04-20 14:53:21	1
643c326f002137342cf324fb	site	meta_title	Vontigo	string	\N	2023-04-16 17:37:51	1	2023-04-20 14:46:30	1
643c326f002137342cf324fc	site	meta_description	Empower Your Content with AI: The Future-Ready Publishing Platform	string	\N	2023-04-16 17:37:51	1	2023-04-20 14:46:30	1
643c326f002137342cf324fd	site	og_image	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf324fe	site	og_title	Vontigo	string	\N	2023-04-16 17:37:51	1	2023-04-20 14:46:30	1
643c326f002137342cf324ff	site	og_description	Empower Your Content with AI: The Future-Ready Publishing Platform	string	\N	2023-04-16 17:37:51	1	2023-04-20 14:46:30	1
643c326f002137342cf32500	site	twitter_image	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32501	site	twitter_title	Vontigo	string	\N	2023-04-16 17:37:51	1	2023-04-20 14:46:30	1
643c326f002137342cf32502	site	twitter_description	Empower Your Content with AI: The Future-Ready Publishing Platform	string	\N	2023-04-16 17:37:51	1	2023-04-20 14:46:30	1
643c326f002137342cf32503	theme	active_theme	casper	string	RO	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32504	private	is_private	false	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32505	private	password		string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32506	private	public_hash	ff61c32f8f91bc3644d5b7d04ecedf	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32507	members	default_content_visibility	public	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32508	members	default_content_visibility_tiers	[]	array	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32509	members	members_signup_access	invite	string	\N	2023-04-16 17:37:51	1	2023-04-18 05:15:02	1
643c326f002137342cf3250a	members	members_support_address	noreply	string	PUBLIC,RO	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3250b	members	stripe_secret_key	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3250c	members	stripe_publishable_key	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3250d	members	stripe_plans	[]	array	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3250e	members	stripe_connect_publishable_key	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf3250f	members	stripe_connect_secret_key	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32510	members	stripe_connect_livemode	\N	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32511	members	stripe_connect_display_name	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32512	members	stripe_connect_account_id	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32513	members	members_monthly_price_id	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32514	members	members_yearly_price_id	\N	string	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32515	members	members_track_sources	true	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32516	portal	portal_name	true	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32517	portal	portal_button	true	boolean	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
643c326f002137342cf32518	portal	portal_plans	["free"]	array	\N	2023-04-16 17:37:51	1	2023-04-16 17:37:51	1
\.


--
-- TOC entry 3113 (class 0 OID 25312)
-- Dependencies: 261
-- Data for Name: snippets; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.snippets (id, name, mobiledoc, lexical, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- TOC entry 3106 (class 0 OID 25140)
-- Dependencies: 254
-- Data for Name: subscriptions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.subscriptions (id, type, status, member_id, tier_id, cadence, currency, amount, payment_provider, payment_subscription_url, payment_user_url, offer_id, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- TOC entry 3127 (class 0 OID 25582)
-- Dependencies: 275
-- Data for Name: suppressions; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.suppressions (id, email, email_id, reason, created_at) FROM stdin;
\.


--
-- TOC entry 3078 (class 0 OID 24774)
-- Dependencies: 226
-- Data for Name: tags; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.tags (id, name, slug, description, feature_image, parent_id, visibility, og_image, og_title, og_description, twitter_image, twitter_title, twitter_description, meta_title, meta_description, codeinjection_head, codeinjection_foot, canonical_url, accent_color, created_at, created_by, updated_at, updated_by) FROM stdin;
643c3268002137342cf32338	News	news	Tag Description	/content/en-us/images/size/_raw/2023/04/643c3268002137342cf32338_PXL_20220326_123931525.PORTRAIT-01.jpeg	\N	public	\N		\N	\N	\N	\N	\N	\N	\N	\N	\N	#014619	2023-04-16 17:37:44	1	2023-04-26 17:37:44	1
64415203f228f05bd1c8e111	Getting Started	getting-started	\N	/content/en-us/images/size/_raw/2023/04/64415203f228f05bd1c8e111_main__share.jpg	\N	public	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	#da1616	2023-04-20 14:53:55	1	2023-04-26 14:53:55	1
644e4fa55de44f549d24230b	Tutorial	tutorial	\N	/content/en-us/images/size/_raw/2023/05/644e4fa55de44f549d24230b_0000005_electronics_450.jpeg	\N	public	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	\N	2023-04-30 11:23:00	1	\N	\N
\.


--
-- TOC entry 3112 (class 0 OID 25304)
-- Dependencies: 260
-- Data for Name: tokens; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.tokens (id, token, data, created_at, updated_at, first_used_at, used_count, created_by) FROM stdin;
\.


--
-- TOC entry 3070 (class 0 OID 24672)
-- Dependencies: 218
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.users (id, name, slug, password, email, profile_image, cover_image, bio, website, location, facebook, twitter, accessibility, status, locale, visibility, meta_title, meta_description, tour, last_seen, comment_notifications, free_member_signup_notification, paid_subscription_started_notification, paid_subscription_canceled_notification, mention_notifications, milestone_notifications, created_at, created_by, updated_at, updated_by) FROM stdin;
1	Vontigo	vontigo	P@ssw0rd	contact@vontigo.org	/content/en-us/images/size/_raw/2023/05/1_Singuyen_2d_solid_logo_with_V_character_3b6024d5-96a2-4d19-9e88-ad28c9522cbf.png	\N	Love to smile! : V	https://vontigo.org	Ho Chi Minh City, Vietnam		\N	\N	active	\N	public	\N	\N	Hello!	2023-04-20 14:45:00	t	t	t	f	t	t	2023-04-16 17:37:44	1	2023-04-20 14:45:00	1
\.


--
-- TOC entry 3084 (class 0 OID 24837)
-- Dependencies: 232
-- Data for Name: webhooks; Type: TABLE DATA; Schema: public; Owner: default
--

COPY public.webhooks (id, event, target_url, name, secret, api_version, integration_id, last_triggered_at, last_triggered_status, last_triggered_error, created_at, created_by, updated_at, updated_by) FROM stdin;
\.


--
-- TOC entry 3140 (class 0 OID 0)
-- Dependencies: 279
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: default
--

SELECT pg_catalog.setval('public.migrations_id_seq', 1, false);


--
-- TOC entry 2817 (class 2606 OID 25303)
-- Name: actions actions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (id);


--
-- TOC entry 2765 (class 2606 OID 24854)
-- Name: api_keys api_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.api_keys
    ADD CONSTRAINT api_keys_pkey PRIMARY KEY (id);


--
-- TOC entry 2777 (class 2606 OID 24908)
-- Name: benefits benefits_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.benefits
    ADD CONSTRAINT benefits_pkey PRIMARY KEY (id);


--
-- TOC entry 2757 (class 2606 OID 24820)
-- Name: brute brute_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.brute
    ADD CONSTRAINT brute_pkey PRIMARY KEY (key);


--
-- TOC entry 2837 (class 2606 OID 25506)
-- Name: comment_likes comment_likes_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.comment_likes
    ADD CONSTRAINT comment_likes_pkey PRIMARY KEY (id);


--
-- TOC entry 2839 (class 2606 OID 25521)
-- Name: comment_reports comment_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.comment_reports
    ADD CONSTRAINT comment_reports_pkey PRIMARY KEY (id);


--
-- TOC entry 2835 (class 2606 OID 25486)
-- Name: comments comments_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- TOC entry 2823 (class 2606 OID 25325)
-- Name: custom_theme_settings custom_theme_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.custom_theme_settings
    ADD CONSTRAINT custom_theme_settings_pkey PRIMARY KEY (id);


--
-- TOC entry 2827 (class 2606 OID 25423)
-- Name: email_batches email_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.email_batches
    ADD CONSTRAINT email_batches_pkey PRIMARY KEY (id);


--
-- TOC entry 2831 (class 2606 OID 25453)
-- Name: email_recipient_failures email_recipient_failures_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.email_recipient_failures
    ADD CONSTRAINT email_recipient_failures_pkey PRIMARY KEY (id);


--
-- TOC entry 2829 (class 2606 OID 25435)
-- Name: email_recipients email_recipients_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.email_recipients
    ADD CONSTRAINT email_recipients_pkey PRIMARY KEY (id);


--
-- TOC entry 2851 (class 2606 OID 25596)
-- Name: email_spam_complaint_events email_spam_complaint_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.email_spam_complaint_events
    ADD CONSTRAINT email_spam_complaint_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2825 (class 2606 OID 25410)
-- Name: emails emails_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);


--
-- TOC entry 2761 (class 2606 OID 24836)
-- Name: integrations integrations_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.integrations
    ADD CONSTRAINT integrations_pkey PRIMARY KEY (id);


--
-- TOC entry 2755 (class 2606 OID 24815)
-- Name: invites invites_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.invites
    ADD CONSTRAINT invites_pkey PRIMARY KEY (id);


--
-- TOC entry 2841 (class 2606 OID 25537)
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 2801 (class 2606 OID 25050)
-- Name: labels labels_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.labels
    ADD CONSTRAINT labels_pkey PRIMARY KEY (id);


--
-- TOC entry 2787 (class 2606 OID 24973)
-- Name: members_cancel_events members_cancel_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_cancel_events
    ADD CONSTRAINT members_cancel_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2845 (class 2606 OID 25555)
-- Name: members_click_events members_click_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_click_events
    ADD CONSTRAINT members_click_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2785 (class 2606 OID 24963)
-- Name: members_created_events members_created_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_created_events
    ADD CONSTRAINT members_created_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2793 (class 2606 OID 25003)
-- Name: members_email_change_events members_email_change_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_email_change_events
    ADD CONSTRAINT members_email_change_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2847 (class 2606 OID 25571)
-- Name: members_feedback members_feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_feedback
    ADD CONSTRAINT members_feedback_pkey PRIMARY KEY (id);


--
-- TOC entry 2803 (class 2606 OID 25117)
-- Name: members_labels members_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_labels
    ADD CONSTRAINT members_labels_pkey PRIMARY KEY (id);


--
-- TOC entry 2791 (class 2606 OID 24993)
-- Name: members_login_events members_login_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_login_events
    ADD CONSTRAINT members_login_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2833 (class 2606 OID 25468)
-- Name: members_newsletters members_newsletters_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_newsletters
    ADD CONSTRAINT members_newsletters_pkey PRIMARY KEY (id);


--
-- TOC entry 2799 (class 2606 OID 25040)
-- Name: members_paid_subscription_events members_paid_subscription_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_paid_subscription_events
    ADD CONSTRAINT members_paid_subscription_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2789 (class 2606 OID 24983)
-- Name: members_payment_events members_payment_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_payment_events
    ADD CONSTRAINT members_payment_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2771 (class 2606 OID 24879)
-- Name: members members_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members
    ADD CONSTRAINT members_pkey PRIMARY KEY (id);


--
-- TOC entry 2797 (class 2606 OID 25023)
-- Name: members_product_events members_product_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_product_events
    ADD CONSTRAINT members_product_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2781 (class 2606 OID 24930)
-- Name: members_products members_products_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_products
    ADD CONSTRAINT members_products_pkey PRIMARY KEY (id);


--
-- TOC entry 2795 (class 2606 OID 25013)
-- Name: members_status_events members_status_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_status_events
    ADD CONSTRAINT members_status_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2805 (class 2606 OID 25134)
-- Name: members_stripe_customers members_stripe_customers_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_stripe_customers
    ADD CONSTRAINT members_stripe_customers_pkey PRIMARY KEY (id);


--
-- TOC entry 2809 (class 2606 OID 25223)
-- Name: members_stripe_customers_subscriptions members_stripe_customers_subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_stripe_customers_subscriptions
    ADD CONSTRAINT members_stripe_customers_subscriptions_pkey PRIMARY KEY (id);


--
-- TOC entry 2815 (class 2606 OID 25286)
-- Name: members_subscribe_events members_subscribe_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_subscribe_events
    ADD CONSTRAINT members_subscribe_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2811 (class 2606 OID 25250)
-- Name: members_subscription_created_events members_subscription_created_events_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_subscription_created_events
    ADD CONSTRAINT members_subscription_created_events_pkey PRIMARY KEY (id);


--
-- TOC entry 2853 (class 2606 OID 25615)
-- Name: mentions mentions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.mentions
    ADD CONSTRAINT mentions_pkey PRIMARY KEY (id);


--
-- TOC entry 2727 (class 2606 OID 24581)
-- Name: migrations_lock migrations_lock_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.migrations_lock
    ADD CONSTRAINT migrations_lock_pkey PRIMARY KEY (lock_key);


--
-- TOC entry 2857 (class 2606 OID 25627)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 2855 (class 2606 OID 25620)
-- Name: milestones milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.milestones
    ADD CONSTRAINT milestones_pkey PRIMARY KEY (id);


--
-- TOC entry 2767 (class 2606 OID 24861)
-- Name: mobiledoc_revisions mobiledoc_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.mobiledoc_revisions
    ADD CONSTRAINT mobiledoc_revisions_pkey PRIMARY KEY (id);


--
-- TOC entry 2729 (class 2606 OID 24607)
-- Name: newsletters newsletters_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.newsletters
    ADD CONSTRAINT newsletters_pkey PRIMARY KEY (id);


--
-- TOC entry 2813 (class 2606 OID 25265)
-- Name: offer_redemptions offer_redemptions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.offer_redemptions
    ADD CONSTRAINT offer_redemptions_pkey PRIMARY KEY (id);


--
-- TOC entry 2775 (class 2606 OID 24898)
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);


--
-- TOC entry 2745 (class 2606 OID 24749)
-- Name: permissions permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.permissions
    ADD CONSTRAINT permissions_pkey PRIMARY KEY (id);


--
-- TOC entry 2741 (class 2606 OID 24724)
-- Name: permissions_roles permissions_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.permissions_roles
    ADD CONSTRAINT permissions_roles_pkey PRIMARY KEY (id);


--
-- TOC entry 2747 (class 2606 OID 24754)
-- Name: permissions_users permissions_users_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.permissions_users
    ADD CONSTRAINT permissions_users_pkey PRIMARY KEY (id);


--
-- TOC entry 2769 (class 2606 OID 24868)
-- Name: post_revisions post_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.post_revisions
    ADD CONSTRAINT post_revisions_pkey PRIMARY KEY (id);


--
-- TOC entry 2737 (class 2606 OID 24702)
-- Name: posts_authors posts_authors_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts_authors
    ADD CONSTRAINT posts_authors_pkey PRIMARY KEY (id);


--
-- TOC entry 2733 (class 2606 OID 24655)
-- Name: posts_meta posts_meta_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts_meta
    ADD CONSTRAINT posts_meta_pkey PRIMARY KEY (id);


--
-- TOC entry 2731 (class 2606 OID 24618)
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- TOC entry 2783 (class 2606 OID 24946)
-- Name: posts_products posts_products_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts_products
    ADD CONSTRAINT posts_products_pkey PRIMARY KEY (id);


--
-- TOC entry 2753 (class 2606 OID 24797)
-- Name: posts_tags posts_tags_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts_tags
    ADD CONSTRAINT posts_tags_pkey PRIMARY KEY (id);


--
-- TOC entry 2779 (class 2606 OID 24914)
-- Name: products_benefits products_benefits_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.products_benefits
    ADD CONSTRAINT products_benefits_pkey PRIMARY KEY (id);


--
-- TOC entry 2773 (class 2606 OID 24890)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 2843 (class 2606 OID 25545)
-- Name: redirects redirects_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.redirects
    ADD CONSTRAINT redirects_pkey PRIMARY KEY (id);


--
-- TOC entry 2739 (class 2606 OID 24719)
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- TOC entry 2743 (class 2606 OID 24744)
-- Name: roles_users roles_users_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.roles_users
    ADD CONSTRAINT roles_users_pkey PRIMARY KEY (id);


--
-- TOC entry 2759 (class 2606 OID 24828)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 2749 (class 2606 OID 24762)
-- Name: settings settings_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.settings
    ADD CONSTRAINT settings_pkey PRIMARY KEY (id);


--
-- TOC entry 2821 (class 2606 OID 25318)
-- Name: snippets snippets_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.snippets
    ADD CONSTRAINT snippets_pkey PRIMARY KEY (id);


--
-- TOC entry 2807 (class 2606 OID 25146)
-- Name: subscriptions subscriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_pkey PRIMARY KEY (id);


--
-- TOC entry 2849 (class 2606 OID 25586)
-- Name: suppressions suppressions_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.suppressions
    ADD CONSTRAINT suppressions_pkey PRIMARY KEY (id);


--
-- TOC entry 2751 (class 2606 OID 24781)
-- Name: tags tags_pk; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_pk PRIMARY KEY (id);


--
-- TOC entry 2819 (class 2606 OID 25311)
-- Name: tokens tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.tokens
    ADD CONSTRAINT tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 2735 (class 2606 OID 24686)
-- Name: users users_pk; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pk PRIMARY KEY (id);


--
-- TOC entry 2763 (class 2606 OID 24844)
-- Name: webhooks webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.webhooks
    ADD CONSTRAINT webhooks_pkey PRIMARY KEY (id);


--
-- TOC entry 2912 (class 2606 OID 25507)
-- Name: comment_likes comment_likes_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.comment_likes
    ADD CONSTRAINT comment_likes_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comments(id) ON DELETE CASCADE;


--
-- TOC entry 2913 (class 2606 OID 25512)
-- Name: comment_likes comment_likes_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.comment_likes
    ADD CONSTRAINT comment_likes_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2914 (class 2606 OID 25522)
-- Name: comment_reports comment_reports_comment_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.comment_reports
    ADD CONSTRAINT comment_reports_comment_id_fkey FOREIGN KEY (comment_id) REFERENCES public.comments(id) ON DELETE CASCADE;


--
-- TOC entry 2915 (class 2606 OID 25527)
-- Name: comment_reports comment_reports_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.comment_reports
    ADD CONSTRAINT comment_reports_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE SET NULL;


--
-- TOC entry 2909 (class 2606 OID 25492)
-- Name: comments comments_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE SET NULL;


--
-- TOC entry 2910 (class 2606 OID 25497)
-- Name: comments comments_parent_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_parent_id_fkey FOREIGN KEY (parent_id) REFERENCES public.comments(id) ON DELETE CASCADE;


--
-- TOC entry 2911 (class 2606 OID 25487)
-- Name: comments comments_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.comments
    ADD CONSTRAINT comments_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 2902 (class 2606 OID 25424)
-- Name: email_batches email_batches_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.email_batches
    ADD CONSTRAINT email_batches_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.emails(id);


--
-- TOC entry 2905 (class 2606 OID 25454)
-- Name: email_recipient_failures email_recipient_failures_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.email_recipient_failures
    ADD CONSTRAINT email_recipient_failures_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.emails(id);


--
-- TOC entry 2906 (class 2606 OID 25459)
-- Name: email_recipient_failures email_recipient_failures_email_recipient_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.email_recipient_failures
    ADD CONSTRAINT email_recipient_failures_email_recipient_id_fkey FOREIGN KEY (email_recipient_id) REFERENCES public.email_recipients(id);


--
-- TOC entry 2903 (class 2606 OID 25441)
-- Name: email_recipients email_recipients_batch_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.email_recipients
    ADD CONSTRAINT email_recipients_batch_id_fkey FOREIGN KEY (batch_id) REFERENCES public.email_batches(id);


--
-- TOC entry 2904 (class 2606 OID 25436)
-- Name: email_recipients email_recipients_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.email_recipients
    ADD CONSTRAINT email_recipients_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.emails(id);


--
-- TOC entry 2922 (class 2606 OID 25602)
-- Name: email_spam_complaint_events email_spam_complaint_events_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.email_spam_complaint_events
    ADD CONSTRAINT email_spam_complaint_events_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.emails(id);


--
-- TOC entry 2923 (class 2606 OID 25597)
-- Name: email_spam_complaint_events email_spam_complaint_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.email_spam_complaint_events
    ADD CONSTRAINT email_spam_complaint_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2901 (class 2606 OID 25411)
-- Name: emails emails_newsletter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.emails
    ADD CONSTRAINT emails_newsletter_id_fkey FOREIGN KEY (newsletter_id) REFERENCES public.newsletters(id);


--
-- TOC entry 2877 (class 2606 OID 24974)
-- Name: members_cancel_events members_cancel_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_cancel_events
    ADD CONSTRAINT members_cancel_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2917 (class 2606 OID 25556)
-- Name: members_click_events members_click_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_click_events
    ADD CONSTRAINT members_click_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2918 (class 2606 OID 25561)
-- Name: members_click_events members_click_events_redirect_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_click_events
    ADD CONSTRAINT members_click_events_redirect_id_fkey FOREIGN KEY (redirect_id) REFERENCES public.redirects(id) ON DELETE CASCADE;


--
-- TOC entry 2876 (class 2606 OID 24964)
-- Name: members_created_events members_created_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_created_events
    ADD CONSTRAINT members_created_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2880 (class 2606 OID 25004)
-- Name: members_email_change_events members_email_change_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_email_change_events
    ADD CONSTRAINT members_email_change_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2919 (class 2606 OID 25572)
-- Name: members_feedback members_feedback_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_feedback
    ADD CONSTRAINT members_feedback_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2920 (class 2606 OID 25577)
-- Name: members_feedback members_feedback_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_feedback
    ADD CONSTRAINT members_feedback_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 2885 (class 2606 OID 25123)
-- Name: members_labels members_labels_label_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_labels
    ADD CONSTRAINT members_labels_label_id_fkey FOREIGN KEY (label_id) REFERENCES public.labels(id) ON DELETE CASCADE;


--
-- TOC entry 2886 (class 2606 OID 25118)
-- Name: members_labels members_labels_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_labels
    ADD CONSTRAINT members_labels_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2879 (class 2606 OID 24994)
-- Name: members_login_events members_login_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_login_events
    ADD CONSTRAINT members_login_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2907 (class 2606 OID 25469)
-- Name: members_newsletters members_newsletters_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_newsletters
    ADD CONSTRAINT members_newsletters_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2908 (class 2606 OID 25474)
-- Name: members_newsletters members_newsletters_newsletter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_newsletters
    ADD CONSTRAINT members_newsletters_newsletter_id_fkey FOREIGN KEY (newsletter_id) REFERENCES public.newsletters(id) ON DELETE CASCADE;


--
-- TOC entry 2884 (class 2606 OID 25041)
-- Name: members_paid_subscription_events members_paid_subscription_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_paid_subscription_events
    ADD CONSTRAINT members_paid_subscription_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2878 (class 2606 OID 24984)
-- Name: members_payment_events members_payment_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_payment_events
    ADD CONSTRAINT members_payment_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2882 (class 2606 OID 25024)
-- Name: members_product_events members_product_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_product_events
    ADD CONSTRAINT members_product_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2883 (class 2606 OID 25029)
-- Name: members_product_events members_product_events_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_product_events
    ADD CONSTRAINT members_product_events_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 2872 (class 2606 OID 24931)
-- Name: members_products members_products_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_products
    ADD CONSTRAINT members_products_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2873 (class 2606 OID 24936)
-- Name: members_products members_products_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_products
    ADD CONSTRAINT members_products_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- TOC entry 2881 (class 2606 OID 25014)
-- Name: members_status_events members_status_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_status_events
    ADD CONSTRAINT members_status_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2887 (class 2606 OID 25135)
-- Name: members_stripe_customers members_stripe_customers_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_stripe_customers
    ADD CONSTRAINT members_stripe_customers_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2891 (class 2606 OID 25224)
-- Name: members_stripe_customers_subscriptions members_stripe_customers_subscriptio_ghost_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_stripe_customers_subscriptions
    ADD CONSTRAINT members_stripe_customers_subscriptio_ghost_subscription_id_fkey FOREIGN KEY (ghost_subscription_id) REFERENCES public.subscriptions(id) ON DELETE CASCADE;


--
-- TOC entry 2892 (class 2606 OID 25239)
-- Name: members_stripe_customers_subscriptions members_stripe_customers_subscriptions_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_stripe_customers_subscriptions
    ADD CONSTRAINT members_stripe_customers_subscriptions_fk FOREIGN KEY (customer_id) REFERENCES public.members_stripe_customers(id) ON DELETE CASCADE;


--
-- TOC entry 2893 (class 2606 OID 25229)
-- Name: members_stripe_customers_subscriptions members_stripe_customers_subscriptions_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_stripe_customers_subscriptions
    ADD CONSTRAINT members_stripe_customers_subscriptions_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.offers(id);


--
-- TOC entry 2899 (class 2606 OID 25287)
-- Name: members_subscribe_events members_subscribe_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_subscribe_events
    ADD CONSTRAINT members_subscribe_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2900 (class 2606 OID 25292)
-- Name: members_subscribe_events members_subscribe_events_newsletter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_subscribe_events
    ADD CONSTRAINT members_subscribe_events_newsletter_id_fkey FOREIGN KEY (newsletter_id) REFERENCES public.newsletters(id);


--
-- TOC entry 2894 (class 2606 OID 25251)
-- Name: members_subscription_created_events members_subscription_created_events_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_subscription_created_events
    ADD CONSTRAINT members_subscription_created_events_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2895 (class 2606 OID 25256)
-- Name: members_subscription_created_events members_subscription_created_events_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.members_subscription_created_events
    ADD CONSTRAINT members_subscription_created_events_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.members_stripe_customers_subscriptions(id) ON DELETE CASCADE;


--
-- TOC entry 2896 (class 2606 OID 25271)
-- Name: offer_redemptions offer_redemptions_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.offer_redemptions
    ADD CONSTRAINT offer_redemptions_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2897 (class 2606 OID 25266)
-- Name: offer_redemptions offer_redemptions_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.offer_redemptions
    ADD CONSTRAINT offer_redemptions_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.offers(id) ON DELETE CASCADE;


--
-- TOC entry 2898 (class 2606 OID 25276)
-- Name: offer_redemptions offer_redemptions_subscription_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.offer_redemptions
    ADD CONSTRAINT offer_redemptions_subscription_id_fkey FOREIGN KEY (subscription_id) REFERENCES public.members_stripe_customers_subscriptions(id) ON DELETE CASCADE;


--
-- TOC entry 2869 (class 2606 OID 24899)
-- Name: offers offers_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.offers
    ADD CONSTRAINT offers_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 2862 (class 2606 OID 24708)
-- Name: posts_authors posts_authors_author_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts_authors
    ADD CONSTRAINT posts_authors_author_id_fkey FOREIGN KEY (author_id) REFERENCES public.users(id);


--
-- TOC entry 2863 (class 2606 OID 24703)
-- Name: posts_authors posts_authors_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts_authors
    ADD CONSTRAINT posts_authors_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- TOC entry 2859 (class 2606 OID 24656)
-- Name: posts_meta posts_meta_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts_meta
    ADD CONSTRAINT posts_meta_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- TOC entry 2858 (class 2606 OID 24619)
-- Name: posts posts_newsletter_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_newsletter_id_fkey FOREIGN KEY (newsletter_id) REFERENCES public.newsletters(id);


--
-- TOC entry 2874 (class 2606 OID 24947)
-- Name: posts_products posts_products_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts_products
    ADD CONSTRAINT posts_products_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- TOC entry 2875 (class 2606 OID 24952)
-- Name: posts_products posts_products_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts_products
    ADD CONSTRAINT posts_products_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- TOC entry 2866 (class 2606 OID 24798)
-- Name: posts_tags posts_tags_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts_tags
    ADD CONSTRAINT posts_tags_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id);


--
-- TOC entry 2867 (class 2606 OID 24803)
-- Name: posts_tags posts_tags_tag_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.posts_tags
    ADD CONSTRAINT posts_tags_tag_id_fkey FOREIGN KEY (tag_id) REFERENCES public.tags(id);


--
-- TOC entry 2870 (class 2606 OID 24920)
-- Name: products_benefits products_benefits_benefit_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.products_benefits
    ADD CONSTRAINT products_benefits_benefit_id_fkey FOREIGN KEY (benefit_id) REFERENCES public.benefits(id) ON DELETE CASCADE;


--
-- TOC entry 2871 (class 2606 OID 24915)
-- Name: products_benefits products_benefits_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.products_benefits
    ADD CONSTRAINT products_benefits_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id) ON DELETE CASCADE;


--
-- TOC entry 2916 (class 2606 OID 25546)
-- Name: redirects redirects_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.redirects
    ADD CONSTRAINT redirects_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE SET NULL;


--
-- TOC entry 2888 (class 2606 OID 25147)
-- Name: subscriptions subscriptions_member_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_member_id_fkey FOREIGN KEY (member_id) REFERENCES public.members(id) ON DELETE CASCADE;


--
-- TOC entry 2889 (class 2606 OID 25157)
-- Name: subscriptions subscriptions_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES public.offers(id);


--
-- TOC entry 2890 (class 2606 OID 25152)
-- Name: subscriptions subscriptions_tier_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.subscriptions
    ADD CONSTRAINT subscriptions_tier_id_fkey FOREIGN KEY (tier_id) REFERENCES public.products(id);


--
-- TOC entry 2921 (class 2606 OID 25587)
-- Name: suppressions suppressions_email_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.suppressions
    ADD CONSTRAINT suppressions_email_id_fkey FOREIGN KEY (email_id) REFERENCES public.emails(id);


--
-- TOC entry 2864 (class 2606 OID 24782)
-- Name: tags tags_fk; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_fk FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- TOC entry 2865 (class 2606 OID 24787)
-- Name: tags tags_fk_1; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.tags
    ADD CONSTRAINT tags_fk_1 FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- TOC entry 2860 (class 2606 OID 24687)
-- Name: users users_fk_created_by; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_fk_created_by FOREIGN KEY (created_by) REFERENCES public.users(id);


--
-- TOC entry 2861 (class 2606 OID 24692)
-- Name: users users_fk_updated_by; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_fk_updated_by FOREIGN KEY (updated_by) REFERENCES public.users(id);


--
-- TOC entry 2868 (class 2606 OID 24845)
-- Name: webhooks webhooks_integration_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: default
--

ALTER TABLE ONLY public.webhooks
    ADD CONSTRAINT webhooks_integration_id_fkey FOREIGN KEY (integration_id) REFERENCES public.integrations(id) ON DELETE CASCADE;


-- Completed on 2023-05-18 22:10:29

--
-- PostgreSQL database dump complete
--

-- Completed on 2023-05-18 22:10:29

--
-- PostgreSQL database cluster dump complete
--

