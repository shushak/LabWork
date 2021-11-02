use sakila;
#Which actor has appeared in the most films?
select firs_name, last_name, count(*) from film_actor as a
inner join film as l on
a.actor_id = l.actor_id
group by a.actor_id
order by count(*) desc
limit 1;
#Most active customer (the customer that has rented the most number of films)
select firs_name, last_name, count(*) from customer
inner join rental on
customer.customer_id = rental.customer_id
group by customer_id
order by count(*) desc
limit 1;

#List number of films per category.
select title, category_id count (*) from film
inner join film_category on
category.category_id=film_cateory.category_id
group by film_cateory.category_id
order by count (*);

#Display the first and last names, as well as the address, of each staff member.
select first_name, last_name, address from staff
inner join address on
staff.address_id=address.address_id
group by address.address_id
order by address.address_id

#Display the total amount rung up by each staff member in August of 2005.
select first_name, last_name, sum(amout) from staff
inner join payment on
staff.staff_id=payment.staff_id
group by staff.staff_id
order by staff.staff_id

#List each film and the number of actors who are listed for that film.
select title, count(actor_id) from film_actor
inner join film on
film_actor.film_id=film.film_id
group by film.film_id
having count(actor_id)
order by film.film_id;


#Using the tables payment and customer and the JOIN command, list the total paid by each customer. 
#List the customers alphabetically by last name. Bonus: Which is the most rented film? The answer is Bucket Brotherhood This query might require using more than one join statement. Give it a try.

select first_name, last_name, sum(amount) from customer
inner join payment on
customer.customer_id=payment.customer_id
group by payment.customer_id
order by last_name;
