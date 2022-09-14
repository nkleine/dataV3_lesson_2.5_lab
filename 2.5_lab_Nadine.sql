-- LAB 2.5 Nadine

-- TASK 1. Select all the actors with the first name ‘Scarlett’.
SELECT first_name FROM sakila.actor
WHERE first_name='Scarlett';
-- Answer: 2

-- TASK 2. How many films (movies) are available for rent and how many films have been rented?
SELECT COUNT(title) FROM sakila.film; 
-- 1000 different films are available
SELECT COUNT(inventory_id) FROM sakila.inventory;
-- 4581 films are in the inventory (so probably some films with more than one copy each)
SELECT COUNT(rental_date) FROM sakila.rental;
-- 16044 rentals so far
SELECT COUNT(return_date) FROM sakila.rental;
-- 15861 returns so far
SELECT COUNT(rental_date)-COUNT(return_date) FROM sakila.rental;
-- Answer: 183 current rentals

-- TASK 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT MIN(length) AS 'min_duration' FROM sakila.film;
-- Answer: 46 min
SELECT MAX(length) AS 'max_duration' FROM sakila.film;
-- Answer: 185 min

-- TASK 4. What's the average movie duration expressed in format (hours, minutes)?
SELECT AVG(length)%60 FROM sakila.film;
-- 115,2720 Minutes --> 1,92h --> 1h 55,2720 minutes
SELECT concat(floor((AVG(length))/60),":",round((AVG(length))%60,0)) AS "average_length" FROM sakila.film;

-- TASK 5. How many distinct (different) actors' last names are there?
SELECT COUNT(DISTINCT last_name) FROM sakila.actor;
-- Answer: 121 distinct actor's last names

-- TASK 6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT MIN(rental_date) AS 'first_date' FROM sakila.rental;
SELECT MAX(rental_date) AS 'last_date' FROM sakila.rental;
SELECT DATEDIFF ((MAX(rental_date)), (MIN(rental_date))) FROM sakila.rental; 
-- Answer: 266 days

-- TASK 7. Show rental info with additional columns month and weekday. Get 20 results.
SELECT *, SUBSTR(rental_date,6,2) AS 'month', DAYNAME(rental_date) AS 'weekday' 
FROM sakila.rental
LIMIT 20;

-- TASK 8. Add an additional column day_type with values 'weekend' and 'workday' 
-- depending on the rental day of the week.
SELECT *,
CASE
WHEN DAYNAME(rental_date) = 'Monday' then 'Workday'
WHEN DAYNAME(rental_date) = 'Tuesday' then 'Workday'
WHEN DAYNAME(rental_date) = 'Wednesday' then 'Workday'
WHEN DAYNAME(rental_date) = 'Thursday' then 'Workday'
WHEN DAYNAME(rental_date) = 'Friday' then 'Workday'
WHEN DAYNAME(rental_date) = 'Saturday' then 'Weekend'
WHEN DAYNAME(rental_date) = 'Sunday' then 'Weekend'
ELSE 'No info'
END AS 'day_type', DAYNAME(rental_date) AS 'weekday'
FROM sakila.rental;

-- TASK 9. Get release years.
SELECT title, release_year as 'release years' FROM sakila.film;
-- I added the title to the release year, because otherwise the information is not helpful. 

-- TASK 10. Get all films with ARMAGEDDON in the title.
SELECT DISTINCT title FROM sakila.film
WHERE title LIKE '%ARMAGEDDON%';
-- answer: 6 films

-- TASK 11. Get all films which title ends with APOLLO.
SELECT DISTINCT title FROM sakila.film
WHERE title LIKE '%APOLLO';
-- answer: 5 films

-- TASK 12. Get 10 the longest films.
SELECT title, length FROM sakila.film
ORDER BY length DESC
LIMIT 10;

-- TASK 13. How many films include Behind the Scenes content?
SELECT title, special_features FROM sakila.film
WHERE special_features='Deleted Scenes,Behind the Scenes' 
OR 'Commentaries,Behind the Scenes' 
OR 'Trailers,Deleted Scenes,Behind the Scenes'
OR 'Trailers,Commentaries,Behind the Scenes'
OR 'Trailers,Behind the Scenes'
OR 'Commentaries,Deleted Scenes,Behind the Scenes'
OR 'Trailers,Commentaries,Deleted Scenes,Behind the Scenes'
OR 'Behind the Scenes';
-- answer: 71 films - could not find an easier way than manually tip in the possible special_features