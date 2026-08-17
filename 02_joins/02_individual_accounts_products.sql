SELECT a.account_id, c.fed_id, p.name as product_name
FROM account a INNER JOIN customer c
    ON a.cust_id = c.cust_id
    INNER JOIN product p
        ON a.product_cd = p.product_cd
WHERE c.cust_type_cd = 'I';