-- Jesse Opitz --


-- 1) Cities of agents booking an order for a 
-- customer whose id is 'c002'; No subqueries
SELECT city
FROM agents,
     orders
WHERE orders.cid = 'c002';



-- 2) pid of products ordered through any agent
-- who makes at least 1 order for a customer in Dallas, 
-- ordered by pid descending; No subqueries
SELECT DISTINCT orders.pid
FROM agents INNER JOIN orders ON agents.aid=orders.aid
INNER JOIN customers ON orders.cid=customers.cid
WHERE customers.city = 'Dallas'
ORDER BY orders.pid DESC;



-- 3) Names of customers who have never placed an 
-- order; Using subqueries
SELECT name
FROM customers
WHERE cid not in ( SELECT cid
                   FROM orders
                 );



-- 4) Names of customres who have never placed an
-- order; Use an outer join
SELECT customers.name
FROM orders full outer join customers on orders.cid=customers.cid
WHERE orders.cid is null;



-- 5) Names of customers who placed at least one
-- order through an agent in their own city, along
-- with those agent(s') names
SELECT customers.name, agents.name, customers.city
FROM customers,
     agents
WHERE customers.city=agents.city



-- 6) Names of customers and agents living in the
-- same city, along with the name of the shared city,
-- regardless of whether or not the customer has ever
-- placed an order with that agent
SELECT *
FROM customers c,
     agents a
WHERE c.city = a.city;



-- 7) Name and city of customers who live in the city
-- that makes the fewest different kinds of products
SELECT name, city
FROM customers
WHERE customers.city in ( SELECT city
                          FROM products
                          GROUP BY city
                          ORDER BY count(pid) ASC
                          LIMIT 1
                         );



