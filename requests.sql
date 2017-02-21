--best vendors
SELECT
  vendor_id, name,
  count(vendor_id) AS best_offers
FROM vendors
  JOIN vendorssell ON vendors.id = vendorssell.vendor_id
  JOIN (SELECT
          id,
          min(price) AS price
        FROM components
          JOIN vendorssell ON components.id = vendorssell.component_id
        GROUP BY id) AS min_price ON min_price.id = vendorssell.component_id AND min_price.price = vendorssell.price
GROUP BY (vendor_id, name)
ORDER BY best_offers DESC;

--most important service company
SELECT
  servicevendors.id, servicevendors.name,
  count(*)          AS last_vendor_for_machines_count
FROM servicevendors
  JOIN machineservicevendor ON servicevendors.id = machineservicevendor.service_vendor
  JOIN

  (SELECT
     id,
     count(*) AS cnt
   FROM machines
     JOIN machineservicevendor ON machines.id = machineservicevendor.machine
   GROUP BY id) AS C ON C.id = machineservicevendor.machine
WHERE C.cnt = 1
GROUP BY servicevendors.id
ORDER BY last_vendor_for_machines_count DESC
LIMIT 1;

--average salary by gender
SELECT gender, avg(hourly_wage::NUMERIC)::money FROM staff GROUP BY gender;

--components sorted by profit
