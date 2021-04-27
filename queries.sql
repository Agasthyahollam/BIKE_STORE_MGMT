INSERT INTO sales.customers(customer_id,first_name, last_name, phone, email, street, city, state, zip_code) 
select 32,'Harry','Potter',9845098754,'harrypotter@yahoo.com','123 rosemary ','Bangalore','Karnataka',560041
WHERE NOT EXISTS ( select 1 FROM sales.customers 
where sales.customers.first_name = 'Harry' and sales.customers.last_name = 'Potter');
----------------------------------------------price data (error is there)---------------------------------------------------------------------------
ALTER TABLE sales.order_items
ADD column Discount_price int;
UPDATE sales.order_items 
SET Discount_price = quantity*(sales.order_items.list_price - sales.order_items.discount*sales.order_items.list_price);
ALTER TABLE sales.orders
ADD column price int;
UPDATE sales.orders
SET price = (SELECT sum(order_items.Discount_Price)
	    FROM sales.order_items
	    WHERE (SELECT sales.order_items.Discount_Price
            FROM sales.order_items,sales.orders
	    WHERE sales.order_items.order_id = sales.orders.order_id));


----------------------------Updates Stocks but works only for quantity 1 try for all cases----------------------------------------------------
UPDATE production.stocks
SET quantity = quantity -1 
WHERE production.stocks.product_id = (select production.products.product_id 
from production.products
WHERE production.products.product_name = 'Royal Enfeild Classic 350') and production.stocks.store_id = 1 ;

----------------------------Stocks with Product_id----------------------------------------------------
SELECT production.stocks.quantity,production.stocks.product_id
from production.stocks
WHERE production.stocks.product_id = (select production.products.product_id 
from production.products
WHERE production.products.product_name = 'Royal Enfeild Classic 350') and production.stocks.store_id = 1 ;





