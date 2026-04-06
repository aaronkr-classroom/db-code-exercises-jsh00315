create table UserAccount (
                             user_id int primary key,
                             email varchar(100),
                             password varchar(100),
                             created_at timestamp
);

create table Character(
                          character_id int primary key,
                          user_id int,
                          name varchar(100),
                          level int,
                          class varchar(50),
                          foreign key (user_id) references UserAccount(user_id)
);

create table Item(
                     item_id int primary key,
                     name varchar(100),
                     type varchar(50)
);

create table Inventory(
                          character_id int,
                          item_id int,
                          quantity int,
                          primary key (character_id,item_id),
                          foreign key (character_id) references Character(character_id),
                          foreign key (item_id) references Item(item_id)
);