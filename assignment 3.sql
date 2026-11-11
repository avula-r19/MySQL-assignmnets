use sakila;
# 1. display all customer details who have made more than 5 payments. (1-5 subquery)
SELECT *
FROM customer
WHERE customer_id 
IN 
(
    SELECT customer_id
    FROM payment
    GROUP BY customer_id
    HAVING COUNT(payment_id) > 5
);
# 2. Find the names of actors who have acted in more than 10 films.
SELECT actor_id,first_name, last_name
FROM actor
WHERE actor_id IN (
    SELECT actor_id
    FROM film_actor
    GROUP BY actor_id
    HAVING COUNT(film_id) > 10
);
#3. Find the names of customers who never made a payment.
SELECT customer_id, first_name, last_name
FROM customer
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM payment
    WHERE customer_id IS NOT NULL
);
#4. List all films whose rental rate is higher than the average rental rate of all films.
SELECT title, rental_rate
FROM film
WHERE rental_rate > (
    SELECT AVG(rental_rate)
    FROM film
);
#5. List the titles of films that were never rented.
SELECT film_id, title
FROM film
WHERE film_id NOT IN (
    SELECT DISTINCT i.film_id
    FROM inventory i
    JOIN rental r
        ON i.inventory_id = r.inventory_id
);
#6.Display the customers who rented films in the same month as customer with ID 5. CTE 6,7,8
WITH cte AS ( #cte as cte name 
    SELECT DISTINCT MONTH(rental_date) AS month
    FROM rental
    WHERE customer_id = 5
)
SELECT DISTINCT c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN cte ON MONTH(r.rental_date) = cte.month
WHERE c.customer_id <> 5; 
#7. Find all staff members who handled a payment greater than the average payment amount.
WITH cte AS (
    SELECT AVG(amount) AS avg_amount
    FROM payment
)
SELECT DISTINCT s.first_name, s.last_name
FROM staff s
JOIN payment p ON s.staff_id = p.staff_id
JOIN cte ON p.amount > cte.avg_amount;
#8. Show the title and rental duration of films whose rental duration is greater than the average.
WITH cte AS (
    SELECT AVG(rental_duration) AS avg_duration
    FROM film
)
SELECT f.title, f.rental_duration
FROM film f
JOIN cte ON f.rental_duration > cte.avg_duration;
#9. Find all customers who have the same address as customer with ID 1. temp 
CREATE TEMPORARY TABLE temp AS
SELECT address_id
FROM customer
WHERE customer_id = 1;

SELECT c.first_name, c.last_name
FROM customer c
JOIN temp t ON c.address_id = t.address_id
WHERE c.customer_id <> 1;

SELECT * FROM temp;
#DROP TEMPORARY TABLE temp;
#10. List all payments that are greater than the average of all payments.
CREATE OR REPLACE VIEW avg_payments AS
SELECT *
FROM payment
WHERE amount > (
    SELECT AVG(amount)
    FROM payment
);

SELECT * FROM avg_payments;


























