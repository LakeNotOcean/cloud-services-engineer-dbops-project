-- добавление первичных ключей
ALTER TABLE public.product ADD PRIMARY KEY (id);
ALTER TABLE public.orders ADD PRIMARY KEY (id);

-- добавление внешних ключей для связующей таблицы
ALTER TABLE public.order_product
    ADD CONSTRAINT fk_order_product_order FOREIGN KEY (order_id) REFERENCES public.orders(id),
    ADD CONSTRAINT fk_order_product_product FOREIGN KEY (product_id) REFERENCES public.product(id);

-- добавление первичного ключа для связующей таблицы
ALTER TABLE public.order_product ADD PRIMARY KEY (order_id, product_id);

-- добавление столбца цены для таблицы продуктов
ALTER TABLE public.product ADD COLUMN price double precision;

-- перенос цен в таблицу продуктов
UPDATE public.product p
SET 
    price = pi.price
FROM 
    public.product_info pi
WHERE 
    p.id = pi.product_id;

-- добавление столбца даты создания для таблицы заказов
ALTER TABLE public.orders ADD COLUMN date_created date;

-- перенос даты создания в таблицу продуктов
UPDATE public.orders o
SET 
    date_created = od.date_created
FROM 
    public.orders_date od
WHERE 
    o.id = od.order_id;

-- удаление неиспольуземых таблиц после переноса данных
DROP TABLE IF EXISTS public.product_info;
DROP TABLE IF EXISTS public.orders_date;