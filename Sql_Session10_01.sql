-- Tạo bảng
create table products (
    id serial primary key,
    name varchar(100),
    price numeric(10,2),
    last_modified timestamp
);

-- Function cập nhật last_modified
create or replace function update_last_modified()
returns trigger as $$
begin
    new.last_modified := now();
    return new;
end;
$$ language plpgsql;

-- Trigger
create trigger trg_update_last_modified
before update on products
for each row
execute function update_last_modified();

-- Chèn nhiều dữ liệu mẫu
insert into products (name, price, last_modified) values
('Laptop A', 1000, now()),
('Laptop B', 1200, now()),
('Laptop C', 1500, now()),
('Phone A', 500, now()),
('Phone B', 650, now()),
('Phone C', 750, now()),
('Tablet A', 800, now()),
('Tablet B', 900, now()),
('Tablet C', 950, now()),
('Mouse', 50, now()),
('Keyboard', 120, now()),
('Monitor', 300, now());

-- UPDATE để kiểm tra trigger
update products
set price = price + 100
where price < 800;

-- Xem kết quả
select * from products;
