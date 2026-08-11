--
-- PostgreSQL database dump
--

\restrict AsORsy0FjqwUslXoDQB1gfPXngij0w3EgamSVQIXyfEpNqTpTFVfP7s8PgoK5Lg

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

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
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: actitem_info; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.actitem_info (
    project_code character varying(8) NOT NULL,
    kind_seq integer NOT NULL,
    kind_name character varying(60),
    stakehdr_code character varying(3),
    actitem_code character varying(3),
    ivent character varying(40),
    called character varying(30),
    accrual_date character varying(10),
    content text,
    limit_date character varying(10),
    complete_date character varying(10),
    request_user character varying(20),
    request_date character varying(10),
    approval_user character varying(20),
    approval_date character varying(10),
    approval_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.actitem_info OWNER TO prjuser;

--
-- Name: actitem_report; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.actitem_report (
    project_code character varying(8) NOT NULL,
    kind_seq integer NOT NULL,
    report_seq integer NOT NULL,
    status_code character varying(3),
    compliance text,
    plan_complete_date character varying(10),
    report_user character varying(20),
    report_date character varying(10),
    accept_user character varying(20),
    accept_date character varying(10),
    report_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.actitem_report OWNER TO prjuser;

--
-- Name: actual_task; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.actual_task (
    work_user character varying(20) NOT NULL,
    work_date character varying(10) NOT NULL,
    task_code character varying(3) NOT NULL,
    job_time numeric,
    job_detail text,
    update_time timestamp without time zone
);


ALTER TABLE public.actual_task OWNER TO prjuser;

--
-- Name: daily_report; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.daily_report (
    work_user character varying(20) NOT NULL,
    work_date character varying(10) NOT NULL,
    communication_note text,
    approval_user character varying(20),
    approval_date character varying(10),
    approval_comment text,
    approval_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.daily_report OWNER TO prjuser;

--
-- Name: info; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.info (
    seq integer NOT NULL,
    date date,
    body text,
    limit_date date,
    idate timestamp without time zone,
    udate timestamp without time zone
);


ALTER TABLE public.info OWNER TO prjuser;

--
-- Name: m_common_task; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.m_common_task (
    task_code character varying(3) NOT NULL,
    task_name character varying(50),
    update_time timestamp without time zone
);


ALTER TABLE public.m_common_task OWNER TO prjuser;

--
-- Name: m_status; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.m_status (
    kind character varying(1) NOT NULL,
    status_code character varying(3) NOT NULL,
    status_name character varying(20),
    update_time timestamp without time zone
);


ALTER TABLE public.m_status OWNER TO prjuser;

--
-- Name: m_type; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.m_type (
    kind character varying(1) NOT NULL,
    type_code character varying(3) NOT NULL,
    type_name character varying(20),
    view_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.m_type OWNER TO prjuser;

--
-- Name: m_user; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.m_user (
    user_id character varying(20) NOT NULL,
    user_pass text,
    user_name character varying(50),
    mail_addr character varying(60),
    user_com character varying(1),
    unit_price integer,
    delete_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.m_user OWNER TO prjuser;

--
-- Name: procure_info; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.procure_info (
    project_code character varying(8) NOT NULL,
    kind_seq integer NOT NULL,
    kind_name character varying(60),
    content text,
    countermeasure character varying(60),
    plan_start_date character varying(10),
    plan_end_date character varying(10),
    start_date character varying(10),
    end_date character varying(10),
    request_user character varying(20),
    request_date character varying(10),
    approval_user character varying(20),
    approval_date character varying(10),
    approval_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.procure_info OWNER TO prjuser;

--
-- Name: procure_report; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.procure_report (
    project_code character varying(8) NOT NULL,
    kind_seq integer NOT NULL,
    report_seq integer NOT NULL,
    status_code character varying(3),
    progress_date character varying(10),
    rate_progress numeric,
    compliance text,
    plan_start_date character varying(10),
    plan_end_date character varying(10),
    report_user character varying(20),
    report_date character varying(10),
    accept_user character varying(20),
    accept_date character varying(10),
    report_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.procure_report OWNER TO prjuser;

--
-- Name: project_info; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.project_info (
    project_code character varying(8) NOT NULL,
    project_name character varying(120),
    project_note text,
    client_name character varying(60),
    client_note text,
    price bigint,
    contract_start_date character varying(10),
    contract_end_date character varying(10),
    plan_start_date character varying(10),
    plan_end_date character varying(10),
    cost_rate numeric,
    status_code character varying(3),
    update_time timestamp without time zone
);


ALTER TABLE public.project_info OWNER TO prjuser;

--
-- Name: quality_info; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.quality_info (
    project_code character varying(8) NOT NULL,
    kind_seq integer NOT NULL,
    kind_name character varying(60),
    content text,
    request_user character varying(20),
    request_date character varying(10),
    approval_user character varying(20),
    approval_date character varying(10),
    approval_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.quality_info OWNER TO prjuser;

--
-- Name: quality_report_review; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.quality_report_review (
    project_code character varying(8) NOT NULL,
    kind_seq integer NOT NULL,
    work_seq integer NOT NULL,
    detail_seq integer NOT NULL,
    report_seq integer NOT NULL,
    point_content text,
    corrspe_content text,
    status_code character varying(3),
    plan_complete_date character varying(10),
    point_user character varying(12),
    point_date character varying(10),
    corrspe_user character varying(12),
    corrspe_date character varying(10),
    accept_user character varying(12),
    accept_date character varying(10),
    report_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.quality_report_review OWNER TO prjuser;

--
-- Name: quality_report_test; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.quality_report_test (
    project_code character varying(8) NOT NULL,
    kind_seq integer NOT NULL,
    work_seq integer NOT NULL,
    detail_seq integer NOT NULL,
    report_seq integer NOT NULL,
    start_date character varying(10),
    report_content text,
    plan_complete_date character varying(10),
    total_case integer,
    complete_case integer,
    error_case integer,
    report_user character varying(12),
    report_date character varying(10),
    accept_user character varying(12),
    accept_date character varying(10),
    report_flag character varying(1),
    update_time timestamp(6) without time zone
);


ALTER TABLE public.quality_report_test OWNER TO prjuser;

--
-- Name: risk_info; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.risk_info (
    project_code character varying(8) NOT NULL,
    kind_seq integer NOT NULL,
    kind_name character varying(60),
    content text,
    event_prob character varying(1),
    impact character varying(1),
    risk_type character varying(1),
    countermeasure text,
    plan_complete_date character varying(10),
    complete_date character varying(10),
    request_user character varying(20),
    request_date character varying(10),
    approval_user character varying(20),
    approval_date character varying(10),
    approval_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.risk_info OWNER TO prjuser;

--
-- Name: risk_report; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.risk_report (
    project_code character varying(8) NOT NULL,
    kind_seq integer NOT NULL,
    report_seq integer NOT NULL,
    status_code character varying(3),
    state text,
    plan_complete_date character varying(10),
    report_user character varying(20),
    report_date character varying(10),
    accept_user character varying(20),
    accept_date character varying(10),
    report_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.risk_report OWNER TO prjuser;

--
-- Name: task_info; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.task_info (
    project_code character varying(8) NOT NULL,
    kind_seq integer NOT NULL,
    kind_name character varying(60),
    content text,
    request_user character varying(20),
    request_date character varying(10),
    approval_user character varying(20),
    approval_date character varying(10),
    approval_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.task_info OWNER TO prjuser;

--
-- Name: wbs; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.wbs (
    project_code character varying(8) NOT NULL,
    kind character varying(1) NOT NULL,
    kind_seq integer NOT NULL,
    work_seq integer NOT NULL,
    detail_seq integer NOT NULL,
    work_user character varying(20),
    plan_start_date character varying(10),
    plan_end_date character varying(10),
    plan_job_time numeric,
    start_date character varying(10),
    end_date character varying(10),
    job_time numeric,
    progress numeric,
    update_time timestamp without time zone
);


ALTER TABLE public.wbs OWNER TO prjuser;

--
-- Name: wbs_actual; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.wbs_actual (
    project_code character varying(8) NOT NULL,
    kind character varying(1) NOT NULL,
    kind_seq integer NOT NULL,
    work_seq integer NOT NULL,
    detail_seq integer NOT NULL,
    work_date character varying(10) NOT NULL,
    work_user character varying(20),
    job_time numeric,
    job_time_rest numeric,
    job_detail text,
    update_time timestamp without time zone
);


ALTER TABLE public.wbs_actual OWNER TO prjuser;

--
-- Name: work_content; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.work_content (
    project_code character varying(8) NOT NULL,
    kind character varying(1) NOT NULL,
    kind_seq integer NOT NULL,
    work_seq integer NOT NULL,
    work_name character varying(120),
    work_content text,
    request_user character varying(20),
    request_date character varying(10),
    approval_user character varying(20),
    approval_date character varying(10),
    approval_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.work_content OWNER TO prjuser;

--
-- Name: work_detail; Type: TABLE; Schema: public; Owner: prjuser
--

CREATE TABLE public.work_detail (
    project_code character varying(8) NOT NULL,
    kind character varying(1) NOT NULL,
    kind_seq integer NOT NULL,
    work_seq integer NOT NULL,
    detail_seq integer NOT NULL,
    work_type character varying(1),
    type_code character varying(3),
    work_user character varying(20),
    plan_start_date character varying(10),
    plan_end_date character varying(10),
    plan_job_time numeric,
    deliverable character varying(60),
    request_user character varying(20),
    request_date character varying(10),
    approval_user character varying(20),
    approval_date character varying(10),
    approval_flag character varying(1),
    update_time timestamp without time zone
);


ALTER TABLE public.work_detail OWNER TO prjuser;

--
-- Name: actitem_info actitem_info_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.actitem_info
    ADD CONSTRAINT actitem_info_pkey PRIMARY KEY (project_code, kind_seq);


--
-- Name: actitem_report actitem_report_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.actitem_report
    ADD CONSTRAINT actitem_report_pkey PRIMARY KEY (project_code, kind_seq, report_seq);


--
-- Name: actual_task actual_task_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.actual_task
    ADD CONSTRAINT actual_task_pkey PRIMARY KEY (work_user, work_date, task_code);


--
-- Name: daily_report daily_report_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.daily_report
    ADD CONSTRAINT daily_report_pkey PRIMARY KEY (work_user, work_date);


--
-- Name: info info_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.info
    ADD CONSTRAINT info_pkey PRIMARY KEY (seq);


--
-- Name: m_common_task m_common_task_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.m_common_task
    ADD CONSTRAINT m_common_task_pkey PRIMARY KEY (task_code);


--
-- Name: m_status m_status_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.m_status
    ADD CONSTRAINT m_status_pkey PRIMARY KEY (kind, status_code);


--
-- Name: m_type m_type_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.m_type
    ADD CONSTRAINT m_type_pkey PRIMARY KEY (kind, type_code);


--
-- Name: m_user m_user_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.m_user
    ADD CONSTRAINT m_user_pkey PRIMARY KEY (user_id);


--
-- Name: procure_info procure_info_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.procure_info
    ADD CONSTRAINT procure_info_pkey PRIMARY KEY (project_code, kind_seq);


--
-- Name: procure_report procure_report_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.procure_report
    ADD CONSTRAINT procure_report_pkey PRIMARY KEY (project_code, kind_seq, report_seq);


--
-- Name: project_info project_info_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.project_info
    ADD CONSTRAINT project_info_pkey PRIMARY KEY (project_code);


--
-- Name: quality_info quality_info_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.quality_info
    ADD CONSTRAINT quality_info_pkey PRIMARY KEY (project_code, kind_seq);


--
-- Name: quality_report_review quality_report_review_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.quality_report_review
    ADD CONSTRAINT quality_report_review_pkey PRIMARY KEY (project_code, kind_seq, work_seq, detail_seq, report_seq);


--
-- Name: quality_report_test quality_report_test_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.quality_report_test
    ADD CONSTRAINT quality_report_test_pkey PRIMARY KEY (project_code, kind_seq, work_seq, detail_seq, report_seq);


--
-- Name: risk_info risk_info_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.risk_info
    ADD CONSTRAINT risk_info_pkey PRIMARY KEY (project_code, kind_seq);


--
-- Name: risk_report risk_report_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.risk_report
    ADD CONSTRAINT risk_report_pkey PRIMARY KEY (project_code, kind_seq, report_seq);


--
-- Name: task_info task_info_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.task_info
    ADD CONSTRAINT task_info_pkey PRIMARY KEY (project_code, kind_seq);


--
-- Name: wbs_actual wbs_actual_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.wbs_actual
    ADD CONSTRAINT wbs_actual_pkey PRIMARY KEY (project_code, kind, kind_seq, work_seq, detail_seq, work_date);


--
-- Name: wbs wbs_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.wbs
    ADD CONSTRAINT wbs_pkey PRIMARY KEY (project_code, kind, kind_seq, work_seq, detail_seq);


--
-- Name: work_content work_content_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.work_content
    ADD CONSTRAINT work_content_pkey PRIMARY KEY (project_code, kind, kind_seq, work_seq);


--
-- Name: work_detail work_detail_pkey; Type: CONSTRAINT; Schema: public; Owner: prjuser
--

ALTER TABLE ONLY public.work_detail
    ADD CONSTRAINT work_detail_pkey PRIMARY KEY (project_code, kind, kind_seq, work_seq, detail_seq);


--
-- PostgreSQL database dump complete
--

\unrestrict AsORsy0FjqwUslXoDQB1gfPXngij0w3EgamSVQIXyfEpNqTpTFVfP7s8PgoK5Lg

