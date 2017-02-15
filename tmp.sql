--TRIGGERS
DROP TRIGGER IF EXISTS check_service_available_coverage
ON servicevendors;
DROP TRIGGER IF EXISTS check_service_available_coverage
ON machineservicevendor;

DROP TRIGGER IF EXISTS test_trig
ON servicevendors;
DROP FUNCTION IF EXISTS test();


CREATE FUNCTION test()
  RETURNS TRIGGER AS $$
BEGIN
  RAISE EXCEPTION 'wtf %, %', (SELECT count(*)
                               FROM servicevendors), old;
  --RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER test_trig BEFORE DELETE ON servicevendors FOR EACH ROW
EXECUTE PROCEDURE test();

CREATE OR REPLACE FUNCTION fun_check_service_available_coverage()
  RETURNS TRIGGER AS $$
DECLARE
  companies_count INTEGER;
  BEGIN
  SELECT count(*) INTO companies_count FROM machineservicevendor where machine=OLD.machine GROUP BY machine;
  RAISE EXCEPTION 'count: %', companies_count;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER tmp BEFORE DELETE OR UPDATE on machineservicevendor FOR EACH ROW EXECUTE PROCEDURE fun_check_service_available_coverage();

CREATE OR REPLACE FUNCTION assign_support_contract(INT, INT [])
  RETURNS VOID AS
$$
DECLARE
  vendor ALIAS FOR $1;
  list ALIAS FOR $2;
  rec RECORD;
  rv  INTEGER;
BEGIN
  rv = 0;
  FOR rec IN SELECT id FROM machines WHERE id = ANY (list)
  LOOP
    INSERT INTO machineservicevendor (service_vendor, machine) VALUES (vendor, rec.id);
  END LOOP;
  RETURN;
END
$$ LANGUAGE plpgsql;

SELECT *
FROM assign_support_contract(1, '{1,2}' :: INT []);

--CREATE TRIGGER check_service_available_coverage BEFORE DELETE ON servicevendors
--EXECUTE PROCEDURE fun_check_service_available_coverage();

--CREATE TRIGGER check_service_available_coverage BEFORE UPDATE OR DELETE ON machineservicevendor
--EXECUTE PROCEDURE fun_check_service_available_coverage();