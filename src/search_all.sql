CREATE OR REPLACE FUNCTION search_all (p_text IN text)
RETURNS TABLE (table_schema text, table_name text, data json)
AS
$$
  DECLARE
    l_sql text;
  BEGIN
    l_sql := gen_search_all();
    RETURN QUERY EXECUTE l_sql USING p_text;
  END;
$$
LANGUAGE PLPGSQL;
