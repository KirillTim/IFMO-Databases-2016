CREATE OR REPLACE FUNCTION assign_support_contract(INT, INT [])
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