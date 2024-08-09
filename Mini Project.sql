use project_1;
show tables;
select * from swiggy;

# Step-1= Count total rows in a table
select count(*) from swiggy; #OR 
select count(ID) from swiggy;          #8680

# Step-2= Check for primary key
describe swiggy;
  # Add primary key
alter table swiggy add primary key(ID);

# Total number of restaurents
select count(distinct(restaurant)) as Total_Restro from swiggy;    #7865

# Find how many restaurants which appeared more than once    # 8680-7865=815
select count(restaurant) - count(distinct(restaurant)) as repeated_restro
from swiggy;
   # Using Group BY
select restaurant, count(restaurant)
from swiggy
group by restaurant
order by count(restaurant) desc;  #But this will also show reatro with 1 count also
           #Therefor we will use-
select restaurant, count(restaurant)
from swiggy
group by restaurant
having count(restaurant) > 1
order by count(restaurant) desc;


# Find total cities in the data
select count(distinct(city))as total_city_count from swiggy;

# Sort orders coming from each city in descending order      
select city, count(ID) as city_order_count
from swiggy
group by city
order by city_order_count desc;

# Find total orders made from each restaurant from Banglore    # Doubt
select restaurant, city , count(restaurant) as Bangalore_count
from swiggy
group by restaurant, city
having City ='Bangalore'
order by Bangalore_count desc;

select restaurant,count(id) as orders
from swiggy
where city='Bangalore'
group by restaurant
order by count(id) desc;

# Find the restaurant name with maximum orders
select restaurant , count(restaurant)
from swiggy
group by restaurant
order by count(restaurant) desc
limit 1;   # This will give ans for restaurant in all cities so-
     select restaurant , city, count(restaurant)
     from swiggy
	 group by restaurant, city
	 order by count(restaurant) desc
     limit 1;

#or by using Windows function
select restaurant,city,total_orders          #Doubt
from(select restaurant, city, count(ID) as total_orders ,
     dense_rank() over(order by count(ID) desc) as rankk
	 from swiggy
     group by restaurant,city) as rankings
where rankk= 1;

# Find top 3 restaurant names with maximum orders


# Find restaurants from Kormangala area of Banglore which serves chinese food
select restaurant
from swiggy
where area='Koramangala' and city='Bangalore' and (Food_type like '%Chinese' or Food_type like '%Chinese%');

# Find average delivery time taken by swiggy
select avg(delivery_time)
from swiggy;

# Find average delivery time taken by swiggy in each city
select city,avg(delivery_time)
from swiggy
group by city;

/* Find all restaurents from Mumbai,Delhi and Kolkata which serve North and South Indian dishes*/
select restaurant, Food_type
from swiggy
where (city='Mumbai' or city='Delhi' or city='Kolkata') AND 
      (Food_type like '%North Indian' or Food_type like '%North Indian%' or 
      Food_type like '%South Indian' or Food_type like '%South Indian%');



