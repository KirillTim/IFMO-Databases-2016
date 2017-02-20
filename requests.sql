--best vendors
SELECT
  vendor_id,
  count(vendor_id) AS best_offers
FROM vendors
  JOIN vendorssell ON vendors.id = vendorssell.vendor_id
  JOIN (SELECT
          id,
          min(price) AS price
        FROM components
          JOIN vendorssell ON components.id = vendorssell.component_id
        GROUP BY id) AS min_price ON min_price.id = vendorssell.component_id AND min_price.price = vendorssell.price
GROUP BY vendor_id
ORDER BY best_offers DESC;
--most important service company

--average salary by gender

--worker with the biggest set of skills

--workers `uniqueness`

--components sorted by profit