-- создание индекса для id заказа (для первичного ключа)
CREATE INDEX order_id_idx ON orders(id);

-- создание индекса для внешнего ключа order_id в таблице order_product
CREATE INDEX order_product_order_id_idx ON order_product(order_id); 

-- создание составного индекса для фильтрации по статусу и дате создания заказа
CREATE INDEX orders_status_date_idx ON orders(status, date_created);