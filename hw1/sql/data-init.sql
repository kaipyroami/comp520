-- This file is for inserting and manupulating the data.

-- Send the csv data into the temporary table.
\copy movie_data_temp FROM '/tmp/movies-metadata-520-sp19.csv' CSV HEADER;

-- Ensure that each entry will remain unique
ALTER TABLE public.movie_data_temp ADD COLUMN id SERIAL PRIMARY KEY;


-- TODO move data fromt emp table to ERD tables.
 

-- Giving benifit of the doubt to the number of likes. 
-- Import Actors:
INSERT INTO public.actors (name, facebook_likes)
(SELECT actor_1_name, MAX(actor_1_facebook_likes) 
FROM public.movie_data_temp WHERE actor_1_name IS NOT NULL GROUP BY actor_1_name)
UNION
(SELECT actor_2_name, MAX(actor_2_facebook_likes) 
FROM public.movie_data_temp WHERE actor_2_name IS NOT NULL GROUP BY actor_2_name)
UNION
(SELECT actor_3_name, MAX(actor_3_facebook_likes) 
FROM public.movie_data_temp WHERE actor_3_name IS NOT NULL GROUP BY actor_3_name);

-- Import Directors:
INSERT INTO public.directors (name, facebook_likes) 
SELECT director_name, MAX(director_facebook_likes) 
FROM public.movie_data_temp WHERE director_name IS NOT NULL GROUP BY director_name;

-- Import Colors:
INSERT INTO public.colors (color) 
SELECT color 
FROM public.movie_data_temp WHERE color IS NOT NULL GROUP BY color;

-- Import Countries:
INSERT INTO public.countries (country) 
SELECT country 
FROM public.movie_data_temp WHERE country IS NOT NULL GROUP BY country;

-- Cleaning Data.
-- Import Content Ratings:
INSERT INTO public.content_ratings (content_rating) 
SELECT content_rating 
FROM public.movie_data_temp WHERE content_rating IS NOT NULL GROUP BY content_rating;

UPDATE public.content_ratings content_rating SET content_rating = 'Not Rated' WHERE content_rating = 'Unrated';
DELETE FROM public.content_ratings WHERE content_rating = 'Unrated';

-- Import Movies Without FKs:
INSERT INTO public.movies
(
	num_critic_for_reviews,
	duration,
	gross,
	genres,
	movie_title,
	num_voted_users,
	facenumber_in_poster,
	plot_keywords,
	movie_imdb_link,
	num_user_for_reviews,
	language,
	budget,
	title_year,
	imdb_score,
	aspect_ratio,
	movie_facebook_likes
)
SELECT 
	num_critic_for_reviews,
	duration,
	gross,
	genres,
	movie_title,
	num_voted_users,
	facenumber_in_poster,
	plot_keywords,
	movie_imdb_link,
	num_user_for_reviews,
	language,
	budget,
	title_year,
	imdb_score,
	aspect_ratio,
	movie_facebook_likes
FROM public.movie_data_temp;

-- Add relations and foreign keys

UPDATE movies
SET id_colors = colors.id
FROM colors, movie_data_temp
WHERE 
	movie_data_temp.movie_title = movies.movie_title AND 
	movie_data_temp.color = colors.color;

UPDATE movies
SET id_directors = directors.id
FROM directors, movie_data_temp
WHERE 
	movie_data_temp.movie_title = movies.movie_title AND 
	movie_data_temp.director_name = directors.name;

UPDATE movies
SET id_countries = countries.id
FROM countries, movie_data_temp
WHERE 
	movie_data_temp.movie_title = movies.movie_title AND 
	movie_data_temp.country = countries.country;

UPDATE movies
SET id_content_ratings = content_ratings.id
FROM content_ratings, movie_data_temp
WHERE 
	movie_data_temp.movie_title = movies.movie_title AND 
	movie_data_temp.content_rating = content_ratings.content_rating;

-- Actor - Movie join table...
INSERT INTO many_actors_has_many_movies (id_actors, id_movies, movie_actor_number)
(SELECT actors.id AS act_id, 
	movies.id AS mov_id,
	1 as act_num
from actors
JOIN movie_data_temp ON actor_1_name = actors.name
JOIN movies ON movies.movie_title = movie_data_temp.movie_title)
UNION
(SELECT actors.id AS act_id, 
	movies.id AS mov_id,
	2 as act_num
from actors
JOIN movie_data_temp ON actor_2_name = actors.name
JOIN movies ON movies.movie_title = movie_data_temp.movie_title)
UNION
(SELECT actors.id AS act_id, 
	movies.id AS mov_id,
	3 as act_num 
from actors
JOIN movie_data_temp ON actor_3_name = actors.name
JOIN movies ON movies.movie_title = movie_data_temp.movie_title);

-- (5) Database Views, two of which are a combination of multiple tables.
CREATE VIEW directors_works AS
SELECT directors.name,
	num_critic_for_reviews,
	colors.color,
	duration,
	gross,
	genres,
	movie_title,
	num_voted_users,
	facenumber_in_poster,
	plot_keywords,
	movie_imdb_link,
	num_user_for_reviews,
	language,
	countries.country,
	content_ratings.content_rating,
	budget,
	title_year,
	imdb_score,
	aspect_ratio,
	movie_facebook_likes
	FROM public.movies
	JOIN colors ON movies.id_colors = colors.id
	JOIN directors ON movies.id_directors = directors.id
	JOIN countries ON movies.id_countries = countries.id
	JOIN content_ratings ON movies.id_content_ratings = content_ratings.id
	ORDER BY directors.name;

CREATE VIEW movie_gross_rank AS
SELECT movie_title, gross 
FROM movies 
WHERE gross IS NOT NULL
ORDER BY gross DESC;

CREATE VIEW movie_roi AS
SELECT movie_title, gross, 
	budget, 
	CAST(gross/budget AS DECIMAL(6,2)) AS roi_mult
FROM movies 
WHERE gross IS NOT NULL
AND budget IS NOT NULL
ORDER BY roi_mult DESC;




-- (5) Stored Procedures (with parameters) to run compiled SQL queries. 
-- One of these stored procedures will accept and make use of the SQL Date format to be passed as an argument.




-- (5) Five additional SQL Queries to perform joins across multiple tables. 
-- Each of these tables should consist of a three table join.


