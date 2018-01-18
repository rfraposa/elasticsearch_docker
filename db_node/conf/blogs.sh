#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username postgres <<-EOSQL
    create table blogs(title text, seo_title text, url text, author text, dateposted date, category text, locales text, content text);
	copy blogs from '/docker-entrypoint-initdb.d/blogs.csv' DELIMITERS ';' CSV;
EOSQL