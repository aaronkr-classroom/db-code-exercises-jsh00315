table users;

select user_level from users;

-- CHECK 유저 레벨은 1~100만 가능하다

alter table users
    add constraint chk_user_level
        check (user_level >= 1 and user_level <= 100);


update users
set user_level = 100
where user_id = 1;

-- 2: 접속 상태는 online또는 offline만 가능하다

select status from  users;

alter table users
    add constraint chk_user_status
        check (status in ('online','connecting','offline'));

table users;

update users
set status = 'sleeping'
where user_id=2;


--3. 아이쳄 가경은 0원 이상이어야 한다

select price from items;

alter table items
    add constraint chk_item_price
        check ( price >=0 );

update items
set price = -10
where item_id = 1001;

-- 4: 아이템 등급을 정해진 값만 가능하다 (s,a,b,c,d,e,f)

alter table items
    add constraint chk_item_grade
        check ( grade in ('S','A','B','C','D','E','F') );

--5: 닉네임은 중복되면 안 된다.

alter table users
    add constraint uq_users_nickname
        unique (nickname);

insert into users values
    (6,'홍길동','dragonking',10,'2026-05-18','home@home.com','offline');


select constraint_name, table_name
from information_schema.table_constraints
where constraint_type = 'FOREIGN KEY'
  and table_name = 'plays';

--plays_name_id_fkey
--plays_game_id_fkey
--user_items_user_id_fkey
--user_items_items_id_fkey

alter table plays
    drop constraint plays_user_id_fkey;
alter table plays
    drop constraint plays_game_id_fkey;
alter table user_items
    drop constraint user_items_user_id_fkey;
alter table user_items
    drop constraint user_items_item_id_fkey;

--새 fk 추가
-- 1: 유저가 학제되면 플레이 기록도 삭제되게 하기
alter table plays
    add constraint fk_plays_users
        foreign key (user_id)
            references users(user_id)
            on delete cascade;

--2: 게임은 플레이 기록이 있으면 삭제하지 못하게 하기
alter table plays
    add constraint fk_plays_games
        foreign key (game_id)
            references games(game_id)
            on delete cascade;


--3: 우저가 삭제되면 보유 아이템 기록도 삭제되게 하기
alter table user_items
    add constraint fk_user_items_users
        foreign key (user_id)
            references users(user_id)
            on delete cascade;

-- 4: 아이템 누군가 보유 중이면 삭제하지 못하게 하기

alter table user_items
    drop constraint fk_user_items_items;
alter table user_items
    add constraint fk_user_items_items
        foreign key (item_id)
            references items(item_id)
            on delete restrict;-- 수정

-- CASCADE 테스트
select * from plays where user_id = 1;

select * from user_items where user_id = 1;

delete from users
where user_id=1;

--restrict 테스트
table games;

delete from games where game_id = 101;
delete from items where item_id = 1004;

