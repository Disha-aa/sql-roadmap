SELECT 
    cust_id,
    cust_type_cd, 
    SPLIT_PART(TRIM(address), ' ', 1) AS building_no,
    CASE
        WHEN STRPOS(TRIM(ADDRESS), ' ') > 0
        THEN SUBSTR(TRIM(ADDRESS), STRPOS(TRIM(address), ' ') + 1)
        ELSE NULL
    END AS street_name,
    CASE
        WHEN cust_type_cd = 'I' THEN
            '***-**-' || RIGHT(fed_id, 4)
        WHEN cust_type_cd = 'B' THEN
            LEFT(fed_id, 2) || '-*****' || RIGHT(fed_id, 2)
        ELSE fed_id
    END AS masked_fed_id
    
FROM customer
LIMIT 10;
