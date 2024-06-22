-- 1.Write a query to find what is the total business done by each store.
select store_id, round(sum(amount))
from sakila.payment
join sakila.staff using (staff_id)
group by store_id 

-- 2.Convert the previous query into a stored procedure.
DELIMITER //
create procedure total_business_by_store ()
begin
select store_id, round(sum(amount))
from sakila.payment
join sakila.staff using (staff_id)
group by store_id;

end // 
DELIMITER ;

call total_business_by_store ;

-- 3.Convert the previous query into a stored procedure that takes the input for store_id and displays the total sales for that store.

DELIMITER //
create procedure total_business_by_store2 (in x int)
begin
select store_id, round(sum(amount))
from sakila.payment
join sakila.staff using (staff_id)
where store_id= x
group by store_id;

end // 
DELIMITER ;

call total_business_by_store2 (1);



-- 4.Update the previous query. Declare a variable total_sales_value of float type, that will store the returned result (of the total sales amount for the store).
-- Call the stored procedure and print the results.

DELIMITER //
create procedure total_business_by_store3 (in x int)
begin

declare total_sales_value float;

select sum(amount) into total_sales_value
from sakila.payment
join sakila.staff using (staff_id)
where store_id= x;

select total_sales_value;

end // 
DELIMITER ;

call total_business_by_store3 (1)



-- 5.In the previous query, add another variable flag.
-- If the total sales value for the store is over 30.000, then label it as green_flag, 
-- otherwise label is as red_flag. 
--Update the stored procedure that takes an input as the store_id and returns total sales value for that store and flag value.

DELIMITER //
create procedure total_business_by_store4 (in x int, out total_sales_value float, out param2 varchar(10))
begin

declare flag_color varchar(10);

select sum(amount) into total_sales_value
from sakila.payment
join sakila.staff using (staff_id)
where store_id= x;

if total_sales_value > 30000 then
    set flag_color = 'Green';
  else
    set flag_color = 'red';
  end if;

set param2=flag_color;

select concat("TOTAL SALES: ", total_sales_value, " |FLAG VALUE: ", param2) ;
end // 
DELIMITER ;

call total_business_by_store4 (1,@total_sales_value,@param2)

