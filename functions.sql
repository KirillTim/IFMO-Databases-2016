CREATE OR REPLACE FUNCTION add_support_contract(INT, INT [])
  RETURNS VOID AS
$$
DECLARE
  vendor ALIAS FOR $1;
  machines_list ALIAS FOR $2;
  rec RECORD;
BEGIN
  FOR rec IN SELECT id
             FROM machines
             WHERE id = ANY (machines_list)
  LOOP
    INSERT INTO machineservicevendor (service_vendor, machine) VALUES (vendor, rec.id);
  END LOOP;
  RETURN;
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION is_enough_staff_for_machine(INT)
  RETURNS BOOLEAN AS
$$
DECLARE
  machine ALIAS FOR $1;
  have   INT;
  needed INT;
BEGIN
  SELECT count(*)
  INTO have
  FROM staff
    JOIN staffcanworkon ON staff.id = staffcanworkon.staff_id
  WHERE staffcanworkon.machine_id = machine;
  SELECT work_stations into needed from machines where machines.id = machine;
  RETURN (have >= needed);
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add_build_step(INT, INT, INT, INT, INT [])
  RETURNS VOID AS
$$
DECLARE
  result ALIAS FOR $1;
  machine_id ALIAS FOR $2;
  hours ALIAS FOR $3;
  plan_id ALIAS FOR $4;
  dependencies ALIAS FOR $5;
  cnt INT;
  d   INT;
BEGIN
  --cnt := array_length(array_agg(DISTINCT dependencies), 1);
  cnt := array_length(dependencies, 1);
  --SELECT count(*) INTO cnt FROM components WHERE id = ANY(dependencies);
  FOREACH d IN ARRAY dependencies LOOP
    IF NOT exists(SELECT 1
                  FROM components
                  WHERE id = d)
    THEN
      RAISE EXCEPTION 'unknown component id: %', d;
    END IF;
  END LOOP;

  RAISE INFO 'count= %', cnt;
END
$$ LANGUAGE plpgsql;