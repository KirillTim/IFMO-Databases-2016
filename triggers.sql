CREATE OR REPLACE FUNCTION fun_check_service_coverage()
  RETURNS TRIGGER AS $$
DECLARE
  companies_count INTEGER;
BEGIN
  SELECT count(*)
  INTO companies_count
  FROM machineservicevendor
  WHERE machine = old.machine
  GROUP BY machine;
  IF companies_count = 1
  THEN
    RAISE EXCEPTION 'can not drop last service vendor for `%`, id: %', (SELECT name
                                                                        FROM machines
                                                                        WHERE id = old.machine), old.machine;
  END IF;
  RAISE INFO 'count % before deletion for %', companies_count, old.machine;
  RETURN new;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_service_coverage
ON machineservicevendor;
CREATE TRIGGER check_service_coverage
BEFORE DELETE OR UPDATE ON machineservicevendor
FOR EACH ROW EXECUTE PROCEDURE fun_check_service_coverage();

CREATE OR REPLACE FUNCTION fun_check_dependencies()
  RETURNS TRIGGER AS $$
BEGIN
  IF NOT can_use_component(new.component)
  THEN
    RAISE EXCEPTION 'component ' % ', id: % cant be used', (SELECT name
                                                            FROM components
                                                            WHERE id = new.component), new.component;
  END IF;
  RETURN new;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS check_dependencies
ON buildstepdependencies;
CREATE TRIGGER check_dependencies
BEFORE INSERT OR UPDATE ON buildstepdependencies
FOR EACH ROW EXECUTE PROCEDURE fun_check_dependencies();