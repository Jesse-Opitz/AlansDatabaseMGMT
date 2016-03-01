-- Jesse Opitz --

-- 1) Name and city of customers who live in any city that
-- makes the most different kinds of products
SELECT name, city
FROM customers
WHERE customers.city in ( SELECT city
                          FROM products
                          GROUP BY city
                          ORDER BY count(pid) DESC
                          LIMIT 1
                        );

-- 2) Names of products whose priceUSD is strictly above the
-- average priceUSD, in reverse-alphabetical order
SELECT name
FROM products
GROUP BY name,
         priceUSD
HAVING (SELECT AVG(priceUSD) 
        FROM products) < priceUSD;

-- 3) Customer name, pid ordered, and the total for all orders,
-- sorted by total from high to low
SELECT customers.name, orders.pid, SUM(orders.totalusd) as totalusdSUM
FROM orders INNER JOIN customers ON customers.cid = orders.cid
GROUP BY customers.name, orders.pid
ORDER BY totalusdSUM DESC;

-- 4) All customer names(in alphabetical order) and their total 
-- ordered without showing NULLs
SELECT customers.name, COALESCE(sum(orders.totalusd), 0.00)
FROM orders FULL OUTER JOIN customers ON customers.cid = orders.cid
GROUP BY customers.name
ORDER BY customers.name ASC;

-- 5) Names of all customers who bought products from agents
-- based in Tokyo along with the names of the products they 
-- ordered, and the names of the agents who sold it to them
SELECT customers.name, products.name, agents.name, agents.aid
FROM customers INNER JOIN orders ON customers.cid=orders.cid
INNER JOIN agents ON agents.aid=orders.aid
INNER JOIN products ON products.pid=orders.pid
WHERE orders.cid IN ( SELECT orders.cid
                      FROM orders INNER JOIN customers ON orders.cid=customers.cid
                      INNER JOIN agents ON orders.aid=agents.aid
                      WHERE orders.aid = ( SELECT aid
                                           FROM agents
                                           WHERE city='Tokyo'
                                         )
                    );

-- 6) Check the accuracy of the dollars column in the Orders
-- table.
SELECT *
FROM orders
WHERE (totalusd, ordnum) NOT IN ( SELECT ((products.priceusd*orders.qty) - ((products.priceusd * orders.qty)*(customers.discount/100))) as totalusd, orders.ordnum
                                  FROM orders INNER JOIN customers ON orders.cid = customers.cid
                                  INNER JOIN products ON orders.pid = products.pid
                                );


-- 7) What's the difference between a LEFT OUTER JOIN and a 
-- RIGHT OUTER JOIN?
--
-- A left outer join references the table to the left of the
-- join.  However, a right outer join references the table to
-- the right of the join. Furthermore, the left outer join will
-- pull nulls only from the table on the left side of the join,
-- while the right outer join will pull nulls only from the table
-- on the right side of the join.

