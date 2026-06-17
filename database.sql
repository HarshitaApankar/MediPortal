--
-- PostgreSQL database dump
--

\restrict qYCHlauL9eUeeXdEvJqBckonbvreTn9k0aCnk2eMztUZapRG5yHYVJW1tfo3m34

-- Dumped from database version 18.1
-- Dumped by pg_dump version 18.1

-- Started on 2026-06-17 10:48:45

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 234 (class 1259 OID 49457)
-- Name: appointments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointments (
    id integer NOT NULL,
    user_id integer,
    doctor_name character varying(100),
    date character varying(50),
    "time" character varying(50)
);


ALTER TABLE public.appointments OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 49456)
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.appointments_id_seq OWNER TO postgres;

--
-- TOC entry 5127 (class 0 OID 0)
-- Dependencies: 233
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- TOC entry 240 (class 1259 OID 49481)
-- Name: billing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.billing (
    id integer NOT NULL,
    user_id integer,
    description character varying(100),
    amount integer
);


ALTER TABLE public.billing OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 49480)
-- Name: billing_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.billing_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.billing_id_seq OWNER TO postgres;

--
-- TOC entry 5128 (class 0 OID 0)
-- Dependencies: 239
-- Name: billing_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.billing_id_seq OWNED BY public.billing.id;


--
-- TOC entry 222 (class 1259 OID 41123)
-- Name: blood_donor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blood_donor (
    id integer NOT NULL,
    user_id integer,
    full_name character varying(100),
    address text,
    aadhaar_number character varying(20),
    hospital_name character varying(100),
    disease text,
    blood_type character varying(5) NOT NULL,
    age integer NOT NULL,
    location character varying(100) NOT NULL,
    phone character varying(20) NOT NULL,
    last_donation_date date,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.blood_donor OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 41122)
-- Name: blood_donor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blood_donor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blood_donor_id_seq OWNER TO postgres;

--
-- TOC entry 5129 (class 0 OID 0)
-- Dependencies: 221
-- Name: blood_donor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blood_donor_id_seq OWNED BY public.blood_donor.id;


--
-- TOC entry 224 (class 1259 OID 41143)
-- Name: blood_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.blood_request (
    id integer NOT NULL,
    full_name character varying(100),
    address text,
    aadhaar_number character varying(20),
    hospital_name character varying(100),
    disease text,
    blood_type character varying(5) NOT NULL,
    location character varying(100) NOT NULL,
    urgency character varying(20) NOT NULL,
    contact_info character varying(100) NOT NULL,
    status character varying(20) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.blood_request OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 41142)
-- Name: blood_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.blood_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.blood_request_id_seq OWNER TO postgres;

--
-- TOC entry 5130 (class 0 OID 0)
-- Dependencies: 223
-- Name: blood_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.blood_request_id_seq OWNED BY public.blood_request.id;


--
-- TOC entry 232 (class 1259 OID 41203)
-- Name: health_blog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.health_blog (
    id integer NOT NULL,
    title character varying(200),
    content text,
    author character varying(100),
    date_posted date
);


ALTER TABLE public.health_blog OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 41202)
-- Name: health_blog_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.health_blog_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.health_blog_id_seq OWNER TO postgres;

--
-- TOC entry 5131 (class 0 OID 0)
-- Dependencies: 231
-- Name: health_blog_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.health_blog_id_seq OWNED BY public.health_blog.id;


--
-- TOC entry 230 (class 1259 OID 41195)
-- Name: hospitals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.hospitals (
    id integer NOT NULL,
    name character varying(100),
    city character varying(50),
    contact character varying(20),
    specialization character varying(100)
);


ALTER TABLE public.hospitals OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 41194)
-- Name: hospitals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hospitals_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.hospitals_id_seq OWNER TO postgres;

--
-- TOC entry 5132 (class 0 OID 0)
-- Dependencies: 229
-- Name: hospitals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.hospitals_id_seq OWNED BY public.hospitals.id;


--
-- TOC entry 220 (class 1259 OID 41107)
-- Name: newusers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.newusers (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    email character varying(100) NOT NULL,
    password_hash character varying(255) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.newusers OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 41106)
-- Name: newusers_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.newusers_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.newusers_id_seq OWNER TO postgres;

--
-- TOC entry 5133 (class 0 OID 0)
-- Dependencies: 219
-- Name: newusers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.newusers_id_seq OWNED BY public.newusers.id;


--
-- TOC entry 226 (class 1259 OID 41159)
-- Name: organ_donor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organ_donor (
    id integer NOT NULL,
    user_id integer,
    full_name character varying(100),
    address text,
    aadhaar_number character varying(20),
    hospital_name character varying(100),
    disease text,
    age integer NOT NULL,
    organ_type character varying(50) NOT NULL,
    location character varying(100) NOT NULL,
    phone character varying(20) NOT NULL,
    medical_history text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.organ_donor OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 41158)
-- Name: organ_donor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.organ_donor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.organ_donor_id_seq OWNER TO postgres;

--
-- TOC entry 5134 (class 0 OID 0)
-- Dependencies: 225
-- Name: organ_donor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.organ_donor_id_seq OWNED BY public.organ_donor.id;


--
-- TOC entry 228 (class 1259 OID 41179)
-- Name: organ_request; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.organ_request (
    id integer NOT NULL,
    full_name character varying(100),
    address text,
    aadhaar_number character varying(20),
    hospital_name character varying(100),
    disease text,
    organ_type character varying(50) NOT NULL,
    location character varying(100) NOT NULL,
    contact_info character varying(100) NOT NULL,
    urgency character varying(20) DEFAULT 'normal'::character varying,
    status character varying(20) DEFAULT 'pending'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.organ_request OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 41178)
-- Name: organ_request_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.organ_request_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.organ_request_id_seq OWNER TO postgres;

--
-- TOC entry 5135 (class 0 OID 0)
-- Dependencies: 227
-- Name: organ_request_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.organ_request_id_seq OWNED BY public.organ_request.id;


--
-- TOC entry 236 (class 1259 OID 49465)
-- Name: prescriptions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.prescriptions (
    id integer NOT NULL,
    user_id integer,
    medicine character varying(100),
    dosage character varying(100)
);


ALTER TABLE public.prescriptions OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 49464)
-- Name: prescriptions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.prescriptions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.prescriptions_id_seq OWNER TO postgres;

--
-- TOC entry 5136 (class 0 OID 0)
-- Dependencies: 235
-- Name: prescriptions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.prescriptions_id_seq OWNED BY public.prescriptions.id;


--
-- TOC entry 238 (class 1259 OID 49473)
-- Name: reports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.reports (
    id integer NOT NULL,
    user_id integer,
    report_name character varying(100),
    result character varying(100)
);


ALTER TABLE public.reports OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 49472)
-- Name: reports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.reports_id_seq OWNER TO postgres;

--
-- TOC entry 5137 (class 0 OID 0)
-- Dependencies: 237
-- Name: reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.reports_id_seq OWNED BY public.reports.id;


--
-- TOC entry 4921 (class 2604 OID 49460)
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- TOC entry 4924 (class 2604 OID 49484)
-- Name: billing id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing ALTER COLUMN id SET DEFAULT nextval('public.billing_id_seq'::regclass);


--
-- TOC entry 4908 (class 2604 OID 41126)
-- Name: blood_donor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_donor ALTER COLUMN id SET DEFAULT nextval('public.blood_donor_id_seq'::regclass);


--
-- TOC entry 4910 (class 2604 OID 41146)
-- Name: blood_request id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_request ALTER COLUMN id SET DEFAULT nextval('public.blood_request_id_seq'::regclass);


--
-- TOC entry 4920 (class 2604 OID 41206)
-- Name: health_blog id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_blog ALTER COLUMN id SET DEFAULT nextval('public.health_blog_id_seq'::regclass);


--
-- TOC entry 4919 (class 2604 OID 41198)
-- Name: hospitals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospitals ALTER COLUMN id SET DEFAULT nextval('public.hospitals_id_seq'::regclass);


--
-- TOC entry 4906 (class 2604 OID 41110)
-- Name: newusers id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newusers ALTER COLUMN id SET DEFAULT nextval('public.newusers_id_seq'::regclass);


--
-- TOC entry 4913 (class 2604 OID 41162)
-- Name: organ_donor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organ_donor ALTER COLUMN id SET DEFAULT nextval('public.organ_donor_id_seq'::regclass);


--
-- TOC entry 4915 (class 2604 OID 41182)
-- Name: organ_request id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organ_request ALTER COLUMN id SET DEFAULT nextval('public.organ_request_id_seq'::regclass);


--
-- TOC entry 4922 (class 2604 OID 49468)
-- Name: prescriptions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions ALTER COLUMN id SET DEFAULT nextval('public.prescriptions_id_seq'::regclass);


--
-- TOC entry 4923 (class 2604 OID 49476)
-- Name: reports id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports ALTER COLUMN id SET DEFAULT nextval('public.reports_id_seq'::regclass);


--
-- TOC entry 5115 (class 0 OID 49457)
-- Dependencies: 234
-- Data for Name: appointments; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointments (id, user_id, doctor_name, date, "time") FROM stdin;
2	4	Dr. Shah	2026-03-27	10:30
3	4	Dr. patil	2026-03-29	11:30
4	6	Dr. kapur	2026-04-17	17:14
5	6	dr lada	2026-04-23	03:14
\.


--
-- TOC entry 5121 (class 0 OID 49481)
-- Dependencies: 240
-- Data for Name: billing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.billing (id, user_id, description, amount) FROM stdin;
1	1	Doctor Consultation	500
2	1	Blood Test	300
3	1	Medicine Charges	200
4	4	Paid	18000
\.


--
-- TOC entry 5103 (class 0 OID 41123)
-- Dependencies: 222
-- Data for Name: blood_donor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blood_donor (id, user_id, full_name, address, aadhaar_number, hospital_name, disease, blood_type, age, location, phone, last_donation_date, created_at) FROM stdin;
1	\N	Sarika Apankar	B-601, Sai Aura	65835352	civil hospital	None	B+	43	Silvassa	9624394209	2026-03-14	2026-03-12 18:14:16.938801
2	\N	Prathmesh Apankar	b-901,galaxy apartment	4577548989	namo hospital	Diabetes	A+	45	vapi	9877564239	2026-03-28	2026-03-12 19:04:45.397207
3	\N	Unnati 	A-801,Yogi Milan 	789512364	Sunflower hospital	None	AB+	20	Goa	8955675512	2026-03-17	2026-03-12 19:07:17.015046
4	\N	Pranshiv 	A-105,Ekdant Square 	895623478	Magic hospital	Blood Pressure	O+	18	Nashik	8955675512	2026-03-10	2026-03-12 19:09:34.122545
5	\N	Vasant	A-205,Ekdant Square 	895623478	Magic hospital	Blood Pressure	O+	18	Nashik	8986675512	2026-03-12	2026-03-12 19:11:34.272571
6	\N	Anushka	A-205,Meadows	895629875	Extoric hospital	Heart Disease	A+	23	Mumbai	9855445512	2026-10-20	2026-03-12 19:13:01.090744
7	\N	Anushka	A-205,Meadows	4577548989	Extoric hospital	Diabetes	B+	23	Mumbai	9855445512	2026-10-20	2026-03-12 20:03:10.689525
8	\N	Prathmesh Apankar	b-901,galaxy apartment	4577548989	Extoric hospital	Diabetes	B+	23	Mumbai	9855445512	2026-10-20	2026-03-12 20:03:30.228059
9	\N	Prathmesh Apankar	b-901,galaxy apartment	4577548989	Extoric hospital	Diabetes	O+	23	Mumbai	9855445512	2026-10-20	2026-03-13 08:53:33.500162
10	\N	Prathmesh Apankar	b-901,galaxy apartment	4577548989	Extoric hospital	Diabetes	A+	23	Mumbai	9855445512	2026-10-20	2026-03-13 09:33:24.221003
11	\N	Prathmesh Apankar	b-901,galaxy apartment	4577548989	Extoric hospital	Diabetes	O+	23	Mumbai	9855445512	2026-10-20	2026-03-13 09:54:59.071079
12	\N	Prathmesh Apankar	b-901,galaxy apartment	4577548989	Extoric hospital	Diabetes	B+	23	Mumbai	9855445512	2026-10-20	2026-03-13 10:01:40.334639
13	\N	khushi	b-980,exotica	7889554565	namo hospital	Blood Pressure	O+	19	Mumbai	954755485478	2026-04-08	2026-04-16 17:16:57.334475
14	\N	khushi	b-980,exotica	7889554565	namo hospital	Heart Disease	B+	19	Mumbai	954755485478	2026-04-08	2026-04-21 09:06:17.523629
\.


--
-- TOC entry 5105 (class 0 OID 41143)
-- Dependencies: 224
-- Data for Name: blood_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.blood_request (id, full_name, address, aadhaar_number, hospital_name, disease, blood_type, location, urgency, contact_info, status, created_at) FROM stdin;
1	Sarika Apankar	B-601, Sai Aura	65835352	civil hospital	None	B+	silvassa	Medium	9624394209	pending	2026-03-12 18:15:25.372868
2	Sarika Apankar	B-601, Sai Aura	65835352	civil hospital	None	B+	silvassa	Medium	9624394209	pending	2026-03-12 18:19:00.52692
3	jiya sharma	b-901,Mountain apartment	4577548989	namo hospital	Diabetes	B+	vapi	Medium	9624394209	pending	2026-03-12 19:13:43.097041
4	Muskan	b-702,jas exotica	856942375	Prayosha Hospital	Blood Pressure	A+	Silvassa	High	9628954123	pending	2026-03-12 19:15:46.835513
5	Radhika	b-402,Pramukh GARDEN 	8585552224	Marigold Hospital	Heart Disease	AB+	Silvassa	Medium	8921495412	pending	2026-03-12 19:17:23.610527
6	Radhika	b-402,Pramukh GARDEN 	8585552224	Marigold Hospital	Diabetes	A+	Silvassa	Medium	8921495412	pending	2026-03-12 20:04:02.133423
7	Sarika Apankar	B-601, Sai Aura	65835352	civil hospital	Diabetes	A-	silvassa	Medium	9624394209	pending	2026-06-15 20:58:16.719246
\.


--
-- TOC entry 5113 (class 0 OID 41203)
-- Dependencies: 232
-- Data for Name: health_blog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.health_blog (id, title, content, author, date_posted) FROM stdin;
1	Importance of Blood Donation	Blood donation helps save millions of lives every year...	Admin	2026-03-10
2	Organ Donation Awareness	Organ donation is one of the greatest gifts a person can give...	Admin	2026-03-11
3	First Aid Tips Everyone Should Know	Knowing first aid can help you save lives during emergencies...	Admin	2026-03-12
\.


--
-- TOC entry 5111 (class 0 OID 41195)
-- Dependencies: 230
-- Data for Name: hospitals; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.hospitals (id, name, city, contact, specialization) FROM stdin;
1	Kiran Hospital	Surat	0261-123456	Multi-speciality
2	Apple Hospital	Surat	0261-654321	Emergency Care
3	Sunshine Global Hospital	Surat	0261-777777	Cardiology
4	Mahavir Hospital	Surat	0261-888888	Orthopedic
5	City Care Hospital	Mumbai	022-100001	General Medicine
6	Green Valley Hospital	Pune	020-100002	Orthopedic
7	Sunrise Medical Center	Delhi	011-100003	Cardiology
8	Lotus Hospital	Ahmedabad	079-100004	Pediatrics
9	Hope Multispeciality	Bangalore	080-100005	Neurology
10	LifeLine Hospital	Chennai	044-100006	Emergency Care
11	Global Health Hospital	Hyderabad	040-100007	Cardiology
12	Care Plus Hospital	Kolkata	033-100008	Dermatology
13	Shanti Hospital	Jaipur	0141-100009	General Surgery
14	Healing Touch Hospital	Lucknow	0522-100010	Orthopedic
15	Medico Hospital	Indore	0731-100011	ENT
16	Wellness Hospital	Nagpur	0712-100012	General Medicine
17	SunCare Hospital	Bhopal	0755-100013	Cardiology
18	Apollo Care Center	Coimbatore	0422-100014	Neurology
19	Unity Hospital	Patna	0612-100015	Emergency Care
20	Harmony Hospital	Chandigarh	0172-100016	Pediatrics
21	Rainbow Hospital	Visakhapatnam	0891-100017	Dermatology
22	Silverline Hospital	Rajkot	0281-100018	Orthopedic
23	Prime Care Hospital	Vadodara	0265-100019	Cardiology
24	Arogya Hospital	Nashik	0253-100020	General Medicine
25	Trinity Hospital	Mysore	0821-100021	ENT
26	Metro Hospital	Noida	0120-100022	Neurology
27	Life Care Hospital	Gurgaon	0124-100023	Emergency Care
28	Bright Future Hospital	Kanpur	0512-100024	Orthopedic
29	Healthy Life Hospital	Varanasi	0542-100025	Cardiology
30	Shree Hospital	Surat	0261-100026	General Surgery
31	Apex Hospital	Udaipur	0294-100027	Pediatrics
32	New Hope Hospital	Jodhpur	0291-100028	Dermatology
33	City Life Hospital	Amritsar	0183-100029	General Medicine
34	Royal Care Hospital	Trivandrum	0471-100030	Cardiology
\.


--
-- TOC entry 5101 (class 0 OID 41107)
-- Dependencies: 220
-- Data for Name: newusers; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.newusers (id, username, email, password_hash, created_at) FROM stdin;
1	sarika apankar	sarikaapankar@gmail.com	scrypt:32768:8:1$7a4PLuu664IDF7cW$464a85b2927e9dc0a7c41174ab559cca9f0160a0283ad5c119f0afe93c1cc82d692e06e4844f467da97276fa8bfc97d3be7d112b2f24b74b61d02515fbdf1b2b	2026-03-12 18:11:50.444921
2	shreya jha	shreyajha@gmail.com	scrypt:32768:8:1$4aigX6yDmbXqbBTq$7868a6ce76e7138151ccf72b32d6b50fc86f3e25f8b4d6e2641ad061e20fa78dac8655ac26e0d4985d1eb54e0f37def1456d575768c12b187ee0887c8dfd4a69	2026-03-26 12:41:13.931135
3	nita shende	nitashende@gmail.com	scrypt:32768:8:1$sfDFRsKzFBbqErus$105f31f7405e136bbe19cf9ebc31a3beb9e286004fb790dced609f4281ac9358b5a6927a3202a191f056a7a879a8a27fb09e90bccb4021307469d7d73a327060	2026-03-26 15:27:36.049689
4	Pranshiv Patil	pranshiv@gmail.com	scrypt:32768:8:1$ukeQoLyqKZGzCxGd$f871fa70397f8522467ccd6aff81847ba1e63a941b6d14feb15870798c02ae52f6cb8757fe7a1ad193ea436e5478aaf337e35793b44ded22f09be3f585cadf6f	2026-03-26 19:16:58.077538
5	Ganesh Patil	ganeshpatil@gmail.com	scrypt:32768:8:1$8pWmzyhAUCh46bcA$54442ee147af8a80677f5974b75e93e4c5c0d4e65b64ff474c99d5241ea56adba2e4880a4c417e10a3804db39b700e6ca37f485a241fc25803ddb7be01bd7904	2026-03-26 20:19:15.991863
6	Prathmesh Apankar	prathmeshapankar@gmail.com	scrypt:32768:8:1$zc92TltKpwpOAgmE$f67f3672eddb1305664cddd5c4811b1a3e22766101643ed589900a55e5fb3adc119cba5bd0044fbd5305967f4cd95ae431e7933e4a4683bd7985a369df615b6d	2026-04-16 17:13:18.510308
\.


--
-- TOC entry 5107 (class 0 OID 41159)
-- Dependencies: 226
-- Data for Name: organ_donor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organ_donor (id, user_id, full_name, address, aadhaar_number, hospital_name, disease, age, organ_type, location, phone, medical_history, created_at) FROM stdin;
1	\N	rahul pramod patil	b-901,galaxy apartment	4577548989	namo hospital	Blood Pressure	45	Heart	vapi	9877564239	\N	2026-03-13 10:12:22.432182
2	\N	bharti	b-123,luxury 	89564785	Sunflower hospital	None	36	Kidney	silvassa	89657896523	\N	2026-03-13 10:13:58.982287
3	\N	indu	b-123,mark society	89956655	inotica hospital	Diabetes	37	Heart	Pune	89955632536	\N	2026-03-13 10:15:09.979703
4	\N	shreya	d-902,pramukh angan	896577466	Sunflower hospital	Blood Pressure	22	Cornea	Jaipur	789546955685	\N	2026-03-14 10:58:40.399552
5	\N	Siddharth	a-103,exortic apartment	89975949939	Twin city	Diabetes	26	Pancreas	Goa	789654789654	\N	2026-03-14 11:00:34.391697
6	\N	Jash 	a-103,yogi darshan apartment	7569845645	prayosha city	None	31	Liver	Manipur	9865745896	\N	2026-03-14 11:02:51.747754
7	\N	khushi	a-205,Luxury apartment	7895698556	hospfish 	None	19	Kidney	Assam	98955665225	\N	2026-03-14 11:04:32.321263
\.


--
-- TOC entry 5109 (class 0 OID 41179)
-- Dependencies: 228
-- Data for Name: organ_request; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.organ_request (id, full_name, address, aadhaar_number, hospital_name, disease, organ_type, location, contact_info, urgency, status, created_at) FROM stdin;
1	Anushka	A-205,Meadows	89956655	city hospital	Kidney Failure	Kidney	Kanpur	912358688996	Low	pending	2026-03-13 10:16:20.557778
2	Niraj	C-906,dv apartment	4569772696	prayosha hospital	Heart Disease	Heart	jaipur	8657958697	Critical	pending	2026-03-13 10:18:37.060318
\.


--
-- TOC entry 5117 (class 0 OID 49465)
-- Dependencies: 236
-- Data for Name: prescriptions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.prescriptions (id, user_id, medicine, dosage) FROM stdin;
1	4	Paracetamol	500mg twice daily
\.


--
-- TOC entry 5119 (class 0 OID 49473)
-- Dependencies: 238
-- Data for Name: reports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.reports (id, user_id, report_name, result) FROM stdin;
1	1	Blood Test	Normal
2	1	X-Ray	No issues
3	4	Blood Test	Hemoglobin Normal
\.


--
-- TOC entry 5138 (class 0 OID 0)
-- Dependencies: 233
-- Name: appointments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointments_id_seq', 5, true);


--
-- TOC entry 5139 (class 0 OID 0)
-- Dependencies: 239
-- Name: billing_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.billing_id_seq', 4, true);


--
-- TOC entry 5140 (class 0 OID 0)
-- Dependencies: 221
-- Name: blood_donor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blood_donor_id_seq', 14, true);


--
-- TOC entry 5141 (class 0 OID 0)
-- Dependencies: 223
-- Name: blood_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.blood_request_id_seq', 7, true);


--
-- TOC entry 5142 (class 0 OID 0)
-- Dependencies: 231
-- Name: health_blog_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.health_blog_id_seq', 3, true);


--
-- TOC entry 5143 (class 0 OID 0)
-- Dependencies: 229
-- Name: hospitals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hospitals_id_seq', 34, true);


--
-- TOC entry 5144 (class 0 OID 0)
-- Dependencies: 219
-- Name: newusers_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.newusers_id_seq', 6, true);


--
-- TOC entry 5145 (class 0 OID 0)
-- Dependencies: 225
-- Name: organ_donor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.organ_donor_id_seq', 7, true);


--
-- TOC entry 5146 (class 0 OID 0)
-- Dependencies: 227
-- Name: organ_request_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.organ_request_id_seq', 2, true);


--
-- TOC entry 5147 (class 0 OID 0)
-- Dependencies: 235
-- Name: prescriptions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.prescriptions_id_seq', 1, true);


--
-- TOC entry 5148 (class 0 OID 0)
-- Dependencies: 237
-- Name: reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.reports_id_seq', 3, true);


--
-- TOC entry 4944 (class 2606 OID 49463)
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- TOC entry 4950 (class 2606 OID 49487)
-- Name: billing billing_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.billing
    ADD CONSTRAINT billing_pkey PRIMARY KEY (id);


--
-- TOC entry 4932 (class 2606 OID 41136)
-- Name: blood_donor blood_donor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_donor
    ADD CONSTRAINT blood_donor_pkey PRIMARY KEY (id);


--
-- TOC entry 4934 (class 2606 OID 41157)
-- Name: blood_request blood_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_request
    ADD CONSTRAINT blood_request_pkey PRIMARY KEY (id);


--
-- TOC entry 4942 (class 2606 OID 41211)
-- Name: health_blog health_blog_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.health_blog
    ADD CONSTRAINT health_blog_pkey PRIMARY KEY (id);


--
-- TOC entry 4940 (class 2606 OID 41201)
-- Name: hospitals hospitals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.hospitals
    ADD CONSTRAINT hospitals_pkey PRIMARY KEY (id);


--
-- TOC entry 4926 (class 2606 OID 41121)
-- Name: newusers newusers_email_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newusers
    ADD CONSTRAINT newusers_email_key UNIQUE (email);


--
-- TOC entry 4928 (class 2606 OID 41117)
-- Name: newusers newusers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newusers
    ADD CONSTRAINT newusers_pkey PRIMARY KEY (id);


--
-- TOC entry 4930 (class 2606 OID 41119)
-- Name: newusers newusers_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.newusers
    ADD CONSTRAINT newusers_username_key UNIQUE (username);


--
-- TOC entry 4936 (class 2606 OID 41172)
-- Name: organ_donor organ_donor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organ_donor
    ADD CONSTRAINT organ_donor_pkey PRIMARY KEY (id);


--
-- TOC entry 4938 (class 2606 OID 41193)
-- Name: organ_request organ_request_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organ_request
    ADD CONSTRAINT organ_request_pkey PRIMARY KEY (id);


--
-- TOC entry 4946 (class 2606 OID 49471)
-- Name: prescriptions prescriptions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.prescriptions
    ADD CONSTRAINT prescriptions_pkey PRIMARY KEY (id);


--
-- TOC entry 4948 (class 2606 OID 49479)
-- Name: reports reports_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.reports
    ADD CONSTRAINT reports_pkey PRIMARY KEY (id);


--
-- TOC entry 4951 (class 2606 OID 41137)
-- Name: blood_donor blood_donor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.blood_donor
    ADD CONSTRAINT blood_donor_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.newusers(id);


--
-- TOC entry 4952 (class 2606 OID 41173)
-- Name: organ_donor organ_donor_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.organ_donor
    ADD CONSTRAINT organ_donor_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.newusers(id);


-- Completed on 2026-06-17 10:48:45

--
-- PostgreSQL database dump complete
--

\unrestrict qYCHlauL9eUeeXdEvJqBckonbvreTn9k0aCnk2eMztUZapRG5yHYVJW1tfo3m34

