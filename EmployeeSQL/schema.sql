--
-- PostgreSQL database dump
--

-- Dumped from database version 13.2
-- Dumped by pg_dump version 13.2

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
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    dept_no character varying NOT NULL,
    dept_name character varying(30)
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- Name: dept_emp; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dept_emp (
    emp_no integer NOT NULL,
    dept_no character varying NOT NULL
);


ALTER TABLE public.dept_emp OWNER TO postgres;

--
-- Name: dept_manager; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dept_manager (
    dept_no character varying NOT NULL,
    emp_no integer NOT NULL
);


ALTER TABLE public.dept_manager OWNER TO postgres;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    emp_no integer NOT NULL,
    emp_title_id character varying(30) NOT NULL,
    birth_date character varying,
    first_name character varying,
    last_name character varying,
    sex character varying,
    hire_date character varying
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: eight; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.eight AS
 SELECT employees.last_name,
    count(employees.last_name) AS frequency
   FROM public.employees
  GROUP BY employees.last_name
  ORDER BY (count(employees.last_name)) DESC;


ALTER TABLE public.eight OWNER TO postgres;

--
-- Name: five; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.five AS
 SELECT employees.first_name,
    employees.last_name,
    employees.sex
   FROM public.employees
  WHERE (((employees.first_name)::text = 'Hercules'::text) AND ((employees.last_name)::text ~~ 'B%'::text));


ALTER TABLE public.five OWNER TO postgres;

--
-- Name: four; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.four AS
 SELECT e.emp_no,
    e.first_name,
    e.last_name,
    d.dept_name
   FROM ((public.employees e
     JOIN public.dept_emp de ON ((e.emp_no = de.emp_no)))
     JOIN public.departments d ON (((de.dept_no)::text = (d.dept_no)::text)));


ALTER TABLE public.four OWNER TO postgres;

--
-- Name: salaries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salaries (
    emp_no integer,
    salary integer
);


ALTER TABLE public.salaries OWNER TO postgres;

--
-- Name: one; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.one AS
 SELECT e.emp_no,
    e.first_name,
    e.last_name,
    e.sex,
    s.salary
   FROM (public.employees e
     JOIN public.salaries s ON ((e.emp_no = s.emp_no)));


ALTER TABLE public.one OWNER TO postgres;

--
-- Name: seven; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.seven AS
 SELECT e.emp_no,
    e.first_name,
    e.last_name,
    d.dept_name
   FROM ((public.employees e
     JOIN public.dept_emp de ON ((e.emp_no = de.emp_no)))
     JOIN public.departments d ON (((de.dept_no)::text = (d.dept_no)::text)))
  WHERE ((d.dept_name)::text = ANY ((ARRAY['Sales'::character varying, 'Development'::character varying])::text[]));


ALTER TABLE public.seven OWNER TO postgres;

--
-- Name: six; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.six AS
 SELECT e.emp_no,
    e.first_name,
    e.last_name,
    d.dept_name
   FROM ((public.employees e
     JOIN public.dept_emp de ON ((e.emp_no = de.emp_no)))
     JOIN public.departments d ON (((de.dept_no)::text = (d.dept_no)::text)))
  WHERE ((d.dept_name)::text = 'Sales'::text);


ALTER TABLE public.six OWNER TO postgres;

--
-- Name: three; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.three AS
 SELECT d.dept_no,
    d.dept_name,
    e.emp_no,
    e.first_name,
    e.last_name
   FROM ((public.employees e
     JOIN public.dept_manager m ON ((e.emp_no = m.emp_no)))
     JOIN public.departments d ON (((m.dept_no)::text = (d.dept_no)::text)));


ALTER TABLE public.three OWNER TO postgres;

--
-- Name: titles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.titles (
    title_id character varying NOT NULL,
    title character varying
);


ALTER TABLE public.titles OWNER TO postgres;

--
-- Name: two; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.two AS
 SELECT employees.first_name,
    employees.last_name,
    employees.hire_date
   FROM public.employees
  WHERE ((employees.hire_date)::text ~~ '%1986'::text);


ALTER TABLE public.two OWNER TO postgres;

--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (dept_no);


--
-- Name: dept_emp dept_emp_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_emp
    ADD CONSTRAINT dept_emp_pkey PRIMARY KEY (emp_no, dept_no);


--
-- Name: dept_manager dept_manager_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_manager
    ADD CONSTRAINT dept_manager_pkey PRIMARY KEY (emp_no, dept_no);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (emp_no, emp_title_id);


--
-- Name: titles titles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titles
    ADD CONSTRAINT titles_pkey PRIMARY KEY (title_id);


--
-- Name: dept_emp dept_emp_dept_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_emp
    ADD CONSTRAINT dept_emp_dept_no_fkey FOREIGN KEY (dept_no) REFERENCES public.departments(dept_no);


--
-- Name: dept_manager dept_manager_dept_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_manager
    ADD CONSTRAINT dept_manager_dept_no_fkey FOREIGN KEY (dept_no) REFERENCES public.departments(dept_no);


--
-- Name: employees employees_emp_title_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_emp_title_id_fkey FOREIGN KEY (emp_title_id) REFERENCES public.titles(title_id);


--
-- PostgreSQL database dump complete
--

