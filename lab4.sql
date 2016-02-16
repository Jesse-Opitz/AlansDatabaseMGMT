-- Jesse Opitz --

-- 1) Gives cities of agents booking an order for a customer
-- whos cid is 'c002'
SELECT city 
FROM agents 
WHERE aid in ( SELECT aid 
               FROM orders 
               WHERE cid = 'c002' 
             );
             
-- 2) Gives ids of products ordered through any agent who  
-- takes at least one order from a customer in Dallas, 
-- sorted by pid from highest to lowest
SELECT pid 
FROM orders
WHERE aid in ( SELECT aid 
               FROM orders 
               WHERE cid in( SELECT cid 
                             FROM customers 
                             WHERE city = 'Dallas'
                           )
             )
ORDER BY pid DESC;

-- 3) Gives the ids and names of customers who did not place
-- an order through agent a01
SELECT cid, name 
FROM customers 
WHERE cid not in ( SELECT cid 
                   FROM orders 
                   WHERE aid = 'a01'
                 );

-- 4) Gives the ids of customers who ordered both product
-- p01 and p07
SELECT DISTINCT cid 
FROM orders 
WHERE cid in ( SELECT cid 
               FROM orders 
               WHERE pid = 'p01'
                   intersect
               SELECT cid
               FROM orders 
               WHERE pid = 'p07'
             );

-- 5) Gives the ids of products not ordered by any customers
-- who placed any order through agent a07 in pid order from
-- highest to lowest
SELECT pid
FROM orders 
WHERE cid in ( SELECT cid 
		FROM orders 
		WHERE aid != 'a07'
             )
ORDER BY pid DESC;

-- 6) Gives the name, discounts and city for all customers
-- who place orders through agents in London or New York
SELECT name, discount, city 
FROM customers 
WHERE cid in ( SELECT cid 
               FROM orders
               WHERE aid in (SELECT aid 
                             FROM agents
                             WHERE city in('London', 'New York')
                            )
             );

-- 7) Gives all customers who have the same discount as that of
-- any customers in Dallas or London
SELECT * 
FROM customers 
WHERE cid in ( SELECT cid 
               FROM customers 
               WHERE discount in ( SELECT discount
                                   FROM customers
                                   WHERE city in('Dallas', 'London')
                                 ) 
             );

-- 8)
--
-- A check constraint is a limiting factor on the value
-- entered into each column.  It checks to make sure the 
-- value satisfies the requirement set by the rule you've
-- told the column to follow.  For example, a sales price
-- should have a constraint saying that the price is greater
-- than 0.00 because the employer shouldn't be paying people to
-- take their products.  This is an example of a good
-- constraint because it limits the room for error.  An 
-- example of a bad constraint would be to say the price
-- must be less than 50.00.  This is a bad constraint because
-- it would cause problems with an item that has a higher
-- price than 50.00.  For example, if the item is 50.01,
-- then the database wouldn't accept the entry and it would
-- cause an error.  Furthermore, it would caus a loss of data
-- and the database could be consider invalid.  Bad constraints
-- cause issues in the database that can be easily avoided.
--

