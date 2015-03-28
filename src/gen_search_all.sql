CREATE OR REPLACE FUNCTION gen_search_all ()
RETURNS text
AS
$$
  SELECT string_agg(z.sql, CHR(10) || ' UNION ALL ' || CHR(10))
  FROM 
     (SELECT 'SELECT ' || quote_literal(t.table_schema) || '::text AS table_schema'
          ||      ', ' || quote_literal(t.table_name) || '::text AS table_name'
          ||      ', row_to_json(t) AS data' || CHR(10)
          || ' FROM ' || quote_ident(t.table_schema) || '.' || quote_ident(t.table_name) || ' t' || CHR(10)
          || ' WHERE ' 
          || (SELECT string_agg(quote_ident(z.column_name) || '::text ~* $1', ' OR ')
               FROM information_schema.columns z
               WHERE z.table_schema = t.table_schema
                 AND z.table_name = t.table_name
                 AND (   z.data_type IN ('text', 'json', 'jsonb')
                      OR z.data_type ~* '^char')
              ) AS sql
      FROM information_schema.tables t
      WHERE t.table_schema = 'public'
        AND t.table_type = 'BASE TABLE'
      ORDER BY t.table_schema
             , t.table_name) z;
$$
LANGUAGE SQL;
