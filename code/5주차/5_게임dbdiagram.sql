Table UserAccount {
  user_id int [primary key]
  email varchar(100)
  password varchar(100)
  created_at timestamp
}

Table Character {
  character_id int [primary key]
  user_id int
  name varchar(100)
  level int
  class varchar(50)
}

Table Item {
  item_id int [primary key]
  name varchar(100)
  type varchar(50)
}

Table Inventory {
  character_id int
  item_id int
  quantity int

  indexes {
    (character_id, item_id) [pk]
  }
}

Ref: Character.user_id > UserAccount.user_id // Many-to-one
Ref: Inventory.character_id > Character.character_id
Ref: Inventory.item_id > Item.item_id