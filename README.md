# pg-search-all

Use PostgreSQL's `row_to_json(...)` function to normalize all your tables so you can query them all at once!

This was presented as a lightning talk at [PGConf US 2015](http://www.pgconf.us/2015/).

The slides from the talk can be found [here](pgconf-us-2015-pg-search-all.pdf).

# Installation

    psql -f src/install.sql

# Usage

    pgconfus=> SELECT * FROM search_all('alice');

    -[ RECORD 1 ]
    table_schema | public
    table_name   | customer
    data         | {"customer_id":51,"store_id":1,"first_name":"ALICE","last_name":"STEWART","email":"alice.stewart@example.org","address_id":55,"activebool":true,"create_date":"2006-02-14","last_update":"2006-02-15 09:57:20","active":1}

    -[ RECORD 2 ]
    table_schema | public
    table_name   | film
    data         | {"film_id":14,"title":"ALICE FANTASIA","description":"A Emotional Drama of a A Shark And a Database Administrator who must Vanquish a Pioneer in Soviet Georgia","release_year":"2006","language_id":1,"original_language_id":null,"rental_duration":6,"rental_rate":0.99,"length":94,"replacement_cost":23.99,"rating":"NC-17","last_update":"2007-09-10 17:46:03.905795","special_features":["Trailers","Deleted Scenes","Behind the Scenes"],"fulltext":"'administr':13 'alic':1 'databas':12 'drama':5 'emot':4 'fantasia':2 'georgia':21 'must':15 'pioneer':18 'shark':9 'soviet':20 'vanquish':16"}
