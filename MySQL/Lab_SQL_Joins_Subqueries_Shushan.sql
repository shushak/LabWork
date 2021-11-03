use sakila;

#Which actor has appeared in the most films?
select first_name,last_name, count(*) from actor as a
inner join film_actor as l on 
a.actor_id = l.actor_id
group by a.actor_id
order by count(*) desc
limit 1;

#Most active customer (the customer that has rented the most number of films)
select first_name,last_name, count(*) from customer
inner join rental on 
customer.customer_id = rental.customer_id
group by customer.customer_id
order by count(*) desc
limit 1;


#List number of films per category.
select name, count(*) from category
inner join film_category on 
category.category_id = film_category.category_id
group by film_category.category_id
order by count(*);

#4 Display the first and last names, as well as the address, of each staff member.
select first_name,last_name,address from staff
inner join address on 
staff.address_id = address.address_id
group by address.address_id
order by address.address_id;


#5 Display the total amount rung up by each staff member in August of 2005.
select first_name,last_name,sum(amount)from staff
inner join payment on 
staff.staff_id = payment.staff_id
where payment_date between 20050801 and 20050831
group by staff.staff_id
order by staff.staff_id;

#6 List each film and the number of actors who are listed for that film.
select title, count(actor_id) from film_actor
inner join film on 
film_actor.film_id = film.film_id
group by film.film_id
order by count(actor_id) desc;


#7 Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
#List the customers alphabetically by last name. Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try.

select first_name, last_name, sum(amount) from customer
inner join payment on
customer.customer_id=payment.customer_id
group by payment.customer_id
order by last_name;


select title , count(rental_date) from film 
inner join inventory on
film.film_id=inventory.film_id
inner join rental on
inventory.inventory_id=rental.inventory_id
group by title
order by count(rental_date) desc
limit 1;

#Lab | SQL Subqueries
#1 How many copies of the film Hunchback Impossible exist in the inventory system?
SELECT title, (
SELECT COUNT(*) FROM inventory
WHERE film.film_id = inventory.film_id
) AS 'Number of Copies'
FROM film
WHERE title = "Hunchback Impossible";

select title, COUNT(*) from inventory
inner join film on
film.film_id = inventory.film_id
where title = "Hunchback Impossible"
group by title
order by inventory.film_id;


#2 List all films whose length is longer than the average of all the films.

Select title, length from film
where length > (select avg(length) from film)
order by length desc;

#3 Use subqueries to display all actors who appear in the film Alone Trip.

select first_name, last_name
from actor
where actor_id in

(select actor_id
from film_actor
where film_id IN 
(
select film_id
from film
where title = 'Alone Trip'
))
 order by first_name;

#3 joins

select first_name, last_name from actor 
inner join film_actor on
actor.actor_id=film_actor.actor_id
inner join film on
film.film_id=film_actor.film_id
where title = 'Alone Trip'
group by first_name, last_name
order by first_name;


#4 Sales have been lagging among young families, and you wish to target all family movies for a promotion. 
#Identify all movies categorized as family films.

select title
from film
where film_id in

(select film_id
from film_category
where category_id in
(
select category_id
from category
where name= 'Family'
))
order by title;

#5 Get name and email from customers from Canada using subqueries. Do the same with joins. 
#Note that to create a join, you will have to identify the correct tables with their primary keys and foreign keys, 
#that will help you get the relevant information. #withsubqueries

select first_name, last_name, email
from customer
where address_id in

(select address_id
from address
where city_id in
(
select city_id
from city
where country_id in 
(
select country_id
from country
where country = 'Canada' 
)))
order by last_name;

#withjoins
select first_name, last_name, email from customer
inner join address on
customer.address_id=address.address_id
inner join city on
address.city_id=city.city_id
inner join country on
city.country_id=country.country_id
where country="Canada"
group by first_name,last_name, email
order by last_name;


#6 Which are films starred by the most prolific actor? Most prolific actor is defined as the actor that has acted in the most number of films.
#First you will have to find the most prolific actor and then use that actor_id to find the different films that he/she starred.


#getting actor id

select actor_id, first_name, last_name from actor
inner join film_actor using (actor_id)
inner join film using (film_id)
group by actor_id
order by count(film_id)
desc 
limit 1;

#getting names of films using actor_id
SELECT concat(first_name, " ", last_name) as actor_name,
    title
FROM
    actor
        INNER JOIN
    film_actor USING (actor_id)
        INNER JOIN
    film USING (film_id)
WHERE
    actor_id = (SELECT 
            actor_id
        FROM
            actor
                INNER JOIN
            film_actor USING (actor_id)
                INNER JOIN
            film USING (film_id)
        GROUP BY actor_id
        ORDER BY COUNT(film_id) DESC
        LIMIT 1);


select * from actor_info
where actor_id=107;



#7 Films rented by most profitable customer.
#You can use the customer table and payment table to find the most profitable customer ie the customer that has made the largest sum of payments

select customer_id from customer
where first_name = ('Karl') and last_name=('Seal');

select * from film_list
where customer_id=526;
############


SELECT concat(first_name, " ", last_name) as customer_name,
    title
FROM
    customer
        INNER JOIN
    payment USING (customer_id)
        INNER JOIN
    rental USING (rental_id)
		INNER JOIN 
        inventory using (inventory_id)
        INNER JOIN
        film using (film_id)
WHERE
    customer.customer_id = 526
    order by title;


#8 Customers who spent more than the average payments.
