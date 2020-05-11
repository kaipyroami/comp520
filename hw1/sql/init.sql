-- This file is for creating the schema.


-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler  version: 0.9.2
-- PostgreSQL version: 12.0
-- Project Site: pgmodeler.io
-- Model Author: Kyle Crockett


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

-- object: public.colors | type: TABLE --
-- DROP TABLE IF EXISTS public.colors;
CREATE TABLE public.colors (
	id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	color varchar,
	CONSTRAINT color_pk PRIMARY KEY (id)

)
TABLESPACE pg_default;
-- ddl-end --
-- ALTER TABLE public.colors OWNER TO postgres;
-- ddl-end --

-- object: public.directors | type: TABLE --
-- DROP TABLE IF EXISTS public.directors CASCADE;
CREATE TABLE public.directors (
	id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar NOT NULL,
	facebook_likes bigint,
	CONSTRAINT directors_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.directors OWNER TO postgres;
-- ddl-end --

-- object: public.actors | type: TABLE --
-- DROP TABLE IF EXISTS public.actors CASCADE;
CREATE TABLE public.actors (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	name varchar NOT NULL,
	facebook_likes bigint,
	CONSTRAINT actors_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.actors OWNER TO postgres;
-- ddl-end --

-- object: public.movies | type: TABLE --
-- DROP TABLE IF EXISTS public.movies;
CREATE TABLE public.movies (
	id bigint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	id_colors smallint,
	id_directors smallint,
	num_critic_for_reviews bigint,
	duration bigint,
	gross money,
	genres varchar,
	movie_title varchar,
	num_voted_users bigint,
	cast_total_facebook_likes bigint,
	facenumber_in_poster bigint,
	plot_keywords varchar,
	movie_imdb_link varchar,
	num_user_for_reviews bigint,
	language varchar,
	id_countries smallint,
	id_content_ratings smallint,
	budget money,
	title_year smallint,
	imdb_score decimal(4,1),
	aspect_ratio decimal(4,2),
	movie_facebook_likes bigint,
	last_modified timestamp,
	CONSTRAINT movies_pk PRIMARY KEY (id)

)
TABLESPACE pg_default;
-- ddl-end --
COMMENT ON TABLE public.movies IS 'This table is used to import the initial data from the movies csv file.';
-- ddl-end --
-- ALTER TABLE public.movies OWNER TO postgres;
-- ddl-end --

-- object: public.countries | type: TABLE --
-- DROP TABLE IF EXISTS public.countries CASCADE;
CREATE TABLE public.countries (
	id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	country varchar NOT NULL,
	CONSTRAINT countries_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.countries OWNER TO postgres;
-- ddl-end --

-- object: countries_fk | type: CONSTRAINT --
-- ALTER TABLE public.movies DROP CONSTRAINT IF EXISTS countries_fk CASCADE;
ALTER TABLE public.movies ADD CONSTRAINT countries_fk FOREIGN KEY (id_countries)
REFERENCES public.countries (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: colors_fk | type: CONSTRAINT --
-- ALTER TABLE public.movies DROP CONSTRAINT IF EXISTS colors_fk CASCADE;
ALTER TABLE public.movies ADD CONSTRAINT colors_fk FOREIGN KEY (id_colors)
REFERENCES public.colors (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.content_ratings | type: TABLE --
-- DROP TABLE IF EXISTS public.content_ratings CASCADE;
CREATE TABLE public.content_ratings (
	id smallint NOT NULL GENERATED ALWAYS AS IDENTITY ,
	content_rating varchar NOT NULL,
	CONSTRAINT content_ratings_pk PRIMARY KEY (id)

);
-- ddl-end --
-- ALTER TABLE public.content_ratings OWNER TO postgres;
-- ddl-end --

-- object: content_ratings_fk | type: CONSTRAINT --
-- ALTER TABLE public.movies DROP CONSTRAINT IF EXISTS content_ratings_fk CASCADE;
ALTER TABLE public.movies ADD CONSTRAINT content_ratings_fk FOREIGN KEY (id_content_ratings)
REFERENCES public.content_ratings (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: directors_fk | type: CONSTRAINT --
-- ALTER TABLE public.movies DROP CONSTRAINT IF EXISTS directors_fk CASCADE;
ALTER TABLE public.movies ADD CONSTRAINT directors_fk FOREIGN KEY (id_directors)
REFERENCES public.directors (id) MATCH FULL
ON DELETE SET NULL ON UPDATE CASCADE;
-- ddl-end --

-- object: public.many_actors_has_many_movies | type: TABLE --
-- DROP TABLE IF EXISTS public.many_actors_has_many_movies CASCADE;
CREATE TABLE public.many_actors_has_many_movies (
	id_actors bigint NOT NULL,
	id_movies bigint NOT NULL,
	movie_actor_number smallint NOT NULL,
	CONSTRAINT many_actors_has_many_movies_pk PRIMARY KEY (id_movies,id_actors)
);
-- ddl-end --

-- object: actors_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_actors_has_many_movies DROP CONSTRAINT IF EXISTS actors_fk CASCADE;
ALTER TABLE public.many_actors_has_many_movies ADD CONSTRAINT actors_fk FOREIGN KEY (id_actors)
REFERENCES public.actors (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --

-- object: movies_fk | type: CONSTRAINT --
-- ALTER TABLE public.many_actors_has_many_movies DROP CONSTRAINT IF EXISTS movies_fk CASCADE;
ALTER TABLE public.many_actors_has_many_movies ADD CONSTRAINT movies_fk FOREIGN KEY (id_movies)
REFERENCES public.movies (id) MATCH FULL
ON DELETE CASCADE ON UPDATE CASCADE;
-- ddl-end --



