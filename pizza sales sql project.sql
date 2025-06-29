-- Retrieve the total number of orders placed.
select count(order_id) from orders;

-- Calculate the total revenue generated from pizza sales.
select round(sum(orders_details.quantity * pizzas.price),2) as total_sales
from orders_details join pizzas
on pizzas.pizza_id = orders_details.pizza_id;

-- Identify the highest-priced pizza.
select pizza_types.name, pizzas.price
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
order by price desc limit 1;

-- Identify the most common pizza size ordered.
select pizzas.size, count(orders_details.order_details_id) as order_count
from pizzas join orders_details
on pizzas.pizza_id = orders_details.pizza_id
group by pizzas.size order by order_count desc;

-- List the top 5 most ordered pizza types along with their quantities.
select pizza_types.name, sum(orders_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by quantity desc limit 5;

-- Join the necessary tables to find the total quantity of each pizza category ordered.
select pizza_types.category, sum(orders_details.quantity) as quantity
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.category order by quantity desc;

-- Determine the distribution of orders by hour of the day.
select hour(order_time) , count(order_id)
from orders
group by hour(order_time);

-- Join relevant tables to find the category-wise distribution of pizzas.
select category, count(name)
from pizza_types
group by category;

-- Group the orders by date and calculate the average number of pizzas ordered per day.
select round(avg(quantity),0) from
(select orders.order_date, sum(orders_details.quantity) as quantity
from orders join orders_details
on orders.order_id = orders_details.order_id
group by orders.order_date) as order_quanity;

-- Determine the top 3 most ordered pizza types based on revenue.
select pizza_types.name, sum(orders_details.quantity * pizzas.price) as revenue
from pizza_types join pizzas
on pizza_types.pizza_type_id = pizzas.pizza_type_id
join orders_details
on orders_details.pizza_id = pizzas.pizza_id
group by pizza_types.name order by revenue desc limit 3;

