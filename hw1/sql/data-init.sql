-- This file is for inserting data.

-- Send the csv data into the temporary table.
\copy movie_data_temp FROM '/tmp/movies-metadata-520-sp19.csv' CSV HEADER;

-- Ensure that each entry will remain unique
ALTER TABLE public.movie_data_temp ADD COLUMN id SERIAL PRIMARY KEY;


-- TODO move data fromt emp table to ERD tables.
 

-- Giving benifit of the doubt to the number of likes 
INSERT INTO public.actors (name, facebook_likes) SELECT actor_1_name, MAX(actor_1_facebook_likes) FROM public.movie_data_temp WHERE actor_1_name IS NOT NULL GROUP BY actor_1_name;

INSERT INTO public.actors (name, facebook_likes) SELECT actor_2_name, MAX(actor_2_facebook_likes) FROM public.movie_data_temp WHERE actor_2_name IS NOT NULL GROUP BY actor_2_name;

INSERT INTO public.actors (name, facebook_likes) SELECT actor_3_name, MAX(actor_3_facebook_likes) FROM public.movie_data_temp WHERE actor_3_name IS NOT NULL GROUP BY actor_3_name;
