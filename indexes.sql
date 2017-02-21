--no need
--CREATE INDEX ON machineservicevendor USING BTREE (service_vendor, machine);
--CREATE INDEX ON machineservicevendor USING BTREE (machine, service_vendor);

CREATE INDEX ON staff USING BTREE (first_name, second_name);
CREATE INDEX ON staff USING BTREE (second_name, first_name);

CREATE INDEX ON buildsteps USING BTREE (result_component);
CREATE INDEX ON buildsteps USING BTREE (machine);

CREATE INDEX ON components USING BTREE (name);
CREATE INDEX ON components USING BTREE (build_step);

CREATE INDEX ON vendorssell USING BTREE (price);