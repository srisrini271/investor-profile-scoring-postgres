/*
Generates a unique prefixed random value.
Keeps retrying until a unique value is found.
*/

CREATE OR REPLACE FUNCTION generate_random_number(
 p_prefix TEXT,
 p_table TEXT,
 p_column TEXT,
 p_length INT
)
RETURNS TEXT
LANGUAGE plpgsql
AS $$
DECLARE
 v_code TEXT;
 v_count INT;
BEGIN
 LOOP
   v_code := p_prefix ||
     lpad((trunc(random()*1e10))::TEXT,
          p_length - length(p_prefix), '0');

   EXECUTE format(
     'SELECT COUNT(*) FROM %I WHERE %I = $1',
     p_table, p_column
   ) INTO v_count USING v_code;

   EXIT WHEN v_count = 0;
 END LOOP;

 RETURN v_code;
END;
$$;
