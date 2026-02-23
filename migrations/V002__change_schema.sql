-- добавление первичных и внещних ключей
ALTER TABLE public.product ADD PRIMARY KEY (id);
ALTER TABLE public.orders ADD PRIMARY KEY (id);

ALTER TABLE public.order_product
    ADD CONSTRAINT fk_order_product_order FOREIGN KEY (order_id) REFERENCES public.orders(id),
    ADD CONSTRAINT fk_order_product_product FOREIGN KEY (product_id) REFERENCES public.product(id);

ALTER TABLE public.order_product ADD PRIMARY KEY (order_id, product_id);

-- добавление цены продукту
ALTER TABLE public.product ADD COLUMN price double precision;

UPDATE public.product p
SET 
    price = pi.price
FROM 
    public.product_info pi
WHERE 
    p.id = pi.product_id;


ALTER TABLE public.orders ADD COLUMN date_created date;

-- добавление даты создания заказу
UPDATE public.orders o
SET 
    date_created = od.date_created
FROM 
    public.orders_date od
WHERE 
    o.id = od.order_id;

-- удаление неиспольуземых таблиц
DROP TABLE IF EXISTS public.product_info;
DROP TABLE IF EXISTS public.orders_date;