--Add real data
INSERT INTO machines(id, name, work_stations) VALUES (1, 'machine for engine', 1);
INSERT INTO machines(id, name, work_stations) VALUES (2, 'machine for oil pipe', 1);
INSERT INTO machines(id, name, work_stations) VALUES (3, 'machine for anything', 5);

INSERT INTO staff(id, first_name, second_name, hourly_wage, gender) VALUES (1, 'Ivan', 'Ivanov', 300, 'Male');
INSERT INTO staff(id, first_name, second_name, hourly_wage, gender) VALUES (2, 'Petr', 'Petrov', 400, 'Male');
INSERT INTO staff(id, first_name, second_name, hourly_wage, gender) VALUES (3, 'Sidr', 'Sidrov', 500, 'Male');
INSERT INTO staff(id, first_name, second_name, hourly_wage, gender) VALUES (4, 'Stas', 'Michailov', 350, 'Male');
INSERT INTO staff(id, first_name, second_name, hourly_wage, gender) VALUES (5, 'Anna', 'Ivanova', 600, 'Female');

INSERT INTO staffcanworkon(staff_id, machine_id) VALUES (1, 1);
INSERT INTO staffcanworkon(staff_id, machine_id) VALUES (2, 2);
INSERT INTO staffcanworkon(staff_id, machine_id) VALUES (3, 2);
INSERT INTO staffcanworkon(staff_id, machine_id) VALUES (4, 3);
INSERT INTO staffcanworkon(staff_id, machine_id) VALUES (5, 3);

INSERT INTO servicevendors(id, name, contact_info) VALUES (1, 'vendor1', 'contact');
INSERT INTO servicevendors(id, name, contact_info) VALUES (2, 'vendor2', 'contact');

SELECT * FROM add_support_contract(1, ARRAY [1,2]);
SELECT * FROM add_support_contract(2, ARRAY [2,3]);

INSERT INTO components(id, name) VALUES (1, 'spark plugs');
INSERT INTO components(id, name, sell_price) VALUES (2, 'engine', 1000);
INSERT INTO components(id, name) VALUES (3, 'oil pipe');
INSERT INTO components(id, name) VALUES (4, 'small rubber pipe');
INSERT INTO components(id, name) VALUES (5, 'main component #1');
INSERT INTO components(id, name) VALUES (6, 'main component #2');

INSERT INTO buildplans(name, description) VALUES ('engine build plan', '');

INSERT INTO vendors(name) VALUES ('vendor #1');
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(1, 1, 20);
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(1, 3, 10);
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(1, 4, 50);

INSERT INTO vendors(name) VALUES ('vendor #2');
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(2, 4, 25);
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(2, 5, 200);
INSERT INTO vendorssell(vendor_id, component_id, price) VALUES(2, 6, 250);

