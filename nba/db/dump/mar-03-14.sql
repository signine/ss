--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

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
-- Name: players; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE players (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    bdate date,
    bplace character varying(50),
    wt integer,
    ht character varying(10),
    college character varying(50),
    draft_year integer,
    draft_round integer,
    draft_pick integer,
    draft_team character varying(50),
    espn_id integer
);


ALTER TABLE public.players OWNER TO postgres;

--
-- Name: players_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE players_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.players_id_seq OWNER TO postgres;

--
-- Name: players_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE players_id_seq OWNED BY players.id;


--
-- Name: standings; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE standings (
    id integer NOT NULL,
    team character varying(20) NOT NULL,
    season_year character varying(20) NOT NULL,
    season_type character varying(100) NOT NULL,
    team_conference character varying(100) NOT NULL,
    team_division character varying(100) NOT NULL,
    conf_rank integer NOT NULL,
    div_rank integer NOT NULL,
    wins integer NOT NULL,
    losses integer NOT NULL,
    pct double precision NOT NULL,
    won_champ boolean DEFAULT false
);


ALTER TABLE public.standings OWNER TO postgres;

--
-- Name: standings_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE standings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.standings_id_seq OWNER TO postgres;

--
-- Name: standings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE standings_id_seq OWNED BY standings.id;


--
-- Name: team; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE team (
    id integer NOT NULL,
    city character varying(100) NOT NULL,
    name character varying(100) NOT NULL,
    abbreviation character varying(20) NOT NULL,
    code character varying(100),
    min_year integer,
    max_year integer,
    nba_stats_id character varying(100)
);


ALTER TABLE public.team OWNER TO postgres;

--
-- Name: team_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE team_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_id_seq OWNER TO postgres;

--
-- Name: team_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE team_id_seq OWNED BY team.id;


--
-- Name: team_roster; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE team_roster (
    id integer NOT NULL,
    season character varying(20) NOT NULL,
    player_id character varying(50) NOT NULL,
    team character varying(50) NOT NULL,
    name character varying(100) NOT NULL,
    jersey integer,
    pos character varying(10),
    age integer,
    ht integer,
    wt integer,
    salary bigint
);


ALTER TABLE public.team_roster OWNER TO postgres;

--
-- Name: team_roster_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE team_roster_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_roster_id_seq OWNER TO postgres;

--
-- Name: team_roster_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE team_roster_id_seq OWNED BY team_roster.id;


--
-- Name: team_standings_timeline; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE team_standings_timeline (
    id integer NOT NULL,
    team character varying(20) NOT NULL,
    date timestamp without time zone DEFAULT now(),
    season_year character varying(20) NOT NULL,
    season_type character varying(100) NOT NULL,
    team_conference character varying(100) NOT NULL,
    team_division character varying(100) NOT NULL,
    conf_rank integer NOT NULL,
    div_rank integer NOT NULL,
    conf_wins integer,
    conf_losses integer,
    div_wins integer,
    div_losses integer,
    home_wins integer,
    home_losses integer,
    road_wins integer,
    road_losses integer,
    total_games integer,
    last_10_wins integer,
    last_10_losses integer,
    wins integer NOT NULL,
    losses integer NOT NULL,
    pct double precision NOT NULL,
    gb double precision,
    streak character varying(10)
);


ALTER TABLE public.team_standings_timeline OWNER TO postgres;

--
-- Name: team_standings_timeline_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE team_standings_timeline_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.team_standings_timeline_id_seq OWNER TO postgres;

--
-- Name: team_standings_timeline_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE team_standings_timeline_id_seq OWNED BY team_standings_timeline.id;


--
-- Name: test; Type: TABLE; Schema: public; Owner: postgres; Tablespace: 
--

CREATE TABLE test (
    ht character varying(10)
);


ALTER TABLE public.test OWNER TO postgres;

--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY players ALTER COLUMN id SET DEFAULT nextval('players_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY standings ALTER COLUMN id SET DEFAULT nextval('standings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY team ALTER COLUMN id SET DEFAULT nextval('team_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY team_roster ALTER COLUMN id SET DEFAULT nextval('team_roster_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY team_standings_timeline ALTER COLUMN id SET DEFAULT nextval('team_standings_timeline_id_seq'::regclass);


--
-- Data for Name: players; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY players (id, name, bdate, bplace, wt, ht, college, draft_year, draft_round, draft_pick, draft_team, espn_id) FROM stdin;
1	Pero Antic	1982-07-29	Jul 29, 1982	260	6'11	None	\N	\N	\N	\N	2585616
2	Elton Brand	1979-03-11	Cortland, NY	254	6'09	Duke	1999	1	1	CHI	91
3	Al Horford	1986-06-03	Dominican Republic	250	6'10	Florida	2007	1	3	ATL	3213
4	Kyle Korver	1981-03-17	Lakewood, CA	212	6'07	Creighton	2003	2	51	NJ	2011
5	Cartier Martin	1984-11-20	Crockett, TX	220	6'07	Kansas State	\N	\N	\N	\N	3930
6	Mike Muscala	1991-07-01	Jul 1, 1991	239	6'11	Bucknell	2013	2	44	DAL	2490089
7	Mike Scott	1988-07-16	Chesapeake, VA	237	6'08	Virginia	2012	2	43	ATL	6622
8	Louis Williams	1986-10-27	Lithonia, GA	175	6'01	None	2005	2	45	PHI	2799
9	Gustavo Ayon	1985-04-01	Mexico	250	6'10	None	\N	\N	\N	\N	6546
10	DeMarre Carroll	1986-07-27	Birmingham, AL	212	6'08	Missouri	2009	1	27	MEM	3970
11	John Jenkins	1991-03-06	Nashville, TN	215	6'04	Vanderbilt	2012	1	23	ATL	6594
12	Shelvin Mack	1990-04-22	Lexington, KY	207	6'03	Butler	2011	2	34	WSH	6454
13	Paul Millsap	1985-02-10	Monroe, LA	253	6'08	Louisiana Tech	2006	2	47	UTAH	3015
14	Dennis Schroder	1993-09-15	Germany	168	6'01	None	2013	1	17	ATL	3032979
15	Jeff Teague	1988-06-10	Indianapolis, IN	181	6'02	Wake Forest	2009	1	19	ATL	4015
16	Joel Anthony	1982-08-09	Canada	245	6'09	UNLV	\N	\N	\N	\N	3247
17	Brandon Bass	1985-04-30	Baton Rouge, LA	250	6'08	LSU	2005	2	33	NO	2745
18	Keith Bogans	1980-05-12	Washington, DC	215	6'05	Kentucky	2003	2	43	MIL	1995
19	Vitor Faverani	1988-05-05	Brazil	260	6'11	None	\N	\N	\N	\N	3046453
20	Kris Humphries	1985-02-06	Chaska, MN	235	6'09	Minnesota	2004	1	14	UTAH	2433
21	Kelly Olynyk	1991-04-19	Canada	238	7'00	Gonzaga	2013	1	13	DAL	2489663
22	Rajon Rondo	1986-02-22	Louisville, KY	186	6'01	Kentucky	2006	1	21	PHX	3026
23	Gerald Wallace	1982-07-23	Sylacauga, AL	220	6'07	Alabama	2001	1	25	SAC	1026
24	Chris Babb	1990-02-14	Wichita, KS	225	6'05	Iowa State	\N	\N	\N	\N	2326389
25	Jerryd Bayless	1988-08-20	Phoenix, AZ	200	6'03	Arizona	2008	1	11	IND	3417
26	Avery Bradley	1990-11-26	Tacoma, WA	180	6'02	Texas	2010	1	19	BOS	4240
27	Jeff Green	1986-08-28	Cheverly, MD	235	6'09	Georgetown	2007	1	5	BOS	3209
28	Chris Johnson	1990-04-29	Orlando, FL	201	6'06	Dayton	\N	\N	\N	\N	2325975
29	Phil Pressey	1991-02-17	Dallas, TX	175	5'11	Missouri	\N	\N	\N	\N	2530722
30	Jared Sullinger	1992-03-04	Columbus, OH	260	6'09	Ohio State	2012	1	21	BOS	6624
31	Anthony Bennett	1993-03-14	Canada	259	6'08	UNLV	2013	1	1	CLE	2991473
32	Luol Deng	1985-04-16	Sudan	220	6'09	Duke	2004	1	7	PHX	2429
33	Alonzo Gee	1987-05-29	Riviera Beach, FL	225	6'06	Alabama	\N	\N	\N	\N	4232
34	Kyrie Irving	1992-03-23	Australia	193	6'03	Duke	2011	1	1	CLE	6442
35	Sergey Karasev	1993-10-26	Russia	196	6'07	None	2013	1	19	CLE	2959745
36	Arinze Onuaku	1987-07-13	Lanham, MD	275	6'09	Syracuse	\N	\N	\N	\N	2202117
37	Anderson Varejao	1982-09-28	Brazil	267	6'11	None	2004	2	30	ORL	2419
38	Tyler Zeller	1990-01-17	Visalia, CA	253	7'00	North Carolina	2012	1	17	DAL	6631
39	Matthew Dellavedova	1990-09-08	Australia	200	6'04	Saint Mary's	\N	\N	\N	\N	2489716
40	Carrick Felix	1990-08-17	Las Vegas, NV	201	6'06	Arizona State	2013	2	33	CLE	2531185
41	Spencer Hawes	1988-04-28	Seattle, WA	245	7'01	Washington	2007	1	10	SAC	3211
42	Jarrett Jack	1983-10-28	Fort Washington, MD	200	6'03	Georgia Tech	2005	1	22	DEN	2768
43	C.J. Miles	1987-03-18	Dallas, TX	231	6'06	None	2005	2	34	UTAH	2778
44	Tristan Thompson	1991-03-13	Canada	238	6'09	Texas	2011	1	4	CLE	6474
45	Dion Waiters	1991-12-10	Philadelphia, PA	225	6'04	Syracuse	2012	1	4	CLE	6628
46	D.J. Augustin	1987-11-10	New Orleans, LA	183	6'00	Texas	2008	1	9	CHA	3415
47	Jimmy Butler	1989-09-14	Houston, TX	220	6'07	Marquette	2011	1	30	CHI	6430
48	Jimmer Fredette	1989-02-25	Glens Falls, NY	195	6'02	Brigham Young	2011	1	10	MIL	6434
49	Kirk Hinrich	1981-01-02	Sioux City, IA	190	6'04	Kansas	2003	1	7	CHI	1981
50	Erik Murphy	1990-10-26	South Kingstown, RI	230	6'10	Florida	2013	2	49	CHI	2489021
51	Derrick Rose	1988-10-04	Chicago, IL	190	6'03	Memphis	2008	1	1	CHI	3456
52	Tony Snell	1991-11-10	Riverside, CA	200	6'07	New Mexico	2013	1	20	CHI	2528353
53	Carlos Boozer	1981-11-20	Nov 20, 1981	266	6'09	Duke	2002	2	35	CLE	1703
54	Mike Dunleavy	1980-09-15	Fort Worth, TX	230	6'09	Duke	2002	1	3	GS	1708
55	Taj Gibson	1985-06-24	Brooklyn, NY	225	6'09	USC	2009	1	26	CHI	3986
56	Nazr Mohammed	1977-09-05	Chicago, IL	250	6'10	Kentucky	1998	1	29	UTAH	568
57	Joakim Noah	1985-02-25	New York, NY	232	6'11	Florida	2007	1	9	CHI	3224
58	Tornike Shengelia	1991-10-05	Oct 5, 1991	220	6'09	None	2012	2	54	PHI	6623
59	DeJuan Blair	1989-04-22	Pittsburgh, PA	270	6'07	Pittsburgh	2009	2	37	SA	3965
60	Vince Carter	1977-01-26	Daytona Beach, FL	220	6'06	North Carolina	1998	1	5	GS	136
61	Samuel Dalembert	1981-05-10	Haiti	250	6'11	Seton Hall	2001	1	26	PHI	991
62	Monta Ellis	1985-10-26	Jackson, MS	185	6'03	None	2005	2	40	GS	2751
63	Bernard James	1985-02-07	Savannah, GA	240	6'10	Florida State	2012	2	33	CLE	6593
64	Ricky Ledo	1992-09-10	Providence, RI	195	6'07	Providence	2013	2	43	MIL	2991143
65	Gal Mekel	1988-03-04	Israel	191	6'03	Wichita State	\N	\N	\N	\N	4218
66	Brandan Wright	1987-10-05	Nashville, TN	210	6'10	North Carolina	2007	1	8	CHA	3242
67	Jose Calderon	1981-09-28	Spain	211	6'03	None	\N	\N	\N	\N	2806
68	Jae Crowder	1990-07-06	Villa Rica, GA	235	6'06	Marquette	2012	2	34	CLE	6581
69	Wayne Ellington	1987-11-29	Wynnewood, PA	200	6'04	North Carolina	2009	1	28	MIN	3981
70	Devin Harris	1983-02-27	Milwaukee, WI	192	6'03	Wisconsin	2004	1	5	WSH	2382
71	Shane Larkin	1992-10-02	Cincinnati, OH	176	5'11	Miami (FL)	2013	1	18	ATL	2596158
72	Shawn Marion	1978-05-07	Chicago, IL	228	6'07	UNLV	1999	1	9	PHX	510
73	Dirk Nowitzki	1978-06-19	Jun 19, 1978	245	7'00	None	1998	1	9	MIL	609
74	Darrell Arthur	1988-03-25	Dallas, TX	235	6'09	Kansas	2008	1	27	NO	3413
75	Wilson Chandler	1987-05-10	Benton Harbor, MI	225	6'08	DePaul	2007	1	23	NY	3194
76	Evan Fournier	1992-10-29	France	200	6'06	None	2012	1	20	DEN	6588
77	Danilo Gallinari	1988-08-08	Italy	225	6'10	None	2008	1	6	NY	3428
78	Ty Lawson	1987-11-03	Clinton, MD	195	5'11	North Carolina	2009	1	18	MIN	4000
79	Quincy Miller	1992-11-18	North Chicago, IL	210	6'09	Baylor	2012	2	38	DEN	6611
80	Anthony Randolph	1989-07-15	Jul 15, 1989	225	6'11	LSU	2008	1	14	GS	3455
81	Jan Vesely	1990-04-24	Apr 24, 1990	242	7'00	None	2011	1	6	WSH	4165
82	Aaron Brooks	1985-01-14	Seattle, WA	161	6'00	Oregon	2007	1	26	HOU	3192
83	Kenneth Faried	1989-11-19	Newark, NJ	228	6'08	Morehead State	2011	1	22	DEN	6433
84	Randy Foye	1983-09-24	Newark, NJ	213	6'04	Villanova	2006	1	7	BOS	3003
85	J.J. Hickson	1988-09-04	Atlanta, GA	242	6'09	North Carolina State	2008	1	19	CLE	3437
86	JaVale McGee	1988-01-19	Flint, MI	250	7'00	Nevada	2008	1	18	WSH	3452
87	Timofey Mozgov	1986-07-16	Jul 16, 1986	250	7'01	None	\N	\N	\N	\N	4298
88	Nate Robinson	1984-05-31	Seattle, WA	180	5'09	Washington	2005	1	21	PHX	2782
89	Hilton Armstrong	1984-11-23	Peekskill, NY	235	6'11	Connecticut	2006	1	12	NO	2984
90	Steve Blake	1980-02-26	Hollywood, FL	172	6'03	Maryland	2003	2	38	WSH	1994
91	Jordan Crawford	1988-10-23	Detroit, MI	195	6'04	Xavier	2010	1	27	NJ	4243
92	Festus Ezeli	1989-10-21	Nigeria	255	6'11	Vanderbilt	2012	1	30	GS	6587
93	Andre Iguodala	1984-01-28	Springfield, IL	207	6'06	Arizona	2004	1	9	PHI	2386
94	David Lee	1983-04-29	Apr 29, 1983	240	6'09	Florida	2005	1	30	NY	2772
95	Jermaine O'Neal	1978-10-13	Columbia, SC	255	6'11	None	1996	1	17	POR	615
96	Klay Thompson	1990-02-08	Los Angeles, CA	205	6'07	Washington State	2011	1	11	GS	6475
97	Harrison Barnes	1992-05-30	Ames, IA	210	6'08	North Carolina	2012	1	7	GS	6578
98	Andrew Bogut	1984-11-28	Australia	260	7'00	Utah	2005	1	1	MIL	2747
99	Stephen Curry	1988-03-14	Charlotte, NC	185	6'03	Davidson	2009	1	7	GS	3975
100	Draymond Green	1990-03-04	Saginaw, MI	230	6'07	Michigan State	2012	2	35	GS	6589
101	Ognjen Kuzmic	1990-05-16	Yugoslavia	251	7'00	None	2012	2	52	GS	6602
102	Nemanja Nedovic	1991-06-16	Yugoslavia	192	6'03	None	2013	1	30	PHX	2959736
103	Marreese Speights	1987-08-04	Aug 4, 1987	255	6'10	Florida	2008	1	16	PHI	3460
104	Omer Asik	1986-07-04	Turkey	255	7'00	None	2008	2	36	POR	3414
105	Isaiah Canaan	1991-05-21	Biloxi, MS	188	6'00	Murray State	2013	2	34	HOU	2490589
106	Robert Covington	1990-12-14	Bellwood, IL	215	6'09	Tennessee State	\N	\N	\N	\N	2490620
107	Francisco Garcia	1980-12-31	Dominican Republic	195	6'07	Louisville	2005	1	23	SAC	2755
108	James Harden	1989-08-26	Bellflower, CA	220	6'05	Arizona State	2009	1	3	OKC	3992
109	Terrence Jones	1992-01-09	Portland, OR	252	6'09	Kentucky	2012	1	18	HOU	6597
110	Donatas Motiejunas	1990-09-20	Lithuania	222	7'00	None	2011	1	20	MIN	6464
111	Greg Smith	1991-01-08	Vallejo, CA	250	6'10	Fresno State	\N	\N	\N	\N	6530
112	Patrick Beverley	1988-07-12	Chicago, IL	185	6'01	Arkansas	2009	2	42	LAL	3964
113	Omri Casspi	1988-06-22	Israel	225	6'09	None	2009	1	23	SAC	3554
114	Troy Daniels	1991-07-15	Roanoke, VA	204	6'04	Virginia Commonwealth	\N	\N	\N	\N	2489530
115	Jordan Hamilton	1990-10-06	Los Angeles, CA	220	6'07	Texas	2011	1	26	DAL	6436
116	Dwight Howard	1985-12-08	Atlanta, GA	265	6'11	None	2004	1	1	ORL	2384
117	Jeremy Lin	1988-08-23	Palo Alto, CA	200	6'03	Harvard	\N	\N	\N	\N	4299
118	Chandler Parsons	1988-10-25	Casselberry, FL	227	6'09	Florida	2011	2	38	HOU	6466
119	Matt Barnes	1980-03-09	Santa Clara, CA	226	6'07	UCLA	2002	2	46	MEM	1765
120	Darren Collison	1987-08-23	Rancho Cucamonga, CA	175	6'00	UCLA	2009	1	21	NO	3973
121	Glen Davis	1986-01-01	Baton Rouge, LA	289	6'09	LSU	2007	2	35	SEA	3200
122	Danny Granger	1983-04-20	New Orleans, LA	228	6'09	New Mexico	2005	1	17	IND	2760
123	Blake Griffin	1989-03-16	Oklahoma City, OK	251	6'10	Oklahoma	2009	1	1	LAC	3989
124	DeAndre Jordan	1988-07-21	Houston, TX	265	6'11	Texas A&M	2008	2	35	LAC	3442
125	J.J. Redick	1984-06-24	Cookeville, TN	190	6'04	Duke	2006	1	11	ORL	3024
126	Reggie Bullock	1991-03-16	Baltimore, MD	205	6'07	North Carolina	2013	1	25	LAC	2528779
127	Jamal Crawford	1980-03-20	Seattle, WA	200	6'05	Michigan	2000	1	8	CLE	165
128	Jared Dudley	1985-07-10	San Diego, CA	225	6'07	Boston 	2007	1	22	CHA	3201
129	Willie Green	1981-07-28	Detroit, MI	201	6'03	Detroit	2003	2	41	SEA	2004
130	Ryan Hollins	1984-10-10	Pasadena, CA	240	7'00	UCLA	2006	2	50	CHA	3008
131	Chris Paul	1985-05-06	Winston-salem, NC	175	6'00	Wake Forest	2005	1	4	NO	2779
132	Hedo Turkoglu	1979-03-19	Turkey	220	6'10	None	2000	1	16	SAC	862
133	Kent Bazemore	1989-07-01	Kelford, NC	201	6'05	Old Dominion	\N	\N	\N	\N	6637
134	Kobe Bryant	1978-08-23	Philadelphia, PA	205	6'06	None	1996	1	13	CHA	110
135	Pau Gasol	1980-07-06	Spain	250	7'00	None	2001	1	3	ATL	996
136	Jordan Hill	1987-07-27	Newberry, SC	235	6'10	Arizona	2009	1	8	NY	3994
137	Chris Kaman	1982-04-28	Grand Rapids, MI	265	7'00	Central Michigan	2003	1	6	LAC	1982
138	Kendall Marshall	1991-08-19	Dumfries, VA	195	6'04	North Carolina	2012	1	13	PHX	6607
139	Steve Nash	1974-02-07	South Africa	178	6'03	Santa Clara	1996	1	15	PHX	592
140	Nick Young	1985-06-01	Los Angeles, CA	210	6'07	USC	2007	1	16	WSH	3243
141	MarShon Brooks	1989-01-26	Long Branch, NJ	200	6'05	Providence	2011	1	25	BOS	6428
142	Jordan Farmar	1986-11-30	Los Angeles, CA	180	6'02	UCLA	2006	1	26	LAL	3002
143	Xavier Henry	1991-03-15	Belgium	220	6'06	Kansas	2010	1	12	MEM	4241
144	Wesley Johnson	1987-07-11	Corsicana, TX	215	6'07	Syracuse	2010	1	4	MIN	4247
145	Ryan Kelly	1991-04-09	Carmel, NY	230	6'11	Duke	2013	2	48	LAL	2488651
146	Jodie Meeks	1987-08-21	Nashville, TN	208	6'04	Kentucky	2009	2	41	MIL	4003
147	Robert Sacre	1989-06-06	Baton Rouge, LA	260	7'00	Gonzaga	2012	2	60	LAL	6620
148	Ray Allen	1975-07-20	Merced, CA	205	6'05	Connecticut	1996	1	5	MIN	9
149	Shane Battier	1978-09-09	Birmingham, MI	220	6'08	Duke	2001	1	6	VAN	976
150	Chris Bosh	1984-03-24	Dallas, TX	235	6'11	Georgia Tech	2003	1	4	TOR	1977
151	Norris Cole	1988-10-13	Dayton, OH	175	6'02	Cleveland State	2011	1	28	CHI	6431
152	Udonis Haslem	1980-06-09	Miami, FL	235	6'08	Florida	\N	\N	\N	\N	2184
153	James Jones	1980-10-04	Miami, FL	215	6'08	Miami (FL)	2003	2	49	IND	2009
154	DeAndre Liggins	1988-03-31	Chicago, IL	209	6'06	Kentucky	2011	2	53	ORL	6453
155	Dwyane Wade	1982-01-17	Chicago, IL	220	6'04	Marquette	2003	1	5	MIA	1987
156	Chris Andersen	1978-07-07	Iola, TX	245	6'10	Blinn 	\N	\N	\N	\N	1135
157	Michael Beasley	1989-01-09	Frederick, MD	235	6'10	Kansas State	2008	1	2	MIA	3418
158	Mario Chalmers	1986-05-19	Anchorage, AK	190	6'02	Kansas	2008	2	34	MIN	3419
159	Toney Douglas	1986-03-16	Tampa, FL	185	6'02	Florida State	2009	1	29	LAL	3979
160	LeBron James	1984-12-30	Akron, OH	250	6'08	None	2003	1	1	CLE	1966
161	Rashard Lewis	1979-08-08	Pineville, LA	235	6'10	None	1998	2	32	SEA	469
162	Greg Oden	1988-01-22	Buffalo, NY	273	7'00	Ohio State	2007	1	1	POR	3225
163	Jeff Adrien	1986-02-10	Brookline, MA	245	6'07	Connecticut	\N	\N	\N	\N	4335
164	Carlos Delfino	1982-08-29	Argentina	230	6'06	None	2003	1	25	DET	1999
165	Ersan Ilyasova	1987-05-15	Turkey	235	6'10	None	2005	2	36	MIL	2767
166	O.J. Mayo	1987-11-05	Huntington, WV	210	6'04	USC	2008	1	3	MIN	3450
167	Zaza Pachulia	1984-02-10	Feb 10, 1984	275	6'11	None	2003	2	42	ORL	2016
168	Larry Sanders	1988-11-21	Fort Pierce, FL	235	6'11	Virginia Commonwealth	2010	1	15	MIL	4265
169	Ekpe Udoh	1987-05-20	Edmond, OK	245	6'10	Baylor	2010	1	6	GS	4261
170	Giannis Antetokounmpo	1994-12-06	Greece	205	6'09	None	2013	1	15	MIL	3032977
171	John Henson	1990-12-28	Greensboro, NC	220	6'11	North Carolina	2012	1	14	MIL	6592
172	Brandon Knight	1991-12-02	Miami, FL	189	6'03	Kentucky	2011	1	8	DET	6448
173	Khris Middleton	1991-08-12	Charleston, SC	217	6'08	Texas A&M	2012	2	39	DET	6609
174	Miroslav Raduljica	1988-01-05	Jan 5, 1988	250	7'00	None	\N	\N	\N	\N	3047256
175	Ramon Sessions	1986-04-11	Myrtle Beach, SC	190	6'03	Nevada	2007	2	56	MIL	3231
176	Nate Wolters	1991-05-15	May 15, 1991	190	6'04	South Dakota State	2013	2	38	WSH	2491079
177	J.J. Barea	1984-06-26	Puerto Rico	178	6'00	Northeastern	\N	\N	\N	\N	3055
178	Chase Budinger	1988-05-22	La Jolla, CA	209	6'07	Arizona	2009	2	44	DET	3968
179	Gorgui Dieng	1990-01-18	Senegal	238	6'11	Louisville	2013	1	21	UTAH	2534781
180	Kevin Love	1988-09-07	Santa Monica, CA	243	6'10	UCLA	2008	1	5	MEM	3449
181	Luc Richard Mbah a Moute	1986-09-09	Cameroon	230	6'08	UCLA	2008	2	37	MIL	3451
182	Nikola Pekovic	1986-01-03	Yugoslavia	285	6'11	None	2008	2	31	MIN	3453
183	Ricky Rubio	1990-10-21	Spain	185	6'04	None	2009	1	5	MIN	4011
184	Ronny Turiaf	1983-01-13	Jan 13, 1983	241	6'10	Gonzaga	2005	2	37	LAL	2789
185	Corey Brewer	1986-03-05	Portland, TN	185	6'09	Florida	2007	1	7	MIN	3191
186	Dante Cunningham	1987-04-22	Clinton, MD	221	6'08	Villanova	2009	2	33	POR	3974
187	Robbie Hummel	1989-03-08	Valparaiso, IN	220	6'08	Purdue	2012	2	58	MIN	6633
188	Kevin Martin	1983-02-01	Zanesville, OH	197	6'07	Western Carolina	2004	1	26	SAC	2394
189	Shabazz Muhammad	1992-11-13	Los Angeles, CA	222	6'06	UCLA	2013	1	14	UTAH	2993875
190	A.J. Price	1986-10-07	Orange, NJ	195	6'02	Connecticut	2009	2	52	IND	4010
191	Alexey Shved	1988-12-16	Dec 16, 1988	187	6'06	None	\N	\N	\N	\N	3882
192	Alan Anderson	1982-10-16	Minneapolis, MN	220	6'06	Michigan State	\N	\N	\N	\N	6569
193	Jason Collins	1978-12-02	Northridge, CA	255	7'00	Stanford	2001	1	18	HOU	987
194	Joe Johnson	1981-06-29	Little Rock, AR	240	6'07	Arkansas	2001	1	10	BOS	1007
195	Shaun Livingston	1985-09-11	Peoria, IL	175	6'07	None	2004	1	4	LAC	2393
196	Paul Pierce	1977-10-13	Oakland, CA	235	6'07	Kansas	1998	1	10	BOS	662
197	Marquis Teague	1993-02-28	Indianapolis, IN	190	6'02	Kentucky	2012	1	29	CHI	6626
198	Marcus Thornton	1987-06-05	Baton Rouge, LA	205	6'04	LSU	2009	2	43	MIA	4017
199	Andray Blatche	1986-08-22	Syracuse, NY	260	6'11	None	2005	2	49	WSH	2746
200	Kevin Garnett	1976-05-19	Mauldin, SC	253	6'11	None	1995	1	5	MIN	261
201	Andrei Kirilenko	1981-02-18	Feb 18, 1981	235	6'09	None	1999	1	24	UTAH	434
202	Brook Lopez	1988-04-01	North Hollywood, CA	275	7'00	Stanford	2008	1	10	NJ	3448
203	Mason Plumlee	1990-03-05	Fort Wayne, IN	235	6'11	Duke	2013	1	22	BKN	2488653
204	Mirza Teletovic	1985-09-17	Yugoslavia	242	6'09	None	\N	\N	\N	\N	4385
205	Deron Williams	1984-06-26	Parkersburg, WV	209	6'03	Illinois	2005	1	3	UTAH	2798
206	Cole Aldrich	1988-10-31	Burnsville, MN	245	6'11	Kansas	2010	1	11	NO	4267
207	Andrea Bargnani	1985-10-26	Italy	250	7'00	None	2006	1	1	TOR	2987
208	Tyson Chandler	1982-10-02	Hanford, CA	240	7'01	None	2001	1	2	LAC	984
209	Raymond Felton	1984-06-26	Marion, SC	205	6'01	North Carolina	2005	1	5	CHA	2753
210	Kenyon Martin	1977-12-30	Saginaw, MI	225	6'09	Cincinnati	2000	1	1	NJ	515
211	Pablo Prigioni	1977-03-17	Argentina	185	6'03	None	\N	\N	\N	\N	4182
212	J.R. Smith	1985-09-09	Freehold, NJ	220	6'06	None	2004	1	18	NO	2444
213	Jeremy Tyler	1991-06-12	San Diego, CA	250	6'10	None	2011	2	39	CHA	6476
214	Carmelo Anthony	1984-05-29	New York, NY	235	6'08	Syracuse	2003	1	3	DEN	1975
215	Shannon Brown	1985-11-29	Maywood, IL	210	6'04	Michigan State	2006	1	25	CLE	2992
216	Earl Clark	1988-01-17	Newark, NJ	234	6'10	Louisville	2009	1	14	PHX	3971
217	Tim Hardaway Jr.	1992-03-16	Miami, FL	205	6'06	Michigan	2013	1	24	NY	2528210
218	Toure' Murry	1989-11-08	USA	195	6'05	Wichita State	\N	\N	\N	\N	2327107
219	Iman Shumpert	1990-06-26	Oak Park, IL	220	6'05	Georgia Tech	2011	1	17	NY	6468
220	Amar'e Stoudemire	1982-11-16	Lake Wales, FL	245	6'11	None	2002	1	9	PHX	1727
221	Arron Afflalo	1985-10-15	Los Angeles, CA	215	6'05	UCLA	2007	1	27	DET	3187
222	Maurice Harkless	1993-05-11	Queens, NY	220	6'09	St. John's	2012	1	15	PHI	6591
223	Doron Lamb	1991-11-06	Queens, NY	200	6'04	Kentucky	2012	2	42	MIL	6604
224	E'Twaun Moore	1989-02-25	East Chicago, IN	191	6'04	Purdue	2011	2	55	BOS	6460
225	Andrew Nicholson	1989-12-08	Canada	250	6'09	St. Bonaventure	2012	1	19	ORL	6614
226	Victor Oladipo	1992-05-04	Silver Spring, MD	215	6'04	Indiana	2013	1	2	ORL	2527963
227	Adonis Thomas	1993-03-25	Mar 25, 1993	240	6'07	Memphis	\N	\N	\N	\N	2595274
228	Dewayne Dedmon	1989-08-12	Lancaster, CA	255	7'00	USC	\N	\N	\N	\N	2580913
229	Tobias Harris	1992-07-15	Islip, NY	235	6'09	Tennessee	2011	1	19	CHA	6440
230	Jason Maxiell	1983-02-18	Chicago, IL	260	6'07	Cincinnati	2005	1	26	DET	2775
231	Jameer Nelson	1982-02-09	Chester, PA	190	6'00	Saint Joseph's	2004	1	20	DEN	2439
232	Kyle O'Quinn	1990-03-26	Queens, NY	250	6'10	Norfolk State	2012	2	49	ORL	6615
233	Ronnie Price	1983-06-21	Friendswood, TX	190	6'02	Utah Valley	\N	\N	\N	\N	2807
234	Nikola Vucevic	1990-10-24	Switzerland	250	7'00	USC	2011	1	16	PHI	6478
235	Lavoy Allen	1989-02-04	Morrisville, PA	255	6'09	Temple	2011	2	50	PHI	6424
236	Andrew Bynum	1987-10-27	Plainsboro, NJ	285	7'00	None	2005	1	10	LAL	2748
237	Paul George	1990-05-02	Palmdale, CA	220	6'09	Fresno State	2010	1	10	IND	4251
238	George Hill	1986-05-04	Indianapolis, IN	188	6'03	IUPUI	2008	1	26	SA	3438
239	Ian Mahinmi	1986-11-05	France	250	6'11	None	2005	1	28	SA	2774
240	Donald Sloan	1988-01-15	Shreveport, LA	205	6'03	Texas A&M	\N	\N	\N	\N	4303
241	Evan Turner	1988-10-27	Chicago, IL	220	6'07	Ohio State	2010	1	2	PHI	4239
242	David West	1980-08-29	Teaneck, NJ	250	6'09	Xavier	2003	1	18	NO	2177
243	Rasual Butler	1979-05-23	Philadelphia, PA	215	6'07	La Salle	2002	2	53	MIA	1767
244	Chris Copeland	1984-03-17	Orange, NJ	235	6'08	Colorado	\N	\N	\N	\N	6635
245	Roy Hibbert	1986-12-11	Queens, NY	290	7'02	Georgetown	2008	1	17	TOR	3436
246	Solomon Hill	1991-03-18	Los Angeles, CA	225	6'07	Arizona	2013	1	23	IND	2488958
247	Luis Scola	1980-04-30	Argentina	240	6'09	None	2002	2	56	SA	1781
248	Lance Stephenson	1990-09-05	Brooklyn, NY	230	6'05	Cincinnati	2010	2	40	IND	4244
249	C.J. Watson	1984-04-17	Las Vegas, NV	175	6'02	Tennessee	\N	\N	\N	\N	3277
250	James Anderson	1989-03-25	El Dorado, AR	210	6'06	Oklahoma State	2010	1	20	SA	4242
251	Michael Carter-Williams	1991-10-10	Hamilton, MA	185	6'06	Syracuse	2013	1	11	PHI	2596108
252	Eric Maynor	1987-06-11	Raeford, NC	175	6'03	Virginia Commonwealth	2009	1	20	UTAH	4001
253	Byron Mullens	1989-02-14	Columbus, OH	275	7'00	Ohio State	2009	1	24	DAL	4005
254	Jason Richardson	1981-01-20	Saginaw, MI	225	6'06	Michigan State	2001	1	5	GS	1018
255	Hollis Thompson	1991-04-03	Los Angeles, CA	206	6'08	Georgetown	\N	\N	\N	\N	6634
256	Elliot Williams	1989-06-20	Memphis, TN	180	6'05	Memphis	2010	1	22	POR	4294
257	Thaddeus Young	1988-06-21	New Orleans, LA	230	6'08	Georgia Tech	2007	1	12	PHI	3244
258	Lorenzo Brown	1990-08-26	Rockford, IL	195	6'05	North Carolina State	2013	2	52	MIN	2528787
259	Brandon Davies	1991-07-25	Philadelphia, PA	240	6'10	Brigham Young	\N	\N	\N	\N	2490144
260	Arnett Moultrie	1990-11-18	Queens, NY	240	6'10	Mississippi State	2012	1	27	MIA	6612
261	Nerlens Noel	1994-04-10	Malden, MA	228	6'11	Kentucky	2013	1	6	NO	2991280
262	Henry Sims	1990-03-27	Baltimore, MD	248	6'10	Georgetown	\N	\N	\N	\N	6647
263	Jarvis Varnado	1988-03-01	Fairfax, VA	230	6'09	Mississippi State	2010	2	41	MIA	4266
264	Tony Wroten	1993-04-13	Seattle, WA	205	6'06	Washington	2012	1	25	MEM	6630
265	Leandro Barbosa	1982-11-28	Brazil	194	6'03	None	2003	1	28	SA	2166
266	Dionte Christmas	1986-09-15	Philadelphia, PA	205	6'05	Temple	\N	\N	\N	\N	4025
267	Channing Frye	1983-05-17	White Plains, NY	245	6'11	Arizona	2005	1	8	NY	2754
268	Gerald Green	1986-01-26	Houston, TX	210	6'08	None	2005	1	18	BOS	2761
269	Marcus Morris	1989-09-02	Philadelphia, PA	235	6'09	Kansas	2011	1	14	HOU	6462
270	Emeka Okafor	1982-09-28	Houston, TX	255	6'10	Connecticut	2004	1	2	CHA	2399
271	Shavlik Randolph	1983-11-24	Raleigh, NC	236	6'10	Duke	\N	\N	\N	\N	2810
272	P.J. Tucker	1985-05-05	Raleigh, NC	224	6'06	Texas	2006	2	35	TOR	3033
273	Eric Bledsoe	1989-12-09	Birmingham, AL	195	6'01	Kentucky	2010	1	18	OKC	4238
274	Goran Dragic	1986-05-06	Yugoslavia	190	6'03	None	2008	2	45	SA	3423
275	Archie Goodwin	1994-08-17	Little Rock, AR	198	6'05	Kentucky	2013	1	29	OKC	2991281
276	Alex Len	1993-06-16	Ukraine	255	7'01	Maryland	2013	1	5	PHX	2596107
277	Markieff Morris	1989-09-02	Philadelphia, PA	245	6'10	Kansas	2011	1	13	PHX	6461
278	Miles Plumlee	1988-09-01	Fort Wayne, IN	255	6'11	Duke	2012	1	26	IND	6616
279	Ish Smith	1988-07-05	Charlotte, NC	175	6'00	Wake Forest	\N	\N	\N	\N	4305
280	LaMarcus Aldridge	1985-07-19	Dallas, TX	240	6'11	Texas	2006	1	2	CHI	2983
281	Nicolas Batum	1988-12-14	France	200	6'08	None	2008	1	25	HOU	3416
282	Allen Crabbe	1992-04-09	Los Angeles, CA	210	6'06	California	2013	2	31	CLE	2531210
283	Meyers Leonard	1992-02-27	Woodbridge, VA	245	7'01	Illinois	2012	1	11	POR	6605
284	Robin Lopez	1988-04-01	North Hollywood, CA	255	7'00	Stanford	2008	1	15	PHX	3447
285	C.J. McCollum	1991-09-19	Canton, OH	200	6'04	Lehigh	2013	1	10	POR	2490149
286	Earl Watson	1979-06-12	Kansas City, KS	199	6'01	UCLA	2001	2	40	SEA	1027
287	Dorell Wright	1985-12-02	Los Angeles, CA	205	6'09	None	2004	1	19	MIA	2423
288	Will Barton	1991-01-06	Baltimore, MD	175	6'06	Memphis	2012	2	40	POR	6579
289	Victor Claver	1988-08-30	Spain	224	6'09	None	2009	1	22	POR	3972
290	Joel Freeland	1987-02-07	England	225	6'10	None	2006	1	30	POR	3004
291	Damian Lillard	1990-07-05	Oakland, CA	195	6'03	Weber State	2012	1	6	POR	6606
292	Wesley Matthews	1986-10-14	San Antonio, TX	220	6'05	Marquette	\N	\N	\N	\N	4032
293	Thomas Robinson	1991-03-18	Washington, DC	237	6'10	Kansas	2012	1	5	SAC	6618
294	Mo Williams	1982-12-19	Jackson, MS	195	6'01	Alabama	2003	2	47	UTAH	2178
295	Quincy Acy	1990-10-06	Tyler, TX	225	6'07	Baylor	2012	2	37	TOR	6576
296	Reggie Evans	1980-05-18	Pensacola, FL	245	6'08	Iowa	\N	\N	\N	\N	1828
297	Aaron Gray	1984-12-07	Tarzana, CA	270	7'00	Pittsburgh	2007	2	49	CHI	3207
298	Carl Landry	1983-09-19	Milwaukee, WI	248	6'09	Purdue	2007	2	31	SEA	3217
299	Ben McLemore	1993-02-11	Feb 11, 1993	195	6'05	Kansas	2013	1	7	SAC	2578213
300	Jason Terry	1977-09-15	Seattle, WA	180	6'02	Arizona	1999	1	10	ATL	841
301	Jason Thompson	1986-07-21	Camden, NJ	250	6'11	Rider	2008	1	12	SAC	3462
302	DeMarcus Cousins	1990-08-13	Mobile, AL	270	6'11	Kentucky	2010	1	5	SAC	4258
303	Rudy Gay	1986-08-17	Baltimore, MD	230	6'08	Connecticut	2006	1	8	HOU	3005
304	Orlando Johnson	1989-03-11	Monterey, CA	220	6'05	UC Santa Barbara	2012	2	36	SAC	6595
305	Ray McCallum	1991-06-12	Madison, WI	190	6'03	Detroit	2013	2	36	SAC	2528447
306	Travis Outlaw	1984-09-18	Starkville, MS	207	6'09	None	2003	1	23	POR	2015
307	Isaiah Thomas	1989-02-07	Tacoma, WA	185	5'09	Washington	2011	2	60	SAC	6472
308	Derrick Williams	1991-05-25	Bellflower, CA	240	6'08	Arizona	2011	1	2	MIN	6480
309	Jeff Ayres	1987-04-29	Ontario, CA	250	6'09	Arizona State	2009	2	31	SAC	4008
310	Marco Belinelli	1986-03-25	Italy	210	6'05	None	2007	1	18	GS	3190
311	Austin Daye	1988-06-05	Irvine, CA	200	6'11	Gonzaga	2009	1	15	DET	3976
312	Tim Duncan	1976-04-25	Virgin Islands	250	6'11	Wake Forest	1997	1	1	SA	215
313	Danny Green	1987-06-22	New York, NY	215	6'06	North Carolina	2009	2	46	CLE	3988
392	Al Harrington	1980-02-17	Orange, NJ	245	6'09	None	1998	1	25	IND	308
314	Kawhi Leonard	1991-06-29	Los Angeles, CA	230	6'07	San Diego State	2011	1	15	IND	6450
315	Tony Parker	1982-05-17	Belgium	185	6'02	None	2001	1	28	SA	1015
316	Aron Baynes	1986-12-09	New Zealand	260	6'10	Washington State	\N	\N	\N	\N	2968439
317	Matt Bonner	1980-04-05	Concord, NH	235	6'10	Florida	2003	2	45	CHI	1996
318	Boris Diaw	1982-04-16	France	250	6'08	None	2003	1	21	ATL	2167
319	Manu Ginobili	1977-07-28	Argentina	205	6'06	None	1999	2	57	SA	272
320	Cory Joseph	1991-08-20	Canada	190	6'03	Texas	2011	1	29	SA	6446
321	Patty Mills	1988-08-11	Australia	185	6'00	Saint Mary's	2009	2	55	POR	4004
322	Tiago Splitter	1985-01-01	Brazil	245	6'11	None	2007	1	28	SA	3233
323	Steven Adams	1993-07-20	New Zealand	255	7'00	Pittsburgh	2013	1	12	OKC	2991235
324	Nick Collison	1980-10-26	Orange City, IA	255	6'10	Kansas	2003	1	12	SEA	1978
325	Derek Fisher	1974-08-09	Little Rock, AR	210	6'01	Arkansas-Little Rock	1996	1	24	LAL	246
326	Reggie Jackson	1990-04-16	Italy	208	6'03	Boston 	2011	1	24	OKC	6443
327	Jeremy Lamb	1992-05-30	May 30, 1992	185	6'05	Connecticut	2012	1	12	HOU	6603
328	Andre Roberson	1991-12-04	Las Cruces, NM	210	6'07	Colorado	2013	1	26	MIN	2530596
329	Hasheem Thabeet	1987-02-16	Feb 16, 1987	263	7'03	Connecticut	2009	1	2	MEM	4016
330	Caron Butler	1980-03-13	Racine, WI	228	6'07	Connecticut	2002	1	10	MIA	1705
331	Kevin Durant	1988-09-29	Washington, DC	240	6'09	Texas	2007	1	2	SEA	3202
332	Serge Ibaka	1989-09-18	Sep 18, 1989	245	6'10	None	2008	1	24	SEA	3439
333	Perry Jones	1991-09-24	Winnsboro, LA	235	6'11	Baylor	2012	1	28	OKC	6598
334	Kendrick Perkins	1984-11-10	Nederland, TX	270	6'10	None	2003	1	27	MEM	2018
335	Thabo Sefolosha	1984-05-02	Switzerland	222	6'07	None	2006	1	13	PHI	3028
336	Russell Westbrook	1988-11-12	Long Beach, CA	200	6'03	UCLA	2008	1	4	SEA	3468
337	Dwight Buycks	1989-03-06	Milwaukee, WI	190	6'03	Marquette	\N	\N	\N	\N	6503
338	DeMar DeRozan	1989-08-07	Compton, CA	216	6'07	USC	2009	1	9	TOR	3978
339	Tyler Hansbrough	1985-11-03	Columbia, MO	250	6'09	North Carolina	2009	1	13	IND	3991
340	Amir Johnson	1987-05-01	Los Angeles, CA	210	6'09	None	2005	2	56	DET	2769
341	Steve Novak	1983-06-13	Libertyville, IL	235	6'10	Marquette	2006	2	32	HOU	3018
342	Terrence Ross	1991-02-05	Portland, OR	195	6'06	Washington	2012	1	8	TOR	6619
343	Julyan Stone	1988-12-07	Alexandria, VA	200	6'06	UTEP	\N	\N	\N	\N	6543
344	Greivis Vasquez	1987-01-16	Venezuela	211	6'06	Maryland	2010	1	28	MEM	4291
345	Nando de Colo	1987-06-23	France	195	6'05	None	2009	2	53	SA	3977
346	Landry Fields	1988-06-27	Long Beach, CA	215	6'07	Stanford	2010	2	39	NY	4274
347	Chuck Hayes	1983-06-11	San Leandro, CA	250	6'06	Kentucky	\N	\N	\N	\N	2834
348	Kyle Lowry	1986-03-25	Philadelphia, PA	205	6'00	Villanova	2006	1	24	MEM	3012
349	Patrick Patterson	1989-03-14	Washington, DC	235	6'09	Kentucky	2010	1	14	HOU	4264
350	John Salmons	1979-12-12	Philadelphia, PA	207	6'06	Miami (FL)	2002	1	26	SA	1726
351	Jonas Valanciunas	1992-05-06	Lithuania	231	6'11	None	2011	1	5	TOR	6477
352	Andris Biedrins	1986-04-02	Latvia	250	7'00	None	2004	1	11	GS	2427
353	Alec Burks	1991-07-20	Grandview, MO	211	6'06	Colorado	2011	1	12	UTAH	6429
354	Jeremy Evans	1987-10-24	Crossett, AR	197	6'09	Western Kentucky	2010	2	55	UTAH	4295
355	Diante Garrett	1988-11-03	Milwaukee, WI	190	6'04	Iowa State	\N	\N	\N	\N	6663
356	Gordon Hayward	1990-03-23	Indianapolis, IN	220	6'08	Butler	2010	1	9	UTAH	4249
357	Enes Kanter	1992-05-20	Switzerland	247	6'11	Kentucky	2011	1	3	UTAH	6447
358	Brandon Rush	1985-07-07	Kansas City, MO	233	6'06	Kansas	2008	1	13	POR	3457
359	Marvin Williams	1986-06-19	Bremerton, WA	237	6'09	North Carolina	2005	1	2	ATL	2797
360	Trey Burke	1992-11-12	Columbus, OH	190	6'01	Michigan	2013	1	9	MIN	2579260
361	Ian Clark	1991-03-07	Memphis, TN	173	6'03	Belmont	\N	\N	\N	\N	2489785
362	Derrick Favors	1991-07-15	Atlanta, GA	268	6'10	Georgia Tech	2010	1	3	NJ	4257
363	Rudy Gobert	1992-06-26	France	245	7'01	None	2013	1	27	DEN	3032976
364	Richard Jefferson	1980-06-21	Los Angeles, CA	234	6'07	Arizona	2001	1	13	HOU	1006
365	John Lucas III	1982-11-21	Washington, DC	166	5'11	Oklahoma State	\N	\N	\N	\N	2866
366	Malcolm Thomas	1988-11-08	Columbia, MO	225	6'09	San Diego State	\N	\N	\N	\N	6511
367	Tony Allen	1982-01-11	Chicago, IL	213	6'04	Oklahoma State	2004	1	25	BOS	2367
368	Mike Conley	1987-10-11	Indianapolis, IN	185	6'01	Ohio State	2007	1	4	MEM	3195
369	Jamaal Franklin	1991-07-21	Moreno Valley, CA	191	6'05	San Diego State	2013	2	41	MEM	2528356
370	James Johnson	1987-02-20	Cheyenne, WY	248	6'09	Wake Forest	2009	1	16	CHI	3999
371	Courtney Lee	1985-10-03	Indianapolis, IN	200	6'05	Western Kentucky	2008	1	22	ORL	3445
372	Mike Miller	1980-02-19	Mitchell, SD	218	6'08	Florida	2000	1	5	ORL	558
373	Tayshaun Prince	1980-02-28	Compton, CA	215	6'09	Kentucky	2002	1	23	DET	1724
374	Beno Udrih	1982-07-05	Yugoslavia	210	6'03	None	2004	1	28	SA	2448
375	Nick Calathes	1989-02-07	Orlando, FL	213	6'06	Florida	2009	2	45	MIN	3969
376	Ed Davis	1989-06-05	Washington, DC	225	6'10	North Carolina	2010	1	13	TOR	4259
377	Marc Gasol	1985-01-29	Spain	265	7'01	None	2007	2	48	LAL	3206
378	Kosta Koufos	1989-02-24	Canton, OH	265	7'00	Ohio State	2008	1	23	UTAH	3444
379	Jon Leuer	1989-05-14	Long Lake, MN	228	6'10	Wisconsin	2011	2	40	MIL	6452
380	Quincy Pondexter	1988-03-10	Fresno, CA	225	6'06	Washington	2010	1	26	OKC	4253
381	Zach Randolph	1981-07-16	Marion, IN	260	6'09	Michigan State	2001	1	19	POR	1017
382	Trevor Ariza	1985-06-30	Miami, FL	220	6'08	UCLA	2004	2	43	NY	2426
383	Trevor Booker	1987-11-25	Newberry, SC	235	6'08	Clemson	2010	1	23	MIN	4270
384	Marcin Gortat	1984-02-17	Poland	240	6'11	None	2005	2	57	PHX	2758
385	Nene Hilario	1982-09-13	Brazil	250	6'11	None	2002	1	7	NY	1713
386	Otto Porter Jr.	1993-06-03	Jun 3, 1993	198	6'08	Georgetown	2013	1	3	WSH	2594922
387	Kevin Seraphin	1989-12-07	Dec 7, 1989	278	6'10	None	2010	1	17	CHI	4289
388	Garrett Temple	1986-05-08	Baton Rouge, LA	195	6'06	LSU	\N	\N	\N	\N	4023
389	Martell Webster	1986-12-04	Edmonds, WA	230	6'07	None	2005	1	6	POR	2795
390	Bradley Beal	1993-06-28	Jun 28, 1993	207	6'05	Florida	2012	1	3	WSH	6580
391	Drew Gooden	1981-09-24	Oakland, CA	250	6'10	Kansas	2002	1	4	MEM	1711
393	Andre Miller	1976-03-19	Los Angeles, CA	200	6'02	Utah	1999	1	8	CLE	557
394	Glen Rice Jr.	1991-01-01	Miami, FL	206	6'06	Georgia Tech	2013	2	35	PHI	2488660
395	Chris Singleton	1989-11-21	Canton, GA	228	6'09	Florida State	2011	1	18	WSH	6470
396	John Wall	1990-09-06	Raleigh, NC	195	6'04	Kentucky	2010	1	1	WSH	4237
397	Chauncey Billups	1976-09-25	Denver, CO	210	6'03	Colorado	1997	1	3	BOS	63
398	Kentavious Caldwell-Pope	1993-02-18	Thomaston, GA	205	6'05	Georgia	2013	1	8	DET	2581018
399	Andre Drummond	1993-08-10	Mount Vernon, NY	270	6'10	Connecticut	2012	1	9	DET	6585
400	Brandon Jennings	1989-09-23	Compton, CA	169	6'01	None	2009	1	10	MIL	3997
401	Tony Mitchell	1992-04-07	Milwaukee, WI	235	6'08	North Texas	2013	2	37	DET	2583664
402	Kyle Singler	1988-05-04	Medford, OR	230	6'08	Duke	2011	2	33	DET	6469
403	Josh Smith	1985-12-05	College Park, GA	225	6'09	None	2004	1	17	ATL	2411
404	Charlie Villanueva	1984-08-24	Queens, NY	232	6'11	Connecticut	2005	1	7	TOR	2792
405	Will Bynum	1983-01-04	Chicago, IL	185	6'00	Georgia Tech	\N	\N	\N	\N	2816
406	Luigi Datome	1987-11-28	Italy	215	6'08	None	\N	\N	\N	\N	2585629
407	Josh Harrellson	1989-02-12	Feb 12, 1989	275	6'10	Kentucky	2011	2	45	NO	6439
408	Jonas Jerebko	1987-03-02	Sweden	231	6'10	None	2009	2	39	DET	3998
409	Greg Monroe	1990-06-04	Harvey, LA	250	6'11	Georgetown	2010	1	7	DET	4260
410	Peyton Siva	1990-10-24	Seattle, WA	185	6'00	Louisville	2013	2	56	DET	2488706
411	Rodney Stuckey	1986-04-21	Seattle, WA	205	6'05	Eastern Washington	2007	1	15	DET	3235
412	Bismack Biyombo	1992-08-28	Zaire	245	6'09	None	2011	1	7	SAC	6427
413	Brendan Haywood	1979-11-27	New York, NY	263	7'00	North Carolina	2001	1	20	CLE	1000
414	Al Jefferson	1985-01-04	Monticello, MS	289	6'10	None	2004	1	15	BOS	2389
415	Josh McRoberts	1987-02-28	Indianapolis, IN	240	6'10	Duke	2007	2	37	POR	3220
416	Jannero Pargo	1979-10-22	Chicago, IL	185	6'01	Arkansas	\N	\N	\N	\N	1821
417	Jeff Taylor	1989-05-23	Sweden	225	6'07	Vanderbilt	2012	2	31	CHA	6156
418	Kemba Walker	1990-05-08	Bronx, NY	184	6'01	Connecticut	2011	1	9	CHA	6479
419	Chris Douglas-Roberts	1987-01-08	Detroit, MI	210	6'07	Memphis	2008	2	40	NJ	3422
420	Gerald Henderson	1987-12-09	Caldwell, NJ	215	6'05	Duke	2009	1	12	CHA	3993
421	Michael Kidd-Gilchrist	1993-09-26	Philadelphia, PA	232	6'07	Kentucky	2012	1	2	CHA	6601
422	Gary Neal	1984-10-03	Baltimore, MD	210	6'04	Towson	\N	\N	\N	\N	4300
423	Luke Ridnour	1981-02-13	Feb 13, 1981	175	6'02	Oregon	2003	1	14	SEA	1985
424	Anthony Tolliver	1985-06-01	Springfield, MO	240	6'08	Creighton	\N	\N	\N	\N	3276
425	Cody Zeller	1992-10-05	Washington, IN	240	7'00	Indiana	2013	1	4	CHA	2579258
426	Alexis Ajinca	1988-05-06	France	248	7'02	None	2008	1	20	CHA	3410
427	Ryan Anderson	1988-05-06	Sacramento, CA	240	6'10	California	2008	1	21	NJ	3412
428	Anthony Davis	1993-03-11	Chicago, IL	220	6'10	Kentucky	2012	1	1	NO	6583
429	Eric Gordon	1988-12-25	Indianapolis, IN	215	6'04	Indiana	2008	1	7	LAC	3431
430	Darius Miller	1990-03-21	Maysville, KY	225	6'08	Kentucky	2012	2	46	NO	6610
431	Austin Rivers	1992-08-01	Santa Monica, CA	200	6'04	Duke	2012	1	10	NO	6617
432	Jason Smith	1986-03-02	Greeley, CO	240	7'00	Colorado State	2007	1	20	MIA	3232
433	Jeff Withey	1990-03-07	San Diego, CA	235	7'00	Kansas	2013	2	39	POR	2333797
434	Al-Farouq Aminu	1990-09-21	Atlanta, GA	215	6'09	Wake Forest	2010	1	8	LAC	4248
435	Luke Babbitt	1989-06-20	Cincinnati, OH	225	6'09	Nevada	2010	1	16	MIN	4250
436	Tyreke Evans	1989-09-19	Chester, PA	220	6'06	Memphis	2009	1	4	SAC	3983
437	Jrue Holiday	1990-06-12	Mission Hills, CA	205	6'04	UCLA	2009	1	17	PHI	3995
438	Anthony Morrow	1985-09-27	Charlotte, NC	210	6'05	Georgia Tech	\N	\N	\N	\N	3474
439	Brian Roberts	1985-12-03	Toledo, OH	173	6'01	Dayton	\N	\N	\N	\N	6641
440	Greg Stiemsma	1985-09-26	Randolph, WI	260	6'11	Wisconsin	\N	\N	\N	\N	4235
\.


--
-- Name: players_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('players_id_seq', 440, true);


--
-- Data for Name: standings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY standings (id, team, season_year, season_type, team_conference, team_division, conf_rank, div_rank, wins, losses, pct, won_champ) FROM stdin;
1	hawks	1990-91	Regular Season	East	Central	6	4	43	39	0.524000000000000021	f
2	celtics	1990-91	Regular Season	East	Atlantic	2	1	56	26	0.683000000000000052	f
3	cavaliers	1990-91	Regular Season	East	Central	9	6	33	49	0.402000000000000024	f
4	bulls	1990-91	Regular Season	East	Central	1	1	61	21	0.743999999999999995	f
5	mavericks	1990-91	Regular Season	West	Midwest	12	6	28	54	0.341000000000000025	f
6	nuggets	1990-91	Regular Season	West	Midwest	14	7	20	62	0.243999999999999995	f
7	warriors	1990-91	Regular Season	West	Pacific	7	4	44	38	0.537000000000000033	f
8	rockets	1990-91	Regular Season	West	Midwest	6	3	52	30	0.634000000000000008	f
9	clippers	1990-91	Regular Season	West	Pacific	9	6	31	51	0.378000000000000003	f
10	lakers	1990-91	Regular Season	West	Pacific	3	2	58	24	0.706999999999999962	f
11	heat	1990-91	Regular Season	East	Atlantic	13	6	24	58	0.292999999999999983	f
12	bucks	1990-91	Regular Season	East	Central	4	3	48	34	0.584999999999999964	f
13	timberwolves	1990-91	Regular Season	West	Midwest	11	5	29	53	0.353999999999999981	f
14	nets	1990-91	Regular Season	East	Atlantic	11	5	26	56	0.317000000000000004	f
15	knicks	1990-91	Regular Season	East	Atlantic	8	3	39	43	0.475999999999999979	f
16	magic	1990-91	Regular Season	West	Midwest	9	4	31	51	0.378000000000000003	f
17	pacers	1990-91	Regular Season	East	Central	7	5	41	41	0.5	f
18	sixers	1990-91	Regular Season	East	Atlantic	5	2	44	38	0.537000000000000033	f
19	suns	1990-91	Regular Season	West	Pacific	4	3	55	27	0.671000000000000041	f
20	blazers	1990-91	Regular Season	West	Pacific	1	1	63	19	0.768000000000000016	f
21	kings	1990-91	Regular Season	West	Pacific	13	7	25	57	0.304999999999999993	f
22	spurs	1990-91	Regular Season	West	Midwest	2	1	55	27	0.671000000000000041	f
23	thunder	1990-91	Regular Season	West	Pacific	8	5	41	41	0.5	f
24	jazz	1990-91	Regular Season	West	Midwest	5	2	54	28	0.65900000000000003	f
25	wizards	1990-91	Regular Season	East	Atlantic	10	4	30	52	0.365999999999999992	f
26	pistons	1990-91	Regular Season	East	Central	3	2	50	32	0.609999999999999987	f
27	pelicans	1990-91	Regular Season	East	Central	11	7	26	56	0.317000000000000004	f
28	hawks	1991-92	Regular Season	East	Central	8	5	38	44	0.463000000000000023	f
29	celtics	1991-92	Regular Season	East	Atlantic	2	1	51	31	0.621999999999999997	f
30	cavaliers	1991-92	Regular Season	East	Central	4	2	57	25	0.694999999999999951	f
31	bulls	1991-92	Regular Season	East	Central	1	1	67	15	0.816999999999999948	f
32	mavericks	1991-92	Regular Season	West	Midwest	12	5	22	60	0.268000000000000016	f
33	nuggets	1991-92	Regular Season	West	Midwest	11	4	24	58	0.292999999999999983	f
34	warriors	1991-92	Regular Season	West	Pacific	2	2	55	27	0.671000000000000041	f
35	rockets	1991-92	Regular Season	West	Midwest	9	3	42	40	0.512000000000000011	f
36	clippers	1991-92	Regular Season	West	Pacific	7	5	45	37	0.549000000000000044	f
37	lakers	1991-92	Regular Season	West	Pacific	8	6	43	39	0.524000000000000021	f
38	heat	1991-92	Regular Season	East	Atlantic	8	4	38	44	0.463000000000000023	f
39	bucks	1991-92	Regular Season	East	Central	11	6	31	51	0.378000000000000003	f
40	timberwolves	1991-92	Regular Season	West	Midwest	13	6	15	67	0.182999999999999996	f
41	nets	1991-92	Regular Season	East	Atlantic	6	3	40	42	0.487999999999999989	f
42	knicks	1991-92	Regular Season	East	Atlantic	2	1	51	31	0.621999999999999997	f
43	magic	1991-92	Regular Season	East	Atlantic	14	7	21	61	0.256000000000000005	f
44	pacers	1991-92	Regular Season	East	Central	6	4	40	42	0.487999999999999989	f
45	sixers	1991-92	Regular Season	East	Atlantic	10	5	35	47	0.426999999999999991	f
46	suns	1991-92	Regular Season	West	Pacific	4	3	53	29	0.646000000000000019	f
47	blazers	1991-92	Regular Season	West	Pacific	1	1	57	25	0.694999999999999951	f
48	kings	1991-92	Regular Season	West	Pacific	10	7	29	53	0.353999999999999981	f
49	spurs	1991-92	Regular Season	West	Midwest	5	2	47	35	0.572999999999999954	f
50	thunder	1991-92	Regular Season	West	Pacific	5	4	47	35	0.572999999999999954	f
51	jazz	1991-92	Regular Season	West	Midwest	2	1	55	27	0.671000000000000041	f
52	wizards	1991-92	Regular Season	East	Atlantic	13	6	25	57	0.304999999999999993	f
53	pistons	1991-92	Regular Season	East	Central	5	3	48	34	0.584999999999999964	f
54	pelicans	1991-92	Regular Season	East	Central	11	6	31	51	0.378000000000000003	f
55	hawks	1992-93	Regular Season	East	Central	6	4	43	39	0.524000000000000021	f
56	celtics	1992-93	Regular Season	East	Atlantic	4	2	48	34	0.584999999999999964	f
57	cavaliers	1992-93	Regular Season	East	Central	3	2	54	28	0.65900000000000003	f
58	bulls	1992-93	Regular Season	East	Central	2	1	57	25	0.694999999999999951	f
59	mavericks	1992-93	Regular Season	West	Midwest	13	6	11	71	0.134000000000000008	f
60	nuggets	1992-93	Regular Season	West	Midwest	9	4	36	46	0.439000000000000001	f
61	warriors	1992-93	Regular Season	West	Pacific	10	6	34	48	0.41499999999999998	f
62	rockets	1992-93	Regular Season	West	Midwest	2	1	55	27	0.671000000000000041	f
63	clippers	1992-93	Regular Season	West	Pacific	7	4	41	41	0.5	f
64	lakers	1992-93	Regular Season	West	Pacific	8	5	39	43	0.475999999999999979	f
65	heat	1992-93	Regular Season	East	Atlantic	11	5	36	46	0.439000000000000001	f
66	bucks	1992-93	Regular Season	East	Central	12	7	28	54	0.341000000000000025	f
67	timberwolves	1992-93	Regular Season	West	Midwest	12	5	19	63	0.232000000000000012	f
68	nets	1992-93	Regular Season	East	Atlantic	6	3	43	39	0.524000000000000021	f
69	knicks	1992-93	Regular Season	East	Atlantic	1	1	60	22	0.731999999999999984	f
70	magic	1992-93	Regular Season	East	Atlantic	8	4	41	41	0.5	f
71	pacers	1992-93	Regular Season	East	Central	8	5	41	41	0.5	f
72	sixers	1992-93	Regular Season	East	Atlantic	13	6	26	56	0.317000000000000004	f
73	suns	1992-93	Regular Season	West	Pacific	1	1	62	20	0.756000000000000005	f
74	blazers	1992-93	Regular Season	West	Pacific	4	3	51	31	0.621999999999999997	f
75	kings	1992-93	Regular Season	West	Pacific	11	7	25	57	0.304999999999999993	f
76	spurs	1992-93	Regular Season	West	Midwest	5	2	49	33	0.597999999999999976	f
77	thunder	1992-93	Regular Season	West	Pacific	2	2	55	27	0.671000000000000041	f
78	jazz	1992-93	Regular Season	West	Midwest	6	3	47	35	0.572999999999999954	f
79	wizards	1992-93	Regular Season	East	Atlantic	14	7	22	60	0.268000000000000016	f
80	pistons	1992-93	Regular Season	East	Central	10	6	40	42	0.487999999999999989	f
81	pelicans	1992-93	Regular Season	East	Central	5	3	44	38	0.537000000000000033	f
82	hawks	1993-94	Regular Season	East	Central	1	1	57	25	0.694999999999999951	f
83	celtics	1993-94	Regular Season	East	Atlantic	10	5	32	50	0.390000000000000013	f
84	cavaliers	1993-94	Regular Season	East	Central	5	3	47	35	0.572999999999999954	f
85	bulls	1993-94	Regular Season	East	Central	3	2	55	27	0.671000000000000041	f
86	mavericks	1993-94	Regular Season	West	Midwest	13	6	13	69	0.159000000000000002	f
87	nuggets	1993-94	Regular Season	West	Midwest	8	4	42	40	0.512000000000000011	f
88	warriors	1993-94	Regular Season	West	Pacific	6	3	50	32	0.609999999999999987	f
89	rockets	1993-94	Regular Season	West	Midwest	2	1	58	24	0.706999999999999962	f
90	clippers	1993-94	Regular Season	West	Pacific	11	7	27	55	0.329000000000000015	f
91	lakers	1993-94	Regular Season	West	Pacific	9	5	33	49	0.402000000000000024	f
92	heat	1993-94	Regular Season	East	Atlantic	8	4	42	40	0.512000000000000011	f
93	bucks	1993-94	Regular Season	East	Central	13	6	20	62	0.243999999999999995	f
94	timberwolves	1993-94	Regular Season	West	Midwest	12	5	20	62	0.243999999999999995	f
95	nets	1993-94	Regular Season	East	Atlantic	7	3	45	37	0.549000000000000044	f
96	knicks	1993-94	Regular Season	East	Atlantic	1	1	57	25	0.694999999999999951	f
97	magic	1993-94	Regular Season	East	Atlantic	4	2	50	32	0.609999999999999987	f
98	pacers	1993-94	Regular Season	East	Central	5	3	47	35	0.572999999999999954	f
99	sixers	1993-94	Regular Season	East	Atlantic	11	6	25	57	0.304999999999999993	f
100	suns	1993-94	Regular Season	West	Pacific	3	2	56	26	0.683000000000000052	f
101	blazers	1993-94	Regular Season	West	Pacific	7	4	47	35	0.572999999999999954	f
102	kings	1993-94	Regular Season	West	Pacific	10	6	28	54	0.341000000000000025	f
103	spurs	1993-94	Regular Season	West	Midwest	4	2	55	27	0.671000000000000041	f
104	thunder	1993-94	Regular Season	West	Pacific	1	1	63	19	0.768000000000000016	f
105	jazz	1993-94	Regular Season	West	Midwest	5	3	53	29	0.646000000000000019	f
106	wizards	1993-94	Regular Season	East	Atlantic	12	7	24	58	0.292999999999999983	f
107	pistons	1993-94	Regular Season	East	Central	13	6	20	62	0.243999999999999995	f
108	pelicans	1993-94	Regular Season	East	Central	9	5	41	41	0.5	f
109	hawks	1994-95	Regular Season	East	Central	7	5	42	40	0.512000000000000011	f
110	celtics	1994-95	Regular Season	East	Atlantic	8	3	35	47	0.426999999999999991	f
111	cavaliers	1994-95	Regular Season	East	Central	6	4	43	39	0.524000000000000021	f
112	bulls	1994-95	Regular Season	East	Central	5	3	47	35	0.572999999999999954	f
113	mavericks	1994-95	Regular Season	West	Midwest	10	5	36	46	0.439000000000000001	f
114	nuggets	1994-95	Regular Season	West	Midwest	8	4	41	41	0.5	f
115	warriors	1994-95	Regular Season	West	Pacific	11	6	26	56	0.317000000000000004	f
116	rockets	1994-95	Regular Season	West	Midwest	6	3	47	35	0.572999999999999954	f
117	clippers	1994-95	Regular Season	West	Pacific	13	7	17	65	0.20699999999999999	f
118	lakers	1994-95	Regular Season	West	Pacific	5	3	48	34	0.584999999999999964	f
119	heat	1994-95	Regular Season	East	Atlantic	10	4	32	50	0.390000000000000013	f
120	bucks	1994-95	Regular Season	East	Central	9	6	34	48	0.41499999999999998	f
121	timberwolves	1994-95	Regular Season	West	Midwest	12	6	21	61	0.256000000000000005	f
122	nets	1994-95	Regular Season	East	Atlantic	11	5	30	52	0.365999999999999992	f
123	knicks	1994-95	Regular Season	East	Atlantic	3	2	55	27	0.671000000000000041	f
124	magic	1994-95	Regular Season	East	Atlantic	1	1	57	25	0.694999999999999951	f
125	pacers	1994-95	Regular Season	East	Central	2	1	52	30	0.634000000000000008	f
126	sixers	1994-95	Regular Season	East	Atlantic	13	6	24	58	0.292999999999999983	f
127	suns	1994-95	Regular Season	West	Pacific	2	1	59	23	0.719999999999999973	f
128	blazers	1994-95	Regular Season	West	Pacific	7	4	44	38	0.537000000000000033	f
129	kings	1994-95	Regular Season	West	Pacific	9	5	39	43	0.475999999999999979	f
130	spurs	1994-95	Regular Season	West	Midwest	1	1	62	20	0.756000000000000005	f
131	thunder	1994-95	Regular Season	West	Pacific	4	2	57	25	0.694999999999999951	f
132	jazz	1994-95	Regular Season	West	Midwest	3	2	60	22	0.731999999999999984	f
133	wizards	1994-95	Regular Season	East	Atlantic	14	7	21	61	0.256000000000000005	f
134	pistons	1994-95	Regular Season	East	Central	12	7	28	54	0.341000000000000025	f
135	pelicans	1994-95	Regular Season	East	Central	4	2	50	32	0.609999999999999987	f
136	hawks	1995-96	Regular Season	East	Central	6	4	46	36	0.561000000000000054	f
137	celtics	1995-96	Regular Season	East	Atlantic	11	5	33	49	0.402000000000000024	f
138	cavaliers	1995-96	Regular Season	East	Central	4	3	47	35	0.572999999999999954	f
139	bulls	1995-96	Regular Season	East	Central	1	1	72	10	0.878000000000000003	f
140	mavericks	1995-96	Regular Season	West	Midwest	12	5	26	56	0.317000000000000004	f
141	nuggets	1995-96	Regular Season	West	Midwest	10	4	35	47	0.426999999999999991	f
142	warriors	1995-96	Regular Season	West	Pacific	9	6	36	46	0.439000000000000001	f
143	rockets	1995-96	Regular Season	West	Midwest	5	3	48	34	0.584999999999999964	f
144	clippers	1995-96	Regular Season	West	Pacific	11	7	29	53	0.353999999999999981	f
145	lakers	1995-96	Regular Season	West	Pacific	4	2	53	29	0.646000000000000019	f
146	heat	1995-96	Regular Season	East	Atlantic	8	3	42	40	0.512000000000000011	f
147	bucks	1995-96	Regular Season	East	Central	13	7	25	57	0.304999999999999993	f
148	timberwolves	1995-96	Regular Season	West	Midwest	12	5	26	56	0.317000000000000004	f
149	nets	1995-96	Regular Season	East	Atlantic	12	6	30	52	0.365999999999999992	f
150	knicks	1995-96	Regular Season	East	Atlantic	4	2	47	35	0.572999999999999954	f
151	magic	1995-96	Regular Season	East	Atlantic	2	1	60	22	0.731999999999999984	f
152	pacers	1995-96	Regular Season	East	Central	3	2	52	30	0.634000000000000008	f
153	sixers	1995-96	Regular Season	East	Atlantic	15	7	18	64	0.220000000000000001	f
154	suns	1995-96	Regular Season	West	Pacific	7	4	41	41	0.5	f
155	blazers	1995-96	Regular Season	West	Pacific	6	3	44	38	0.537000000000000033	f
156	kings	1995-96	Regular Season	West	Pacific	8	5	39	43	0.475999999999999979	f
157	spurs	1995-96	Regular Season	West	Midwest	2	1	59	23	0.719999999999999973	f
158	thunder	1995-96	Regular Season	West	Pacific	1	1	64	18	0.780000000000000027	f
159	raptors	1995-96	Regular Season	East	Central	14	8	21	61	0.256000000000000005	f
160	jazz	1995-96	Regular Season	West	Midwest	3	2	55	27	0.671000000000000041	f
161	grizzlies	1995-96	Regular Season	West	Midwest	14	7	15	67	0.182999999999999996	f
162	wizards	1995-96	Regular Season	East	Atlantic	10	4	39	43	0.475999999999999979	f
163	pistons	1995-96	Regular Season	East	Central	6	4	46	36	0.561000000000000054	f
164	pelicans	1995-96	Regular Season	East	Central	9	6	41	41	0.5	f
165	hawks	1996-97	Regular Season	East	Central	4	2	56	26	0.683000000000000052	f
166	celtics	1996-97	Regular Season	East	Atlantic	15	7	15	67	0.182999999999999996	f
167	cavaliers	1996-97	Regular Season	East	Central	9	5	42	40	0.512000000000000011	f
168	bulls	1996-97	Regular Season	East	Central	1	1	69	13	0.84099999999999997	f
169	mavericks	1996-97	Regular Season	West	Midwest	11	4	24	58	0.292999999999999983	f
170	nuggets	1996-97	Regular Season	West	Midwest	12	5	21	61	0.256000000000000005	f
171	warriors	1996-97	Regular Season	West	Pacific	10	7	30	52	0.365999999999999992	f
172	rockets	1996-97	Regular Season	West	Midwest	2	2	57	25	0.694999999999999951	f
173	clippers	1996-97	Regular Season	West	Pacific	8	5	36	46	0.439000000000000001	f
174	lakers	1996-97	Regular Season	West	Pacific	4	2	56	26	0.683000000000000052	f
175	heat	1996-97	Regular Season	East	Atlantic	2	1	61	21	0.743999999999999995	f
176	bucks	1996-97	Regular Season	East	Central	11	7	33	49	0.402000000000000024	f
177	timberwolves	1996-97	Regular Season	West	Midwest	6	3	40	42	0.487999999999999989	f
178	nets	1996-97	Regular Season	East	Atlantic	13	5	26	56	0.317000000000000004	f
179	knicks	1996-97	Regular Season	East	Atlantic	3	2	57	25	0.694999999999999951	f
180	magic	1996-97	Regular Season	East	Atlantic	7	3	45	37	0.549000000000000044	f
181	pacers	1996-97	Regular Season	East	Central	10	6	39	43	0.475999999999999979	f
182	sixers	1996-97	Regular Season	East	Atlantic	14	6	22	60	0.268000000000000016	f
183	suns	1996-97	Regular Season	West	Pacific	6	4	40	42	0.487999999999999989	f
184	blazers	1996-97	Regular Season	West	Pacific	5	3	49	33	0.597999999999999976	f
185	kings	1996-97	Regular Season	West	Pacific	9	6	34	48	0.41499999999999998	f
186	spurs	1996-97	Regular Season	West	Midwest	13	6	20	62	0.243999999999999995	f
187	thunder	1996-97	Regular Season	West	Pacific	2	1	57	25	0.694999999999999951	f
188	raptors	1996-97	Regular Season	East	Central	12	8	30	52	0.365999999999999992	f
189	jazz	1996-97	Regular Season	West	Midwest	1	1	64	18	0.780000000000000027	f
190	grizzlies	1996-97	Regular Season	West	Midwest	14	7	14	68	0.171000000000000013	f
191	wizards	1996-97	Regular Season	East	Atlantic	8	4	44	38	0.537000000000000033	f
192	pistons	1996-97	Regular Season	East	Central	5	3	54	28	0.65900000000000003	f
193	pelicans	1996-97	Regular Season	East	Central	5	3	54	28	0.65900000000000003	f
194	hawks	1997-98	Regular Season	East	Central	5	4	50	32	0.609999999999999987	f
195	celtics	1997-98	Regular Season	East	Atlantic	12	6	36	46	0.439000000000000001	f
196	cavaliers	1997-98	Regular Season	East	Central	6	5	47	35	0.572999999999999954	f
197	bulls	1997-98	Regular Season	East	Central	1	1	62	20	0.756000000000000005	f
198	mavericks	1997-98	Regular Season	West	Midwest	10	5	20	62	0.243999999999999995	f
199	nuggets	1997-98	Regular Season	West	Midwest	14	7	11	71	0.134000000000000008	f
200	warriors	1997-98	Regular Season	West	Pacific	11	6	19	63	0.232000000000000012	f
201	rockets	1997-98	Regular Season	West	Midwest	8	4	41	41	0.5	f
202	clippers	1997-98	Regular Season	West	Pacific	13	7	17	65	0.20699999999999999	f
203	lakers	1997-98	Regular Season	West	Pacific	2	1	61	21	0.743999999999999995	f
204	heat	1997-98	Regular Season	East	Atlantic	2	1	55	27	0.671000000000000041	f
205	bucks	1997-98	Regular Season	East	Central	12	7	36	46	0.439000000000000001	f
206	timberwolves	1997-98	Regular Season	West	Midwest	7	3	45	37	0.549000000000000044	f
207	nets	1997-98	Regular Season	East	Atlantic	7	2	43	39	0.524000000000000021	f
208	knicks	1997-98	Regular Season	East	Atlantic	7	2	43	39	0.524000000000000021	f
209	magic	1997-98	Regular Season	East	Atlantic	10	5	41	41	0.5	f
210	pacers	1997-98	Regular Season	East	Central	3	2	58	24	0.706999999999999962	f
211	sixers	1997-98	Regular Season	East	Atlantic	14	7	31	51	0.378000000000000003	f
212	suns	1997-98	Regular Season	West	Pacific	4	3	56	26	0.683000000000000052	f
213	blazers	1997-98	Regular Season	West	Pacific	6	4	46	36	0.561000000000000054	f
214	kings	1997-98	Regular Season	West	Pacific	9	5	27	55	0.329000000000000015	f
215	spurs	1997-98	Regular Season	West	Midwest	4	2	56	26	0.683000000000000052	f
216	thunder	1997-98	Regular Season	West	Pacific	2	1	61	21	0.743999999999999995	f
217	raptors	1997-98	Regular Season	East	Central	15	8	16	66	0.195000000000000007	f
218	jazz	1997-98	Regular Season	West	Midwest	1	1	62	20	0.756000000000000005	f
219	grizzlies	1997-98	Regular Season	West	Midwest	11	6	19	63	0.232000000000000012	f
220	wizards	1997-98	Regular Season	East	Atlantic	9	4	42	40	0.512000000000000011	f
221	pistons	1997-98	Regular Season	East	Central	11	6	37	45	0.451000000000000012	f
222	pelicans	1997-98	Regular Season	East	Central	4	3	51	31	0.621999999999999997	f
223	hawks	1998-99	Regular Season	East	Central	4	2	31	19	0.619999999999999996	f
224	celtics	1998-99	Regular Season	East	Atlantic	12	5	19	31	0.380000000000000004	f
225	cavaliers	1998-99	Regular Season	East	Central	11	7	22	28	0.440000000000000002	f
226	bulls	1998-99	Regular Season	East	Central	15	8	13	37	0.260000000000000009	f
227	mavericks	1998-99	Regular Season	West	Midwest	11	5	19	31	0.380000000000000004	f
228	nuggets	1998-99	Regular Season	West	Midwest	12	6	14	36	0.280000000000000027	f
229	warriors	1998-99	Regular Season	West	Pacific	10	6	21	29	0.419999999999999984	f
230	rockets	1998-99	Regular Season	West	Midwest	4	3	31	19	0.619999999999999996	f
231	clippers	1998-99	Regular Season	West	Pacific	13	7	9	41	0.179999999999999993	f
232	lakers	1998-99	Regular Season	West	Pacific	4	2	31	19	0.619999999999999996	f
233	heat	1998-99	Regular Season	East	Atlantic	1	1	33	17	0.660000000000000031	f
234	bucks	1998-99	Regular Season	East	Central	6	4	28	22	0.560000000000000053	f
235	timberwolves	1998-99	Regular Season	West	Midwest	8	4	25	25	0.5	f
236	nets	1998-99	Regular Season	East	Atlantic	14	7	16	34	0.320000000000000007	f
237	knicks	1998-99	Regular Season	East	Atlantic	8	4	27	23	0.540000000000000036	f
238	magic	1998-99	Regular Season	East	Atlantic	1	1	33	17	0.660000000000000031	f
239	pacers	1998-99	Regular Season	East	Central	1	1	33	17	0.660000000000000031	f
240	sixers	1998-99	Regular Season	East	Atlantic	6	3	28	22	0.560000000000000053	f
241	suns	1998-99	Regular Season	West	Pacific	6	3	27	23	0.540000000000000036	f
242	blazers	1998-99	Regular Season	West	Pacific	3	1	35	15	0.699999999999999956	f
243	kings	1998-99	Regular Season	West	Pacific	6	3	27	23	0.540000000000000036	f
244	spurs	1998-99	Regular Season	West	Midwest	1	1	37	13	0.739999999999999991	f
245	thunder	1998-99	Regular Season	West	Pacific	8	5	25	25	0.5	f
246	raptors	1998-99	Regular Season	East	Central	10	6	23	27	0.46000000000000002	f
247	jazz	1998-99	Regular Season	West	Midwest	1	1	37	13	0.739999999999999991	f
248	grizzlies	1998-99	Regular Season	West	Midwest	14	7	8	42	0.160000000000000003	f
249	wizards	1998-99	Regular Season	East	Atlantic	13	6	18	32	0.359999999999999987	f
250	pistons	1998-99	Regular Season	East	Central	5	3	29	21	0.57999999999999996	f
251	pelicans	1998-99	Regular Season	East	Central	9	5	26	24	0.520000000000000018	f
252	hawks	1999-00	Regular Season	East	Central	14	7	28	54	0.341000000000000025	f
253	celtics	1999-00	Regular Season	East	Atlantic	10	5	35	47	0.426999999999999991	f
254	cavaliers	1999-00	Regular Season	East	Central	11	6	32	50	0.390000000000000013	f
255	bulls	1999-00	Regular Season	East	Central	15	8	17	65	0.20699999999999999	f
256	mavericks	1999-00	Regular Season	West	Midwest	9	4	40	42	0.487999999999999989	f
257	nuggets	1999-00	Regular Season	West	Midwest	10	5	35	47	0.426999999999999991	f
258	warriors	1999-00	Regular Season	West	Pacific	13	6	19	63	0.232000000000000012	f
259	rockets	1999-00	Regular Season	West	Midwest	11	6	34	48	0.41499999999999998	f
260	clippers	1999-00	Regular Season	West	Pacific	14	7	15	67	0.182999999999999996	f
261	lakers	1999-00	Regular Season	West	Pacific	1	1	67	15	0.816999999999999948	f
262	heat	1999-00	Regular Season	East	Atlantic	2	1	52	30	0.634000000000000008	f
263	bucks	1999-00	Regular Season	East	Central	7	4	42	40	0.512000000000000011	f
264	timberwolves	1999-00	Regular Season	West	Midwest	6	3	50	32	0.609999999999999987	f
265	nets	1999-00	Regular Season	East	Atlantic	12	6	31	51	0.378000000000000003	f
266	knicks	1999-00	Regular Season	East	Atlantic	3	2	50	32	0.609999999999999987	f
267	magic	1999-00	Regular Season	East	Atlantic	9	4	41	41	0.5	f
268	pacers	1999-00	Regular Season	East	Central	1	1	56	26	0.683000000000000052	f
269	sixers	1999-00	Regular Season	East	Atlantic	4	3	49	33	0.597999999999999976	f
270	suns	1999-00	Regular Season	West	Pacific	4	3	53	29	0.646000000000000019	f
271	blazers	1999-00	Regular Season	West	Pacific	3	2	59	23	0.719999999999999973	f
272	kings	1999-00	Regular Season	West	Pacific	8	5	44	38	0.537000000000000033	f
273	spurs	1999-00	Regular Season	West	Midwest	4	2	53	29	0.646000000000000019	f
274	thunder	1999-00	Regular Season	West	Pacific	7	4	45	37	0.549000000000000044	f
275	raptors	1999-00	Regular Season	East	Central	6	3	45	37	0.549000000000000044	f
276	jazz	1999-00	Regular Season	West	Midwest	2	1	55	27	0.671000000000000041	f
277	grizzlies	1999-00	Regular Season	West	Midwest	12	7	22	60	0.268000000000000016	f
278	wizards	1999-00	Regular Season	East	Atlantic	13	7	29	53	0.353999999999999981	f
279	pistons	1999-00	Regular Season	East	Central	7	4	42	40	0.512000000000000011	f
280	pelicans	1999-00	Regular Season	East	Central	4	2	49	33	0.597999999999999976	f
281	hawks	2000-01	Regular Season	East	Central	13	7	25	57	0.304999999999999993	f
282	celtics	2000-01	Regular Season	East	Atlantic	9	5	36	46	0.439000000000000001	f
283	cavaliers	2000-01	Regular Season	East	Central	11	6	30	52	0.365999999999999992	f
284	bulls	2000-01	Regular Season	East	Central	15	8	15	67	0.182999999999999996	f
285	mavericks	2000-01	Regular Season	West	Midwest	4	2	53	29	0.646000000000000019	f
286	nuggets	2000-01	Regular Season	West	Midwest	11	6	40	42	0.487999999999999989	f
287	warriors	2000-01	Regular Season	West	Pacific	14	7	17	65	0.20699999999999999	f
288	rockets	2000-01	Regular Season	West	Midwest	9	5	45	37	0.549000000000000044	f
289	clippers	2000-01	Regular Season	West	Pacific	12	6	31	51	0.378000000000000003	f
290	lakers	2000-01	Regular Season	West	Pacific	2	1	56	26	0.683000000000000052	f
291	heat	2000-01	Regular Season	East	Atlantic	3	2	50	32	0.609999999999999987	f
292	bucks	2000-01	Regular Season	East	Central	2	1	52	30	0.634000000000000008	f
293	timberwolves	2000-01	Regular Season	West	Midwest	8	4	47	35	0.572999999999999954	f
294	nets	2000-01	Regular Season	East	Atlantic	12	6	26	56	0.317000000000000004	f
295	knicks	2000-01	Regular Season	East	Atlantic	4	3	48	34	0.584999999999999964	f
296	magic	2000-01	Regular Season	East	Atlantic	7	4	43	39	0.524000000000000021	f
297	pacers	2000-01	Regular Season	East	Central	8	4	41	41	0.5	f
298	sixers	2000-01	Regular Season	East	Atlantic	1	1	56	26	0.683000000000000052	f
299	suns	2000-01	Regular Season	West	Pacific	6	3	51	31	0.621999999999999997	f
300	blazers	2000-01	Regular Season	West	Pacific	7	4	50	32	0.609999999999999987	f
301	kings	2000-01	Regular Season	West	Pacific	3	2	55	27	0.671000000000000041	f
302	spurs	2000-01	Regular Season	West	Midwest	1	1	58	24	0.706999999999999962	f
303	thunder	2000-01	Regular Season	West	Pacific	10	5	44	38	0.537000000000000033	f
304	raptors	2000-01	Regular Season	East	Central	5	2	47	35	0.572999999999999954	f
305	jazz	2000-01	Regular Season	West	Midwest	4	2	53	29	0.646000000000000019	f
306	grizzlies	2000-01	Regular Season	West	Midwest	13	7	23	59	0.280000000000000027	f
307	wizards	2000-01	Regular Season	East	Atlantic	14	7	19	63	0.232000000000000012	f
308	pistons	2000-01	Regular Season	East	Central	10	5	32	50	0.390000000000000013	f
309	pelicans	2000-01	Regular Season	East	Central	6	3	46	36	0.561000000000000054	f
310	hawks	2001-02	Regular Season	East	Central	12	6	33	49	0.402000000000000024	f
311	celtics	2001-02	Regular Season	East	Atlantic	3	2	49	33	0.597999999999999976	f
312	cavaliers	2001-02	Regular Season	East	Central	14	7	29	53	0.353999999999999981	f
313	bulls	2001-02	Regular Season	East	Central	15	8	21	61	0.256000000000000005	f
314	mavericks	2001-02	Regular Season	West	Midwest	4	2	57	25	0.694999999999999951	f
315	nuggets	2001-02	Regular Season	West	Midwest	12	6	27	55	0.329000000000000015	f
316	warriors	2001-02	Regular Season	West	Pacific	14	7	21	61	0.256000000000000005	f
317	rockets	2001-02	Regular Season	West	Midwest	11	5	28	54	0.341000000000000025	f
318	clippers	2001-02	Regular Season	West	Pacific	9	5	39	43	0.475999999999999979	f
319	lakers	2001-02	Regular Season	West	Pacific	3	2	58	24	0.706999999999999962	f
320	heat	2001-02	Regular Season	East	Atlantic	11	6	36	46	0.439000000000000001	f
321	bucks	2001-02	Regular Season	East	Central	9	5	41	41	0.5	f
322	timberwolves	2001-02	Regular Season	West	Midwest	5	3	50	32	0.609999999999999987	f
323	nets	2001-02	Regular Season	East	Atlantic	1	1	52	30	0.634000000000000008	f
324	knicks	2001-02	Regular Season	East	Atlantic	13	7	30	52	0.365999999999999992	f
325	magic	2001-02	Regular Season	East	Atlantic	5	3	44	38	0.537000000000000033	f
326	pacers	2001-02	Regular Season	East	Central	8	4	42	40	0.512000000000000011	f
327	sixers	2001-02	Regular Season	East	Atlantic	6	4	43	39	0.524000000000000021	f
328	suns	2001-02	Regular Season	West	Pacific	10	6	36	46	0.439000000000000001	f
329	blazers	2001-02	Regular Season	West	Pacific	6	3	49	33	0.597999999999999976	f
330	kings	2001-02	Regular Season	West	Pacific	1	1	61	21	0.743999999999999995	f
331	spurs	2001-02	Regular Season	West	Midwest	2	1	58	24	0.706999999999999962	f
332	thunder	2001-02	Regular Season	West	Pacific	7	4	45	37	0.549000000000000044	f
333	raptors	2001-02	Regular Season	East	Central	7	3	42	40	0.512000000000000011	f
334	jazz	2001-02	Regular Season	West	Midwest	8	4	44	38	0.537000000000000033	f
335	grizzlies	2001-02	Regular Season	West	Midwest	13	7	23	59	0.280000000000000027	f
336	wizards	2001-02	Regular Season	East	Atlantic	10	5	37	45	0.451000000000000012	f
337	pistons	2001-02	Regular Season	East	Central	2	1	50	32	0.609999999999999987	f
338	pelicans	2001-02	Regular Season	East	Central	4	2	44	38	0.537000000000000033	f
339	hawks	2002-03	Regular Season	East	Central	11	5	35	47	0.426999999999999991	f
340	celtics	2002-03	Regular Season	East	Atlantic	6	3	44	38	0.537000000000000033	f
341	cavaliers	2002-03	Regular Season	East	Central	15	8	17	65	0.20699999999999999	f
342	bulls	2002-03	Regular Season	East	Central	12	6	30	52	0.365999999999999992	f
343	mavericks	2002-03	Regular Season	West	Midwest	3	2	60	22	0.731999999999999984	f
344	nuggets	2002-03	Regular Season	West	Midwest	14	7	17	65	0.20699999999999999	f
345	warriors	2002-03	Regular Season	West	Pacific	11	6	38	44	0.463000000000000023	f
346	rockets	2002-03	Regular Season	West	Midwest	9	5	43	39	0.524000000000000021	f
347	clippers	2002-03	Regular Season	West	Pacific	13	7	27	55	0.329000000000000015	f
348	lakers	2002-03	Regular Season	West	Pacific	5	2	50	32	0.609999999999999987	f
349	heat	2002-03	Regular Season	East	Atlantic	13	7	25	57	0.304999999999999993	f
350	bucks	2002-03	Regular Season	East	Central	7	4	42	40	0.512000000000000011	f
351	timberwolves	2002-03	Regular Season	West	Midwest	4	3	51	31	0.621999999999999997	f
352	nets	2002-03	Regular Season	East	Atlantic	2	1	49	33	0.597999999999999976	f
353	knicks	2002-03	Regular Season	East	Atlantic	10	6	37	45	0.451000000000000012	f
354	magic	2002-03	Regular Season	East	Atlantic	8	4	42	40	0.512000000000000011	f
355	pacers	2002-03	Regular Season	East	Central	3	2	48	34	0.584999999999999964	f
356	sixers	2002-03	Regular Season	East	Atlantic	4	2	48	34	0.584999999999999964	f
357	suns	2002-03	Regular Season	West	Pacific	8	4	44	38	0.537000000000000033	f
358	blazers	2002-03	Regular Season	West	Pacific	6	3	50	32	0.609999999999999987	f
359	kings	2002-03	Regular Season	West	Pacific	2	1	59	23	0.719999999999999973	f
360	spurs	2002-03	Regular Season	West	Midwest	1	1	60	22	0.731999999999999984	f
361	thunder	2002-03	Regular Season	West	Pacific	10	5	40	42	0.487999999999999989	f
362	raptors	2002-03	Regular Season	East	Central	14	7	24	58	0.292999999999999983	f
363	jazz	2002-03	Regular Season	West	Midwest	7	4	47	35	0.572999999999999954	f
364	grizzlies	2002-03	Regular Season	West	Midwest	12	6	28	54	0.341000000000000025	f
365	wizards	2002-03	Regular Season	East	Atlantic	9	5	37	45	0.451000000000000012	f
366	pistons	2002-03	Regular Season	East	Central	1	1	50	32	0.609999999999999987	f
367	pelicans	2002-03	Regular Season	East	Central	5	3	47	35	0.572999999999999954	f
368	hawks	2003-04	Regular Season	East	Central	12	7	28	54	0.341000000000000025	f
369	celtics	2003-04	Regular Season	East	Atlantic	8	4	36	46	0.439000000000000001	f
370	cavaliers	2003-04	Regular Season	East	Central	9	5	35	47	0.426999999999999991	f
371	bulls	2003-04	Regular Season	East	Central	14	8	23	59	0.280000000000000027	f
372	mavericks	2003-04	Regular Season	West	Midwest	5	3	52	30	0.634000000000000008	f
373	nuggets	2003-04	Regular Season	West	Midwest	8	6	43	39	0.524000000000000021	f
374	warriors	2003-04	Regular Season	West	Pacific	11	4	37	45	0.451000000000000012	f
375	rockets	2003-04	Regular Season	West	Midwest	7	5	45	37	0.549000000000000044	f
376	clippers	2003-04	Regular Season	West	Pacific	14	7	28	54	0.341000000000000025	f
377	lakers	2003-04	Regular Season	West	Pacific	2	1	56	26	0.683000000000000052	f
378	heat	2003-04	Regular Season	East	Atlantic	4	2	42	40	0.512000000000000011	f
379	bucks	2003-04	Regular Season	East	Central	6	4	41	41	0.5	f
380	timberwolves	2003-04	Regular Season	West	Midwest	1	1	58	24	0.706999999999999962	f
381	nets	2003-04	Regular Season	East	Atlantic	2	1	47	35	0.572999999999999954	f
382	knicks	2003-04	Regular Season	East	Atlantic	7	3	39	43	0.475999999999999979	f
383	magic	2003-04	Regular Season	East	Atlantic	15	7	21	61	0.256000000000000005	f
384	pacers	2003-04	Regular Season	East	Central	1	1	61	21	0.743999999999999995	f
385	sixers	2003-04	Regular Season	East	Atlantic	11	5	33	49	0.402000000000000024	f
386	suns	2003-04	Regular Season	West	Pacific	13	6	29	53	0.353999999999999981	f
387	blazers	2003-04	Regular Season	West	Pacific	10	3	41	41	0.5	f
388	kings	2003-04	Regular Season	West	Pacific	4	2	55	27	0.671000000000000041	f
389	spurs	2003-04	Regular Season	West	Midwest	3	2	57	25	0.694999999999999951	f
390	thunder	2003-04	Regular Season	West	Pacific	12	5	37	45	0.451000000000000012	f
391	raptors	2003-04	Regular Season	East	Central	10	6	33	49	0.402000000000000024	f
392	jazz	2003-04	Regular Season	West	Midwest	9	7	42	40	0.512000000000000011	f
393	grizzlies	2003-04	Regular Season	West	Midwest	6	4	50	32	0.609999999999999987	f
394	wizards	2003-04	Regular Season	East	Atlantic	13	6	25	57	0.304999999999999993	f
395	pistons	2003-04	Regular Season	East	Central	3	2	54	28	0.65900000000000003	f
396	pelicans	2003-04	Regular Season	East	Central	5	3	41	41	0.5	f
397	hawks	2004-05	Regular Season	East	Southeast	15	5	13	69	0.159000000000000002	f
398	celtics	2004-05	Regular Season	East	Atlantic	4	1	45	37	0.549000000000000044	f
399	cavaliers	2004-05	Regular Season	East	Central	9	4	42	40	0.512000000000000011	f
400	bulls	2004-05	Regular Season	East	Central	3	2	47	35	0.572999999999999954	f
401	mavericks	2004-05	Regular Season	West	Southwest	3	2	58	24	0.706999999999999962	f
402	nuggets	2004-05	Regular Season	West	Northwest	7	2	49	33	0.597999999999999976	f
403	warriors	2004-05	Regular Season	West	Pacific	12	5	34	48	0.41499999999999998	f
404	rockets	2004-05	Regular Season	West	Southwest	5	3	51	31	0.621999999999999997	f
405	clippers	2004-05	Regular Season	West	Pacific	10	3	37	45	0.451000000000000012	f
406	lakers	2004-05	Regular Season	West	Pacific	11	4	34	48	0.41499999999999998	f
407	heat	2004-05	Regular Season	East	Southeast	1	1	59	23	0.719999999999999973	f
408	bucks	2004-05	Regular Season	East	Central	13	5	30	52	0.365999999999999992	f
409	timberwolves	2004-05	Regular Season	West	Northwest	9	3	44	38	0.537000000000000033	f
410	nets	2004-05	Regular Season	East	Atlantic	8	3	42	40	0.512000000000000011	f
411	knicks	2004-05	Regular Season	East	Atlantic	12	5	33	49	0.402000000000000024	f
412	magic	2004-05	Regular Season	East	Southeast	10	3	36	46	0.439000000000000001	f
413	pacers	2004-05	Regular Season	East	Central	6	3	44	38	0.537000000000000033	f
414	sixers	2004-05	Regular Season	East	Atlantic	7	2	43	39	0.524000000000000021	f
415	suns	2004-05	Regular Season	West	Pacific	1	1	62	20	0.756000000000000005	f
416	blazers	2004-05	Regular Season	West	Northwest	13	4	27	55	0.329000000000000015	f
417	kings	2004-05	Regular Season	West	Pacific	6	2	50	32	0.609999999999999987	f
418	spurs	2004-05	Regular Season	West	Southwest	2	1	59	23	0.719999999999999973	f
419	thunder	2004-05	Regular Season	West	Northwest	4	1	52	30	0.634000000000000008	f
420	raptors	2004-05	Regular Season	East	Atlantic	11	4	33	49	0.402000000000000024	f
421	jazz	2004-05	Regular Season	West	Northwest	14	5	26	56	0.317000000000000004	f
422	grizzlies	2004-05	Regular Season	West	Southwest	8	4	45	37	0.549000000000000044	f
423	wizards	2004-05	Regular Season	East	Southeast	5	2	45	37	0.549000000000000044	f
424	pistons	2004-05	Regular Season	East	Central	2	1	54	28	0.65900000000000003	f
425	bobcats	2004-05	Regular Season	East	Southeast	14	4	18	64	0.220000000000000001	f
426	pelicans	2004-05	Regular Season	West	Southwest	15	5	18	64	0.220000000000000001	f
427	hawks	2005-06	Regular Season	East	Southeast	14	5	26	56	0.317000000000000004	f
428	celtics	2005-06	Regular Season	East	Atlantic	11	3	33	49	0.402000000000000024	f
429	cavaliers	2005-06	Regular Season	East	Central	3	2	50	32	0.609999999999999987	f
430	bulls	2005-06	Regular Season	East	Central	7	4	41	41	0.5	f
431	mavericks	2005-06	Regular Season	West	Southwest	2	2	60	22	0.731999999999999984	f
432	nuggets	2005-06	Regular Season	West	Northwest	4	1	44	38	0.537000000000000033	f
433	warriors	2005-06	Regular Season	West	Pacific	13	5	34	48	0.41499999999999998	f
434	rockets	2005-06	Regular Season	West	Southwest	12	5	34	48	0.41499999999999998	f
435	clippers	2005-06	Regular Season	West	Pacific	6	2	47	35	0.572999999999999954	f
436	lakers	2005-06	Regular Season	West	Pacific	7	3	45	37	0.549000000000000044	f
437	heat	2005-06	Regular Season	East	Southeast	2	1	52	30	0.634000000000000008	f
438	bucks	2005-06	Regular Season	East	Central	8	5	40	42	0.480999999999999983	f
439	timberwolves	2005-06	Regular Season	West	Northwest	14	4	33	49	0.402000000000000024	f
440	nets	2005-06	Regular Season	East	Atlantic	4	1	49	33	0.597999999999999976	f
441	knicks	2005-06	Regular Season	East	Atlantic	15	5	23	59	0.280000000000000027	f
442	magic	2005-06	Regular Season	East	Southeast	10	3	36	46	0.439000000000000001	f
443	pacers	2005-06	Regular Season	East	Central	6	3	41	41	0.5	f
444	sixers	2005-06	Regular Season	East	Atlantic	9	2	38	44	0.463000000000000023	f
445	suns	2005-06	Regular Season	West	Pacific	3	1	54	28	0.65900000000000003	f
446	blazers	2005-06	Regular Season	West	Northwest	15	5	21	61	0.256000000000000005	f
447	kings	2005-06	Regular Season	West	Pacific	8	4	44	38	0.537000000000000033	f
448	spurs	2005-06	Regular Season	West	Southwest	1	1	63	18	0.778000000000000025	f
449	thunder	2005-06	Regular Season	West	Northwest	11	3	35	47	0.426999999999999991	f
450	raptors	2005-06	Regular Season	East	Atlantic	12	4	27	55	0.329000000000000015	f
451	jazz	2005-06	Regular Season	West	Northwest	9	2	41	41	0.5	f
452	grizzlies	2005-06	Regular Season	West	Southwest	5	3	49	33	0.597999999999999976	f
453	wizards	2005-06	Regular Season	East	Southeast	5	2	42	40	0.512000000000000011	f
454	pistons	2005-06	Regular Season	East	Central	1	1	64	18	0.780000000000000027	f
455	bobcats	2005-06	Regular Season	East	Southeast	13	4	26	56	0.317000000000000004	f
456	pelicans	2005-06	Regular Season	West	Southwest	10	4	38	44	0.463000000000000023	f
457	hawks	2006-07	Regular Season	East	Southeast	13	5	30	52	0.365999999999999992	f
458	celtics	2006-07	Regular Season	East	Atlantic	15	5	24	58	0.292999999999999983	f
459	cavaliers	2006-07	Regular Season	East	Central	2	2	50	32	0.609999999999999987	f
460	bulls	2006-07	Regular Season	East	Central	5	3	49	33	0.597999999999999976	f
461	mavericks	2006-07	Regular Season	West	Southwest	1	1	67	15	0.816999999999999948	f
462	nuggets	2006-07	Regular Season	West	Northwest	6	2	45	37	0.549000000000000044	f
463	warriors	2006-07	Regular Season	West	Pacific	8	2	42	40	0.512000000000000011	f
464	rockets	2006-07	Regular Season	West	Southwest	5	3	52	30	0.634000000000000008	f
465	clippers	2006-07	Regular Season	West	Pacific	9	4	40	42	0.487999999999999989	f
466	lakers	2006-07	Regular Season	West	Pacific	7	3	42	40	0.512000000000000011	f
467	heat	2006-07	Regular Season	East	Southeast	4	1	44	38	0.537000000000000033	f
468	bucks	2006-07	Regular Season	East	Central	14	5	28	54	0.341000000000000025	f
469	timberwolves	2006-07	Regular Season	West	Northwest	13	3	32	50	0.390000000000000013	f
470	nets	2006-07	Regular Season	East	Atlantic	6	2	41	41	0.5	f
471	knicks	2006-07	Regular Season	East	Atlantic	12	4	33	49	0.402000000000000024	f
472	magic	2006-07	Regular Season	East	Southeast	8	3	40	42	0.487999999999999989	f
473	pacers	2006-07	Regular Season	East	Central	9	4	35	47	0.426999999999999991	f
474	sixers	2006-07	Regular Season	East	Atlantic	10	3	35	47	0.426999999999999991	f
475	suns	2006-07	Regular Season	West	Pacific	2	1	61	21	0.743999999999999995	f
476	blazers	2006-07	Regular Season	West	Northwest	12	4	32	50	0.390000000000000013	f
477	kings	2006-07	Regular Season	West	Pacific	11	5	33	49	0.402000000000000024	f
478	spurs	2006-07	Regular Season	West	Southwest	3	2	58	24	0.706999999999999962	f
479	thunder	2006-07	Regular Season	West	Northwest	14	5	31	51	0.378000000000000003	f
480	raptors	2006-07	Regular Season	East	Atlantic	3	1	47	35	0.572999999999999954	f
481	jazz	2006-07	Regular Season	West	Northwest	4	1	51	31	0.621999999999999997	f
482	grizzlies	2006-07	Regular Season	West	Southwest	15	5	22	60	0.268000000000000016	f
483	wizards	2006-07	Regular Season	East	Southeast	7	2	41	41	0.5	f
484	pistons	2006-07	Regular Season	East	Central	1	1	53	29	0.646000000000000019	f
485	bobcats	2006-07	Regular Season	East	Southeast	11	4	33	49	0.402000000000000024	f
486	pelicans	2006-07	Regular Season	West	Southwest	10	4	39	43	0.475999999999999979	f
487	hawks	2007-08	Regular Season	East	Southeast	8	3	37	45	0.451000000000000012	f
488	celtics	2007-08	Regular Season	East	Atlantic	1	1	66	16	0.805000000000000049	f
489	cavaliers	2007-08	Regular Season	East	Central	4	2	45	37	0.549000000000000044	f
490	bulls	2007-08	Regular Season	East	Central	11	4	33	49	0.402000000000000024	f
491	mavericks	2007-08	Regular Season	West	Southwest	7	4	51	31	0.621999999999999997	f
492	nuggets	2007-08	Regular Season	West	Northwest	8	2	50	32	0.609999999999999987	f
493	warriors	2007-08	Regular Season	West	Pacific	9	3	48	34	0.584999999999999964	f
494	rockets	2007-08	Regular Season	West	Southwest	5	3	55	27	0.671000000000000041	f
495	clippers	2007-08	Regular Season	West	Pacific	12	5	23	59	0.280000000000000027	f
496	lakers	2007-08	Regular Season	West	Pacific	1	1	57	25	0.694999999999999951	f
497	heat	2007-08	Regular Season	East	Southeast	15	5	15	67	0.182999999999999996	f
498	bucks	2007-08	Regular Season	East	Central	13	5	26	56	0.317000000000000004	f
499	timberwolves	2007-08	Regular Season	West	Northwest	13	4	22	60	0.268000000000000016	f
500	nets	2007-08	Regular Season	East	Atlantic	10	4	34	48	0.41499999999999998	f
501	knicks	2007-08	Regular Season	East	Atlantic	14	5	23	59	0.280000000000000027	f
502	magic	2007-08	Regular Season	East	Southeast	3	1	52	30	0.634000000000000008	f
503	pacers	2007-08	Regular Season	East	Central	9	3	36	46	0.439000000000000001	f
504	sixers	2007-08	Regular Season	East	Atlantic	7	3	40	42	0.487999999999999989	f
505	suns	2007-08	Regular Season	West	Pacific	6	2	55	27	0.671000000000000041	f
506	blazers	2007-08	Regular Season	West	Northwest	10	3	41	41	0.5	f
507	kings	2007-08	Regular Season	West	Pacific	11	4	38	44	0.463000000000000023	f
508	spurs	2007-08	Regular Season	West	Southwest	3	2	56	26	0.683000000000000052	f
509	thunder	2007-08	Regular Season	West	Northwest	15	5	20	62	0.243999999999999995	f
510	raptors	2007-08	Regular Season	East	Atlantic	6	2	41	41	0.5	f
511	jazz	2007-08	Regular Season	West	Northwest	4	1	54	28	0.65900000000000003	f
512	grizzlies	2007-08	Regular Season	West	Southwest	14	5	22	60	0.268000000000000016	f
513	wizards	2007-08	Regular Season	East	Southeast	5	2	43	39	0.524000000000000021	f
514	pistons	2007-08	Regular Season	East	Central	2	1	59	23	0.719999999999999973	f
515	bobcats	2007-08	Regular Season	East	Southeast	12	4	32	50	0.390000000000000013	f
516	pelicans	2007-08	Regular Season	West	Southwest	2	1	56	26	0.683000000000000052	f
517	hawks	2008-09	Regular Season	East	Southeast	4	2	47	35	0.572999999999999954	f
518	celtics	2008-09	Regular Season	East	Atlantic	2	1	62	20	0.756000000000000005	f
519	cavaliers	2008-09	Regular Season	East	Central	1	1	66	16	0.805000000000000049	f
520	bulls	2008-09	Regular Season	East	Central	7	2	41	41	0.5	f
521	mavericks	2008-09	Regular Season	West	Southwest	6	3	50	32	0.609999999999999987	f
522	nuggets	2008-09	Regular Season	West	Northwest	2	1	54	28	0.65900000000000003	f
523	warriors	2008-09	Regular Season	West	Pacific	10	3	29	53	0.353999999999999981	f
524	rockets	2008-09	Regular Season	West	Southwest	5	2	53	29	0.646000000000000019	f
525	clippers	2008-09	Regular Season	West	Pacific	14	4	19	63	0.232000000000000012	f
526	lakers	2008-09	Regular Season	West	Pacific	1	1	65	17	0.793000000000000038	f
527	heat	2008-09	Regular Season	East	Southeast	5	3	43	39	0.524000000000000021	f
528	bucks	2008-09	Regular Season	East	Central	12	5	34	48	0.41499999999999998	f
529	timberwolves	2008-09	Regular Season	West	Northwest	11	4	24	58	0.292999999999999983	f
530	nets	2008-09	Regular Season	East	Atlantic	11	3	34	48	0.41499999999999998	f
531	knicks	2008-09	Regular Season	East	Atlantic	14	5	32	50	0.390000000000000013	f
532	magic	2008-09	Regular Season	East	Southeast	3	1	59	23	0.719999999999999973	f
533	pacers	2008-09	Regular Season	East	Central	9	4	36	46	0.439000000000000001	f
534	sixers	2008-09	Regular Season	East	Atlantic	6	2	41	41	0.5	f
535	suns	2008-09	Regular Season	West	Pacific	9	2	46	36	0.561000000000000054	f
536	blazers	2008-09	Regular Season	West	Northwest	4	2	54	28	0.65900000000000003	f
537	kings	2008-09	Regular Season	West	Pacific	15	5	17	65	0.20699999999999999	f
538	spurs	2008-09	Regular Season	West	Southwest	3	1	54	28	0.65900000000000003	f
539	thunder	2008-09	Regular Season	West	Northwest	13	5	23	59	0.280000000000000027	f
540	raptors	2008-09	Regular Season	East	Atlantic	13	4	33	49	0.402000000000000024	f
541	jazz	2008-09	Regular Season	West	Northwest	8	3	48	34	0.584999999999999964	f
542	grizzlies	2008-09	Regular Season	West	Southwest	12	5	24	58	0.292999999999999983	f
543	wizards	2008-09	Regular Season	East	Southeast	15	5	19	63	0.232000000000000012	f
544	pistons	2008-09	Regular Season	East	Central	8	3	39	43	0.475999999999999979	f
545	bobcats	2008-09	Regular Season	East	Southeast	10	4	35	47	0.426999999999999991	f
546	pelicans	2008-09	Regular Season	West	Southwest	7	4	49	33	0.597999999999999976	f
547	hawks	2009-10	Regular Season	East	Southeast	3	2	53	29	0.646000000000000019	f
548	celtics	2009-10	Regular Season	East	Atlantic	4	1	50	32	0.609999999999999987	f
549	cavaliers	2009-10	Regular Season	East	Central	1	1	61	21	0.743999999999999995	f
550	bulls	2009-10	Regular Season	East	Central	8	3	41	41	0.5	f
551	mavericks	2009-10	Regular Season	West	Southwest	2	1	55	27	0.671000000000000041	f
552	nuggets	2009-10	Regular Season	West	Northwest	4	1	53	29	0.646000000000000019	f
553	warriors	2009-10	Regular Season	West	Pacific	13	4	26	56	0.317000000000000004	f
554	rockets	2009-10	Regular Season	West	Southwest	9	3	42	40	0.512000000000000011	f
555	clippers	2009-10	Regular Season	West	Pacific	12	3	29	53	0.353999999999999981	f
556	lakers	2009-10	Regular Season	West	Pacific	1	1	57	25	0.694999999999999951	f
557	heat	2009-10	Regular Season	East	Southeast	5	3	47	35	0.572999999999999954	f
558	bucks	2009-10	Regular Season	East	Central	6	2	46	36	0.561000000000000054	f
559	timberwolves	2009-10	Regular Season	West	Northwest	15	5	15	67	0.182999999999999996	f
560	nets	2009-10	Regular Season	East	Atlantic	15	5	12	70	0.145999999999999991	f
561	knicks	2009-10	Regular Season	East	Atlantic	11	3	29	53	0.353999999999999981	f
562	magic	2009-10	Regular Season	East	Southeast	2	1	59	23	0.719999999999999973	f
563	pacers	2009-10	Regular Season	East	Central	10	4	32	50	0.390000000000000013	f
564	sixers	2009-10	Regular Season	East	Atlantic	13	4	27	55	0.329000000000000015	f
565	suns	2009-10	Regular Season	West	Pacific	3	2	54	28	0.65900000000000003	f
566	blazers	2009-10	Regular Season	West	Northwest	6	3	50	32	0.609999999999999987	f
567	kings	2009-10	Regular Season	West	Pacific	14	5	25	57	0.304999999999999993	f
568	spurs	2009-10	Regular Season	West	Southwest	7	2	50	32	0.609999999999999987	f
569	thunder	2009-10	Regular Season	West	Northwest	8	4	50	32	0.609999999999999987	f
570	raptors	2009-10	Regular Season	East	Atlantic	9	2	40	42	0.487999999999999989	f
571	jazz	2009-10	Regular Season	West	Northwest	5	2	53	29	0.646000000000000019	f
572	grizzlies	2009-10	Regular Season	West	Southwest	10	4	40	42	0.487999999999999989	f
573	wizards	2009-10	Regular Season	East	Southeast	14	5	26	56	0.317000000000000004	f
574	pistons	2009-10	Regular Season	East	Central	12	5	27	55	0.329000000000000015	f
575	bobcats	2009-10	Regular Season	East	Southeast	7	4	44	38	0.537000000000000033	f
576	pelicans	2009-10	Regular Season	West	Southwest	11	5	37	45	0.451000000000000012	f
577	hawks	2010-11	Regular Season	East	Southeast	5	3	44	38	0.537000000000000033	f
578	celtics	2010-11	Regular Season	East	Atlantic	3	1	56	26	0.683000000000000052	f
579	cavaliers	2010-11	Regular Season	East	Central	15	5	19	63	0.232000000000000012	f
580	bulls	2010-11	Regular Season	East	Central	1	1	62	20	0.756000000000000005	f
581	mavericks	2010-11	Regular Season	West	Southwest	3	2	57	25	0.694999999999999951	f
582	nuggets	2010-11	Regular Season	West	Northwest	5	2	50	32	0.609999999999999987	f
583	warriors	2010-11	Regular Season	West	Pacific	12	3	36	46	0.439000000000000001	f
584	rockets	2010-11	Regular Season	West	Southwest	9	5	43	39	0.524000000000000021	f
585	clippers	2010-11	Regular Season	West	Pacific	13	4	32	50	0.390000000000000013	f
586	lakers	2010-11	Regular Season	West	Pacific	2	1	57	25	0.694999999999999951	f
587	heat	2010-11	Regular Season	East	Southeast	2	1	58	24	0.706999999999999962	f
588	bucks	2010-11	Regular Season	East	Central	9	3	35	47	0.426999999999999991	f
589	timberwolves	2010-11	Regular Season	West	Northwest	15	5	17	65	0.20699999999999999	f
590	nets	2010-11	Regular Season	East	Atlantic	12	4	24	58	0.292999999999999983	f
591	knicks	2010-11	Regular Season	East	Atlantic	6	2	42	40	0.512000000000000011	f
592	magic	2010-11	Regular Season	East	Southeast	4	2	52	30	0.634000000000000008	f
593	pacers	2010-11	Regular Season	East	Central	8	2	37	45	0.451000000000000012	f
594	sixers	2010-11	Regular Season	East	Atlantic	7	3	41	41	0.5	f
595	suns	2010-11	Regular Season	West	Pacific	10	2	40	42	0.487999999999999989	f
596	blazers	2010-11	Regular Season	West	Northwest	6	3	48	34	0.584999999999999964	f
597	kings	2010-11	Regular Season	West	Pacific	14	5	24	58	0.292999999999999983	f
598	spurs	2010-11	Regular Season	West	Southwest	1	1	61	21	0.743999999999999995	f
599	thunder	2010-11	Regular Season	West	Northwest	4	1	55	27	0.671000000000000041	f
600	raptors	2010-11	Regular Season	East	Atlantic	14	5	22	60	0.268000000000000016	f
601	jazz	2010-11	Regular Season	West	Northwest	11	4	39	43	0.475999999999999979	f
602	grizzlies	2010-11	Regular Season	West	Southwest	8	4	46	36	0.561000000000000054	f
603	wizards	2010-11	Regular Season	East	Southeast	13	5	23	59	0.280000000000000027	f
604	pistons	2010-11	Regular Season	East	Central	11	4	30	52	0.365999999999999992	f
605	bobcats	2010-11	Regular Season	East	Southeast	10	4	34	48	0.41499999999999998	f
606	pelicans	2010-11	Regular Season	West	Southwest	7	3	46	36	0.561000000000000054	f
607	hawks	2011-12	Regular Season	East	Southeast	5	2	40	26	0.605999999999999983	f
608	celtics	2011-12	Regular Season	East	Atlantic	4	1	39	27	0.59099999999999997	f
609	cavaliers	2011-12	Regular Season	East	Central	13	5	21	45	0.318000000000000005	f
610	bulls	2011-12	Regular Season	East	Central	1	1	50	16	0.758000000000000007	f
611	mavericks	2011-12	Regular Season	West	Southwest	7	3	36	30	0.54500000000000004	f
612	nuggets	2011-12	Regular Season	West	Northwest	6	2	38	28	0.575999999999999956	f
613	warriors	2011-12	Regular Season	West	Pacific	13	4	23	43	0.347999999999999976	f
614	rockets	2011-12	Regular Season	West	Southwest	9	4	34	32	0.515000000000000013	f
615	clippers	2011-12	Regular Season	West	Pacific	5	2	40	26	0.605999999999999983	f
616	lakers	2011-12	Regular Season	West	Pacific	3	1	41	25	0.620999999999999996	f
617	heat	2011-12	Regular Season	East	Southeast	2	1	46	20	0.696999999999999953	f
618	bucks	2011-12	Regular Season	East	Central	9	3	31	35	0.469999999999999973	f
619	timberwolves	2011-12	Regular Season	West	Northwest	12	5	26	40	0.394000000000000017	f
620	nets	2011-12	Regular Season	East	Atlantic	12	5	22	44	0.333000000000000018	f
621	knicks	2011-12	Regular Season	East	Atlantic	7	2	36	30	0.54500000000000004	f
622	magic	2011-12	Regular Season	East	Southeast	6	3	37	29	0.561000000000000054	f
623	pacers	2011-12	Regular Season	East	Central	3	2	42	24	0.63600000000000001	f
624	sixers	2011-12	Regular Season	East	Atlantic	8	3	35	31	0.530000000000000027	f
625	suns	2011-12	Regular Season	West	Pacific	10	3	33	33	0.5	f
626	blazers	2011-12	Regular Season	West	Northwest	11	4	28	38	0.423999999999999988	f
627	kings	2011-12	Regular Season	West	Pacific	14	5	22	44	0.333000000000000018	f
628	spurs	2011-12	Regular Season	West	Southwest	1	1	50	16	0.758000000000000007	f
629	thunder	2011-12	Regular Season	West	Northwest	2	1	47	19	0.711999999999999966	f
630	raptors	2011-12	Regular Season	East	Atlantic	11	4	23	43	0.347999999999999976	f
631	jazz	2011-12	Regular Season	West	Northwest	8	3	36	30	0.54500000000000004	f
632	grizzlies	2011-12	Regular Season	West	Southwest	4	2	41	25	0.620999999999999996	f
633	wizards	2011-12	Regular Season	East	Southeast	14	4	20	46	0.302999999999999992	f
634	pistons	2011-12	Regular Season	East	Central	10	4	25	41	0.379000000000000004	f
635	bobcats	2011-12	Regular Season	East	Southeast	15	5	7	59	0.105999999999999997	f
636	pelicans	2011-12	Regular Season	West	Southwest	15	5	21	45	0.318000000000000005	f
637	hawks	2012-13	Regular Season	East	Southeast	6	2	44	38	0.537000000000000033	f
638	celtics	2012-13	Regular Season	East	Atlantic	7	3	41	40	0.506000000000000005	f
639	cavaliers	2012-13	Regular Season	East	Central	13	5	24	58	0.292999999999999983	f
640	bulls	2012-13	Regular Season	East	Central	5	2	45	37	0.549000000000000044	f
641	mavericks	2012-13	Regular Season	West	Southwest	10	4	41	41	0.5	f
642	nuggets	2012-13	Regular Season	West	Northwest	3	2	57	25	0.694999999999999951	f
643	warriors	2012-13	Regular Season	West	Pacific	6	2	47	35	0.572999999999999954	f
644	rockets	2012-13	Regular Season	West	Southwest	8	3	45	37	0.549000000000000044	f
645	clippers	2012-13	Regular Season	West	Pacific	4	1	56	26	0.683000000000000052	f
646	lakers	2012-13	Regular Season	West	Pacific	7	3	45	37	0.549000000000000044	f
647	heat	2012-13	Regular Season	East	Southeast	1	1	66	16	0.805000000000000049	f
648	bucks	2012-13	Regular Season	East	Central	8	3	38	44	0.463000000000000023	f
649	timberwolves	2012-13	Regular Season	West	Northwest	12	5	31	51	0.378000000000000003	f
650	nets	2012-13	Regular Season	East	Atlantic	4	2	49	33	0.597999999999999976	f
651	knicks	2012-13	Regular Season	East	Atlantic	2	1	54	28	0.65900000000000003	f
652	magic	2012-13	Regular Season	East	Southeast	15	5	20	62	0.243999999999999995	f
653	pacers	2012-13	Regular Season	East	Central	3	1	49	32	0.604999999999999982	f
654	sixers	2012-13	Regular Season	East	Atlantic	9	4	34	48	0.41499999999999998	f
655	suns	2012-13	Regular Season	West	Pacific	15	5	25	57	0.304999999999999993	f
656	blazers	2012-13	Regular Season	West	Northwest	11	4	33	49	0.402000000000000024	f
657	kings	2012-13	Regular Season	West	Pacific	13	4	28	54	0.341000000000000025	f
658	spurs	2012-13	Regular Season	West	Southwest	2	1	58	24	0.706999999999999962	f
659	thunder	2012-13	Regular Season	West	Northwest	1	1	60	22	0.731999999999999984	f
660	raptors	2012-13	Regular Season	East	Atlantic	10	5	34	48	0.41499999999999998	f
661	jazz	2012-13	Regular Season	West	Northwest	9	3	43	39	0.524000000000000021	f
662	grizzlies	2012-13	Regular Season	West	Southwest	5	2	56	26	0.683000000000000052	f
663	wizards	2012-13	Regular Season	East	Southeast	12	3	29	53	0.353999999999999981	f
664	pistons	2012-13	Regular Season	East	Central	11	4	29	53	0.353999999999999981	f
665	bobcats	2012-13	Regular Season	East	Southeast	14	4	21	61	0.256000000000000005	f
666	pelicans	2012-13	Regular Season	West	Southwest	14	5	27	55	0.329000000000000015	f
667	hawks	2013-14	Regular Season	East	Southeast	8	4	25	29	0.463000000000000023	f
668	celtics	2013-14	Regular Season	East	Atlantic	12	4	19	37	0.339000000000000024	f
669	cavaliers	2013-14	Regular Season	East	Central	10	4	22	34	0.393000000000000016	f
670	bulls	2013-14	Regular Season	East	Central	4	2	29	25	0.537000000000000033	f
671	mavericks	2013-14	Regular Season	West	Southwest	8	3	33	23	0.588999999999999968	f
672	nuggets	2013-14	Regular Season	West	Northwest	11	4	25	29	0.463000000000000023	f
673	warriors	2013-14	Regular Season	West	Pacific	7	3	33	22	0.599999999999999978	f
674	rockets	2013-14	Regular Season	West	Southwest	3	2	37	18	0.673000000000000043	f
675	clippers	2013-14	Regular Season	West	Pacific	4	1	37	20	0.649000000000000021	f
676	lakers	2013-14	Regular Season	West	Pacific	14	4	19	36	0.344999999999999973	f
677	heat	2013-14	Regular Season	East	Southeast	2	1	39	14	0.735999999999999988	f
678	bucks	2013-14	Regular Season	East	Central	15	5	10	44	0.184999999999999998	f
679	timberwolves	2013-14	Regular Season	West	Northwest	10	3	26	28	0.480999999999999983	f
680	nets	2013-14	Regular Season	East	Atlantic	6	2	25	27	0.480999999999999983	f
681	knicks	2013-14	Regular Season	East	Atlantic	11	3	21	34	0.382000000000000006	f
682	magic	2013-14	Regular Season	East	Southeast	13	5	17	40	0.297999999999999987	f
683	pacers	2013-14	Regular Season	East	Central	1	1	41	13	0.759000000000000008	f
684	sixers	2013-14	Regular Season	East	Atlantic	14	5	15	41	0.268000000000000016	f
685	suns	2013-14	Regular Season	West	Pacific	6	2	33	21	0.610999999999999988	f
686	blazers	2013-14	Regular Season	West	Northwest	5	2	37	18	0.673000000000000043	f
687	kings	2013-14	Regular Season	West	Pacific	15	5	18	36	0.333000000000000018	f
688	spurs	2013-14	Regular Season	West	Southwest	2	1	40	16	0.713999999999999968	f
689	thunder	2013-14	Regular Season	West	Northwest	1	1	43	13	0.768000000000000016	f
690	raptors	2013-14	Regular Season	East	Atlantic	3	1	30	25	0.54500000000000004	f
691	jazz	2013-14	Regular Season	West	Northwest	13	5	19	35	0.35199999999999998	f
692	grizzlies	2013-14	Regular Season	West	Southwest	9	4	31	23	0.573999999999999955	f
693	wizards	2013-14	Regular Season	East	Southeast	5	2	26	28	0.480999999999999983	f
694	pistons	2013-14	Regular Season	East	Central	9	3	23	32	0.417999999999999983	f
695	bobcats	2013-14	Regular Season	East	Southeast	7	3	26	30	0.464000000000000024	f
696	pelicans	2013-14	Regular Season	West	Southwest	12	5	23	31	0.42599999999999999	f
\.


--
-- Name: standings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('standings_id_seq', 696, true);


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY team (id, city, name, abbreviation, code, min_year, max_year, nba_stats_id) FROM stdin;
1	Atlanta	Hawks	ATL	hawks	1949	2013	1610612737
2	Boston	Celtics	BOS	celtics	1946	2013	1610612738
3	Cleveland	Cavaliers	CLE	cavaliers	1970	2013	1610612739
4	Chicago	Bulls	CHI	bulls	1966	2013	1610612741
5	Dallas	Mavericks	DAL	mavericks	1980	2013	1610612742
6	Denver	Nuggets	DEN	nuggets	1976	2013	1610612743
7	Golden State	Warriors	GSW	warriors	1946	2013	1610612744
8	Houston	Rockets	HOU	rockets	1967	2013	1610612745
9	Los Angeles	Clippers	LAC	clippers	1970	2013	1610612746
10	Los Angeles	Lakers	LAL	lakers	1948	2013	1610612747
11	Miami	Heat	MIA	heat	1988	2013	1610612748
12	Milwaukee	Bucks	MIL	bucks	1968	2013	1610612749
13	Minnesota	Timberwolves	MIN	timberwolves	1989	2013	1610612750
14	Brooklyn	Nets	BKN	nets	1976	2013	1610612751
15	New York	Knicks	NYK	knicks	1946	2013	1610612752
16	Orlando	Magic	ORL	magic	1989	2013	1610612753
17	Indiana	Pacers	IND	pacers	1976	2013	1610612754
18	Philadelphia	76ers	PHI	sixers	1949	2013	1610612755
19	Phoenix	Suns	PHX	suns	1968	2013	1610612756
20	Portland	Trail Blazers	POR	blazers	1970	2013	1610612757
21	Sacramento	Kings	SAC	kings	1948	2013	1610612758
22	San Antonio	Spurs	SAS	spurs	1976	2013	1610612759
23	Oklahoma City	Thunder	OKC	thunder	1967	2013	1610612760
24	Toronto	Raptors	TOR	raptors	1995	2013	1610612761
25	Utah	Jazz	UTA	jazz	1974	2013	1610612762
26	Memphis	Grizzlies	MEM	grizzlies	1995	2013	1610612763
27	Washington	Wizards	WAS	wizards	1961	2013	1610612764
28	Detroit	Pistons	DET	pistons	1948	2013	1610612765
29	Charlotte	Bobcats	CHA	bobcats	2004	2013	1610612766
30	New Orleans	Pelicans	NOP	pelicans	1988	2013	1610612740
\.


--
-- Name: team_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('team_id_seq', 30, true);


--
-- Data for Name: team_roster; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY team_roster (id, season, player_id, team, name, jersey, pos, age, ht, wt, salary) FROM stdin;
\.


--
-- Name: team_roster_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('team_roster_id_seq', 1, false);


--
-- Data for Name: team_standings_timeline; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY team_standings_timeline (id, team, date, season_year, season_type, team_conference, team_division, conf_rank, div_rank, conf_wins, conf_losses, div_wins, div_losses, home_wins, home_losses, road_wins, road_losses, total_games, last_10_wins, last_10_losses, wins, losses, pct, gb, streak) FROM stdin;
1	hawks	2014-02-22 14:20:04.228065	2013-14	regular	East	Southeast	8	4	17	17	6	6	16	10	9	19	29	2	8	25	29	0.463000000000000023	14.5	L 8
2	nets	2014-02-22 14:20:04.288248	2013-14	regular	East	Atlantic	6	2	15	18	6	4	16	11	9	16	27	5	5	25	27	0.480999999999999983	3.5	W 1
3	bulls	2014-02-22 14:20:04.316542	2013-14	regular	East	Central	4	2	21	12	7	4	16	10	13	15	25	7	3	29	25	0.537000000000000033	12	W 5
4	mavericks	2014-02-22 14:20:04.371773	2013-14	regular	West	Southwest	8	3	17	15	8	4	18	9	15	14	23	7	3	33	23	0.588999999999999968	7	W 1
5	pistons	2014-02-22 14:20:04.430055	2013-14	regular	East	Central	9	3	19	17	5	4	13	17	10	15	32	5	5	23	32	0.417999999999999983	18.5	W 1
6	rockets	2014-02-22 14:20:04.48259	2013-14	regular	West	Southwest	3	2	21	15	9	4	22	7	15	11	18	8	2	37	18	0.673000000000000043	2.5	L 1
7	clippers	2014-02-22 14:20:04.549432	2013-14	regular	West	Pacific	4	1	20	11	5	4	23	5	14	15	20	5	5	37	20	0.649000000000000021	0	L 2
8	grizzlies	2014-02-22 14:20:04.616574	2013-14	regular	West	Southwest	9	4	18	18	2	11	16	14	15	9	23	7	3	31	23	0.573999999999999955	8	W 4
9	bucks	2014-02-22 14:20:04.701108	2013-14	regular	East	Central	15	5	9	24	3	7	6	22	4	22	44	2	8	10	44	0.184999999999999998	31	L 1
10	pelicans	2014-02-22 14:20:04.794338	2013-14	regular	West	Southwest	12	5	9	22	3	8	13	13	10	18	31	4	6	23	31	0.42599999999999999	16	L 2
11	thunder	2014-02-22 14:20:04.868174	2013-14	regular	West	Northwest	1	1	26	8	9	5	23	4	20	9	13	7	3	43	13	0.768000000000000016	0	L 1
12	sixers	2014-02-22 14:20:04.927552	2013-14	regular	East	Atlantic	14	5	10	23	3	7	8	20	7	21	41	0	10	15	41	0.268000000000000016	15.5	L 10
13	blazers	2014-02-22 14:20:04.994228	2013-14	regular	West	Northwest	5	2	20	14	9	3	20	7	17	11	18	4	6	37	18	0.673000000000000043	5.5	W 1
14	spurs	2014-02-22 14:20:05.060274	2013-14	regular	West	Southwest	2	1	24	10	8	3	18	8	22	8	16	7	3	40	16	0.713999999999999968	0	L 1
15	jazz	2014-02-22 14:20:05.127668	2013-14	regular	West	Northwest	13	5	10	25	3	8	12	15	7	20	35	4	6	19	35	0.35199999999999998	23	L 2
16	celtics	2014-02-22 14:20:05.182849	2013-14	regular	East	Atlantic	12	4	15	17	4	5	11	17	8	20	37	4	6	19	37	0.339000000000000024	11.5	L 3
17	bobcats	2014-02-22 14:20:05.238707	2013-14	regular	East	Southeast	7	3	17	17	1	7	14	14	12	16	30	7	3	26	30	0.464000000000000024	14.5	W 3
18	cavaliers	2014-02-22 14:20:05.296301	2013-14	regular	East	Central	10	4	14	21	4	8	14	13	8	21	34	6	4	22	34	0.393000000000000016	20	L 1
19	nuggets	2014-02-22 14:20:05.355145	2013-14	regular	West	Northwest	11	4	13	18	4	7	14	12	11	17	29	3	7	25	29	0.463000000000000023	17	L 1
20	warriors	2014-02-22 14:20:05.404988	2013-14	regular	West	Pacific	7	3	21	16	8	4	17	10	16	12	22	6	4	33	22	0.599999999999999978	3	W 2
21	pacers	2014-02-22 14:20:05.462756	2013-14	regular	East	Central	1	1	26	6	6	2	26	3	15	10	13	6	4	41	13	0.759000000000000008	0	L 1
22	lakers	2014-02-22 14:20:05.543661	2013-14	regular	West	Pacific	14	4	9	22	4	6	9	17	10	19	36	3	7	19	36	0.344999999999999973	17	W 1
23	heat	2014-02-22 14:20:05.628588	2013-14	regular	East	Southeast	2	1	22	10	9	2	20	4	19	10	14	8	2	39	14	0.735999999999999988	0	W 4
24	timberwolves	2014-02-22 14:20:05.683149	2013-14	regular	West	Northwest	10	3	13	21	5	7	16	11	10	17	28	4	6	26	28	0.480999999999999983	16	W 2
25	knicks	2014-02-22 14:20:05.727678	2013-14	regular	East	Atlantic	11	3	15	19	3	6	12	18	9	16	34	3	7	21	34	0.382000000000000006	9	L 1
26	magic	2014-02-22 14:20:05.794325	2013-14	regular	East	Southeast	13	5	13	23	3	7	14	15	3	25	40	5	5	17	40	0.297999999999999987	24	W 1
27	suns	2014-02-22 14:20:05.860693	2013-14	regular	West	Pacific	6	2	21	13	7	3	19	9	14	12	21	7	3	33	21	0.610999999999999988	2.5	W 3
28	kings	2014-02-22 14:20:05.928473	2013-14	regular	West	Pacific	15	5	10	24	2	9	11	17	7	19	36	3	7	18	36	0.333000000000000018	17.5	L 1
29	raptors	2014-02-22 14:20:05.994818	2013-14	regular	East	Atlantic	3	1	20	13	8	2	15	11	15	14	25	6	4	30	25	0.54500000000000004	0	W 1
30	wizards	2014-02-22 14:20:06.061273	2013-14	regular	East	Southeast	5	2	18	14	5	2	13	14	13	14	28	4	6	26	28	0.480999999999999983	13.5	W 1
\.


--
-- Name: team_standings_timeline_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('team_standings_timeline_id_seq', 30, true);


--
-- Data for Name: test; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY test (ht) FROM stdin;
6'8
6'10
6'4
6'04
6'06
6'09
\.


--
-- Name: players_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY players
    ADD CONSTRAINT players_pkey PRIMARY KEY (id);


--
-- Name: standings_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY standings
    ADD CONSTRAINT standings_pkey PRIMARY KEY (id);


--
-- Name: team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY team
    ADD CONSTRAINT team_pkey PRIMARY KEY (id);


--
-- Name: team_roster_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY team_roster
    ADD CONSTRAINT team_roster_pkey PRIMARY KEY (id);


--
-- Name: team_standings_timeline_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres; Tablespace: 
--

ALTER TABLE ONLY team_standings_timeline
    ADD CONSTRAINT team_standings_timeline_pkey PRIMARY KEY (id);


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

