-- Jesse Opitz
-- Lab 10: Stored Procedure

-- 1) Returns the immediate prerequisites for the passed-in course number
CREATE OR REPLACE function PreReqsFor (cursorNum INT)
returns INT
as $$
declare 
   preReq INT;
   resultSet refcursor;
BEGIN
   Open resultSet for
     SELECT preReqNum
     FROM Prerequisites
     WHERE courseNum = cursorNum;
   return resultSet;
END;
$$
Language PLPGSQL;

SELECT PreReqsFor(499);

-- 2) Returns the courses for which the passed-in course number is an immediate
-- pre-requisite
CREATE OR REPLACE function isPreReqsFor (preReq INT)
returns INT
as $$
declare 
   cursorNum INT;
   resultSet refcursor;
BEGIN
   Open resultSet for
     SELECT courseNum
     FROM Prerequisites
     WHERE preReqNum = preReq;
   return resultSet;
END;
$$
Language PLPGSQL;

SELECT isPreReqsFor(308);
