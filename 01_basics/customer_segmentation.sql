SELECT cust_id, city, address
FROM customer
WHERE cust_type_cd = 'I'
    AND (city LIKE 'C%' OR city LIKE 'S%')
    AND cust_id NOT IN (
        SELECT cust_id
        FROM 'account'
        WHERE product_cd IN ('SAV', 'CHK')
    );