-- This file is for creating the schema.



-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: ---


-- Database creation must be done outside a multicommand file.
-- These commands were put in this file only as a convenience.
-- -- object: comp520 | type: DATABASE --
-- -- DROP DATABASE IF EXISTS comp520;
-- CREATE DATABASE comp520;
-- -- ddl-end --
-- 

-- object: public.movie_data_temp | type: TABLE --
-- DROP TABLE IF EXISTS public.movie_data_temp;
CREATE TABLE public.movie_data_temp (
	color varchar,
	director_name varchar,
	num_critic_for_reviews bigint,
	duration bigint,
	director_facebook_likes bigint,
	actor_3_facebook_likes bigint,
	actor_2_name varchar,
	actor_1_facebook_likes bigint,
	gross money,
	genres varchar,
	actor_1_name varchar,
	movie_title varchar,
	num_voted_users bigint,
	cast_total_facebook_likes bigint,
	actor_3_name varchar,
	facenumber_in_poster bigint,
	plot_keywords varchar,
	movie_imdb_link varchar,
	num_user_for_reviews bigint,
	language varchar,
	country varchar,
	content_rating varchar,
	budget money,
	title_year bigint,
	actor_2_facebook_likes bigint,
	imdb_score decimal(4,1),
	aspect_ratio decimal(4,2),
	movie_facebook_likes bigint
)
TABLESPACE pg_default;
-- ddl-end --
COMMENT ON TABLE public.movie_data_temp IS E'This table is used to import the initial data from the movies csv file.';
-- ddl-end --
-- ALTER TABLE public.movie_data_temp OWNER TO postgres;
-- ddl-end --

-- object: public.color | type: TABLE --
-- DROP TABLE IF EXISTS public.color;
CREATE TABLE public.color (
	id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	color varchar,
	CONSTRAINT color_id_pk PRIMARY KEY (id)

)
TABLESPACE pg_default;
-- ddl-end --
-- ALTER TABLE public.color OWNER TO postgres;
-- ddl-end --







-- TODO: Make tables per ERD.

