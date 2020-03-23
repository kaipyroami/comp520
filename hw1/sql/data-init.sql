-- This file is for inserting data.

-- Send the csv data into the temporary table.
\copy movie_data_temp FROM '/var/lib/postgresql/data/pgdata/movies-metadata-520-sp19.csv' CSV HEADER;


-- TODO move data fromt emp table to ERD tables.