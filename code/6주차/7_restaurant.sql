-- Customer 테이블
CREATE TABLE Customer (
                          customer_id SERIAL PRIMARY KEY,
                          name VARCHAR(100),
                          phone VARCHAR(13),
                          address TEXT
);

-- Restaurant Table
CREATE TABLE Restaurant (
                            restaurant_id int PRIMARY KEY,
                            name VARCHAR(100),
                            phone VARCHAR(13),
                            address varchar(100)
);

-- Orders Table
CREATE TABLE Orders (
                        order_id int PRIMARY KEY,
                        customer_id int,
                        restaurant_id int,
                        order_date timestamp,
                        total numeric,
                        foreign key (customer_id) references Customer(customer_id),
                        foreign key (restaurant_id) references Restaurant(restaurant_id)
);

-- Delivery Table
create table Delivery(
                         delivery_id int primary key ,
                         order_id int,
                         driver_name varchar(100),
                         status int,
                         foreign key (order_id) references Orders(order_id)
);

--Date 삽입

insert into Customer values
                         (1,'Alice','010-1111-2222','충주'),
                         (2,'김수민','010-3333-2222','청주');


insert into Restaurant values
                           (1,'Pizza Place','010-1234-5678','세종'),
                           (2,'김밥천국','063-1234-5678','전주');

insert into Orders values
                       (1,1,1,'2026-04-13 15:17:00',24000),
                       (2,2,2,'2026-04-13 12:17:00',8000);

insert into Delivery values
                         (1,1,'지석준',1), -- 0:받았다, 1: 조리하다, 2 : 배댈하다, 3 : 배달완료, 4 : 최소
                         (2,2,'송지현',3);


-- DB 쿼리
select * from Orders;
select * from Orders order by total desc;
select * from Orders where total >= 10000;
select * from Delivery where status = 3;