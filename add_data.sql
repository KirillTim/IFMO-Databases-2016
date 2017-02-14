--Add real data
INSERT INTO machines(name, work_stations) VALUES ('machine for engine', 1);
INSERT INTO machines(name, work_stations) VALUES ('machine for oil pipe', 1);
INSERT INTO machines(name, work_stations) VALUES ('machine for anything', 5);

INSERT INTO staff(first_name, second_name, hourly_wage, gender) VALUES ('Ivan', 'Ivanov', 300, 'Male');
INSERT INTO staff(first_name, second_name, hourly_wage, gender) VALUES ('Petr', 'Petrov', 400, 'Male');
INSERT INTO staff(first_name, second_name, hourly_wage, gender) VALUES ('Sidr', 'Sidrov', 500, 'Male');
INSERT INTO staff(first_name, second_name, hourly_wage, gender) VALUES ('Stas', 'Michailov', 350, 'Male');
INSERT INTO staff(first_name, second_name, hourly_wage, gender) VALUES ('Anna', 'Ivanova', 600, 'Female');

INSERT INTO servicevendors(name, contact_info) VALUES ('vendor1', 'contact');
INSERT INTO servicevendors(name, contact_info) VALUES ('vendor2', 'contact');

INSERT INTO machineservicevendor(service_vendor, machine) VALUES (1,1);
INSERT INTO machineservicevendor(service_vendor, machine) VALUES (1,2);
INSERT INTO machineservicevendor(service_vendor, machine) VALUES (2,2);

INSERT INTO components(name) VALUES ('spark plugs');
INSERT INTO components(name, sell_price) VALUES ('engine', 1000);
INSERT INTO components(name) VALUES ('oil pipe');
INSERT INTO components(name) VALUES ('small rubber pipe');
INSERT INTO components(name) VALUES ('main component #1');
INSERT INTO components(name) VALUES ('main component #2');

INSERT INTO buildplans(name, description) VALUES ('engine build plan', '');

INSERT INTO vendors(name) VALUES ('vendor #1');
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(1, 1, 20);
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(1, 3, 10);
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(1, 4, 50);

INSERT INTO vendors(name) VALUES ('vendor #2');
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(2, 4, 25);
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(2, 5, 200);
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(2, 6, 250);
