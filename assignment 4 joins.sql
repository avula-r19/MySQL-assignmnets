USE sakila;

#1. List all customers along with the films they have rented.
SELECT c.customer_id,c.first_name,c.last_name,f.title,r.rental_id
FROM customer c 
INNER JOIN rental r 
ON c.customer_id=r.customer_id
INNER JOIN inventory i   
ON i.inventory_id=r.inventory_id
INNER JOIN film f
ON f.film_id=i.film_id;

#2. List all customers and show their rental count, including those who haven't rented any films.
SELECT c.customer_id,c.first_name,c.last_name, COUNT(rental_id)
FROM customer c 
LEFT JOIN rental r 
ON c.customer_id=r.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name;

#3. Show all films along with their category. Include films that don't have a category assigned.
SELECT f.film_id,f.title,fc.category_id,c.name
FROM film f 
LEFT JOIN film_category fc 
ON f.film_id=fc.film_id
LEFT JOIN category c 
ON fc.category_id=c.category_id;

#4. Show all customers and staff emails from both customer and staff tables using a full outer join (simulate using LEFT + RIGHT + UNION).
SELECT c.email AS customer_email, s.email AS staff_mail
FROM customer c 
LEFT JOIN staff s 
ON c.store_id=s.store_id
UNION
SELECT c.email AS customer_email, s.email AS staff_mail
FROM customer c 
RIGHT JOIN staff s 
ON c.store_id=s.store_id;

#5. Find all actors who acted in the film "ACADEMY DINOSAUR".
SELECT a.actor_id,a.first_name,a.last_name,f.film_id,f.title
FROM actor a 
INNER JOIN film_actor fa 
ON a.actor_id=fa.actor_id
INNER JOIN film f 
ON f.film_id=fa.film_id
WHERE f.title='ACADEMY DINOSAUR';

#6. List all stores and the total number of staff members working in each store, even if a store has no staff.
SELECT s.store_id, COUNT(st.staff_id) AS number_of_staffmem
FROM store s  
LEFT JOIN staff st 
ON s.store_id=st.store_id
GROUP BY s.store_id;

#7. List the customers who have rented films more than 5 times. Include their name and total rental count.
SELECT c.customer_id,c.first_name,c.last_name, COUNT(r.rental_id) AS total_rental_count
FROM rental r 
INNER JOIN customer c 
ON c.customer_id=r.customer_id
GROUP BY c.customer_id,c.first_name,c.last_name
HAVING COUNT(r.rental_id) > 5;












