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
  SELECT work_stations
  INTO needed
  FROM machines
  WHERE machines.id = machine;
  RETURN (have >= needed);
END
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add_build_step(INT, INT, INT, INT, INT [])
  RETURNS VOID AS
$$
DECLARE
  result ALIAS FOR $1;
  machine_id ALIAS FOR $2;
  hours_ ALIAS FOR $3;
  plan_id ALIAS FOR $4;
  dependencies ALIAS FOR $5;
  d       INT;
  step_id INT;
BEGIN
  FOREACH d IN ARRAY dependencies LOOP
    IF NOT exists(SELECT 1
                  FROM components
                  WHERE id = d)
    THEN
      RAISE EXCEPTION 'unknown component id: %', d;
    END IF;
  END LOOP;
  IF NOT is_enough_staff_for_machine(machine_id)
  THEN
    RAISE EXCEPTION 'not enough workers for for `%`, id: %', (SELECT name
                                                              FROM machines
                                                              WHERE id = machine_id), machine_id;
  END IF;
  INSERT INTO buildsteps (result_component, machine, hours, plan) VALUES (result, machine_id, hours_, plan_id)
  RETURNING id
    INTO step_id;
  FOREACH d IN ARRAY dependencies LOOP
    INSERT INTO buildstepdependencies (step, component) VALUES (step_id, d);
  END LOOP;
END
$$ LANGUAGE plpgsql;