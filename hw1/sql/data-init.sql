-- This file is for inserting data.

-- Send the csv data into the temporary table.
\copy movie_data_temp FROM '/tmp/movies-metadata-520-sp19.csv' CSV HEADER;

-- Ensure that each entry will remain unique
ALTER TABLE public.movie_data_temp ADD COLUMN id SERIAL PRIMARY KEY;


-- TODO move data fromt emp table to ERD tables.