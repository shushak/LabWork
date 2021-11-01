use bank;
#Q1 Get the id values of the first 5 clients from district_id with a value equals to 1.
select client_id from client where district_id=1 limit 5;
#Q2 In the client table, get an id value of the last client where the district_id equals to 72.
select client_id from client where district_id=72 order by client_id desc limit 1;
#Q3 Get the 3 lowest amounts in the loan table.
select amount from loan order by amount limit 3;
#Q4 What are the possible values for status, ordered alphabetically in ascending order in the loan table?
select distinct status from loan order by status asc;
#Q5 What is the loan_id of the highest payment received in the loan table?
select loan_id from loan order by payments desc limit 1;
#Q6 What is the loan amount of the lowest 5 account_ids in the loan table? Show the account_id and the corresponding amount
select account_id, amount from loan order by account_id asc limit 5;
#Q7 What are the account_ids with the lowest loan amount that have a loan duration of 60 in the loan table;
select account_id from loan where duration=60 order by amount limit 5;
#Q8 What are the unique values of k_symbol in the order table;
select distinct(k_symbol) from `order` limit 5;
#Q9 In the order table, what are the order_ids of the client with the account_id 34?;
select order_id from `order` where account_id=34;
#Q10 In the order table, which accounts were responsible for orders between order_id 29540 and order_id 29560 (inclusive)?
select distinct(account_id) from `order` where order_id between 29540 and 29560;
#Q11, In the order table, what are the individual amounts that were sent to (account_to) id 30067122?
select amount from `order` where account_to=30067122;
#Q12 In the trans table, show the trans_id, date, type and amount of the 10 first transactions from account_id 793 in chronological order, from newest to oldest;
select trans_id, date, type, amount from trans where account_id=793 order by date limit 10;
#Q13 In the client table, of all districts with a district_id lower than 10, how many clients are from each district_id? Show the results sorted by the district_id in ascending order;
select distinct district_id, count(*) from client where district_id <10 group by district_id order by district_id;
#Q14 In the card table, how many cards exist for each type? Rank the result starting with the most frequent type.
select type, count(*) from card group by type;
#Q15 Using the loan table, print the top 10 account_ids based on the sum of all of their loan amounts.
select account_id, sum(amount) from loan group by account_id having sum(amount) order by sum(amount) desc limit 10; 
