CREATE SCHEMA production;

CREATE SCHEMA sales;

CREATE TABLE production.brands (
brand_id int GENERATED BY DEFAULT AS IDENTITY primary key,
brand_name varchar(200) not null
);

CREATE TABLE production.categories (
category_id int GENERATED BY DEFAULT AS IDENTITY primary key,
category_name varchar( 200) not null
);


CREATE TABLE production.products (
product_id  int GENERATED BY DEFAULT AS IDENTITY primary key,
product_name varchar(200) not null,
brand_id int not null,
model_year int not null,
category_id int not null,
list_price int  not null,
foreign key (category_id) REFERENCES production.categories (category_id) on delete cascade on update cascade,
foreign key (brand_id) REFERENCES production.brands (brand_id) on delete cascade on update cascade
);

CREATE TABLE sales.stores (
store_id  int GENERATED BY DEFAULT AS IDENTITY primary key,
store_name varchar(200) not null,
email varchar(200),
phone varchar(15),
street varchar(200),
city varchar(30),
state varchar(20),
zip_code varchar(9)
);

CREATE TABLE sales.customers(
customer_id  int GENERATED BY DEFAULT AS IDENTITY primary key,
first_name varchar(200) not null,
last_name varchar(200) not null,
email varchar(200) not null,
phone varchar(15) ,
street varchar(200),
city varchar(30),
state varchar(20),
zip_code varchar(9)
);



CREATE TABLE sales.staffs (
staff_id  int GENERATED BY DEFAULT AS IDENTITY primary key,
first_name varchar(50) not null,
last_name varchar(50) not null,
email varchar(200) not null UNIQUE,
active int,
phone varchar(15),
store_id int not null,
manager_id int,
foreign key (store_id) REFERENCES sales.stores (store_id) on delete cascade on update cascade,
foreign key (manager_id) REFERENCES sales.staffs (staff_id) on delete no action on update no action
);

CREATE TABLE sales.orders (
order_id int GENERATED BY DEFAULT AS IDENTITY primary key,
customer_id int,
store_id int not null,
staff_id int not null,
order_status int not null,
order_date DATE not null,
required_date DATE,
shipped_date DATE,
foreign key (customer_id) REFERENCES sales.customers (customer_id) on delete cascade on update cascade,
foreign key (store_id) REFERENCES sales.stores (store_id) on delete cascade on update cascade,
foreign key (staff_id) REFERENCES sales.staffs (staff_id) on delete no action on update no action
);

CREATE TABLE sales.order_items (
order_id int,
item_id int,
product_id int not null,
quantity int not null,
list_price  int  not null,
discount decimal (5, 2) not null DEFAULT 0,
primary key (order_id, item_id),
foreign key (order_id) REFERENCES sales.orders (order_id) on delete cascade on update cascade,
foreign key (product_id) REFERENCES production.products (product_id) on delete cascade on update cascade
);

CREATE TABLE production.stocks (
store_id int,
quantity int,
product_id int,
primary key (store_id, product_id),
foreign key (store_id) REFERENCES sales.stores (store_id) on delete cascade on update cascade,
foreign key (product_id) REFERENCES production.products (product_id) on delete cascade on update cascade
);


