CREATE TABLE IF NOT EXISTS public.product_dataset
(
    "Unnamed: 0" bigint,
    product_id text COLLATE pg_catalog."default" NOT NULL,
    product_category_name text COLLATE pg_catalog."default",
    product_name_lenght double precision,
    product_description_lenght double precision,
    product_photos_qty double precision,
    product_weight_g double precision,
    product_length_cm double precision,
    product_height_cm double precision,
    product_width_cm double precision,
    CONSTRAINT product_dataset_pkey PRIMARY KEY (product_id)
);

CREATE TABLE IF NOT EXISTS public.order_payments_dataset
(
    order_id text COLLATE pg_catalog."default",
    payment_sequential bigint,
    payment_type text COLLATE pg_catalog."default",
    payment_installments bigint,
    payment_value double precision,
    PRIMARY KEY (order_id)
);

CREATE TABLE IF NOT EXISTS public.order_items_dataset
(
    order_id text COLLATE pg_catalog."default",
    order_item_id bigint,
    product_id text COLLATE pg_catalog."default",
    seller_id text COLLATE pg_catalog."default",
    shipping_limit_date text COLLATE pg_catalog."default",
    price double precision,
    freight_value double precision
);

CREATE TABLE IF NOT EXISTS public.sellers_dataset
(
    seller_id text COLLATE pg_catalog."default",
    seller_zip_code_prefix bigint,
    seller_city text COLLATE pg_catalog."default",
    seller_state text COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS public.orders_dataset
(
    order_id text COLLATE pg_catalog."default",
    customer_id text COLLATE pg_catalog."default",
    order_status text COLLATE pg_catalog."default",
    order_purchase_timestamp text COLLATE pg_catalog."default",
    order_approved_at text COLLATE pg_catalog."default",
    order_delivered_carrier_date text COLLATE pg_catalog."default",
    order_delivered_customer_date text COLLATE pg_catalog."default",
    order_estimated_delivery_date text COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS public.order_reviews_dataset
(
    review_id text COLLATE pg_catalog."default",
    order_id text COLLATE pg_catalog."default",
    review_score bigint,
    review_comment_title text COLLATE pg_catalog."default",
    review_comment_message text COLLATE pg_catalog."default",
    review_creation_date text COLLATE pg_catalog."default",
    review_answer_timestamp text COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS public.customers_dataset
(
    customer_id text COLLATE pg_catalog."default",
    customer_unique_id text COLLATE pg_catalog."default",
    customer_zip_code_prefix bigint,
    customer_city text COLLATE pg_catalog."default",
    customer_state text COLLATE pg_catalog."default"
);

CREATE TABLE IF NOT EXISTS public.geolocation_dataset
(
    geolocation_zip_code_prefix bigint,
    geolocation_lat double precision,
    geolocation_lng double precision,
    geolocation_city text COLLATE pg_catalog."default",
    geolocation_state text COLLATE pg_catalog."default"
);


ALTER TABLE IF EXISTS public.order_items_dataset
    ADD CONSTRAINT product_id FOREIGN KEY (product_id)
    REFERENCES public.product_dataset (product_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.sellers_dataset
    ADD CONSTRAINT seller_id FOREIGN KEY (seller_id)
    REFERENCES public.order_items_dataset (seller_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.orders_dataset
    ADD CONSTRAINT order_id FOREIGN KEY (order_id)
    REFERENCES public.order_payments_dataset (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.orders_dataset
    ADD CONSTRAINT order_id FOREIGN KEY (order_id)
    REFERENCES public.order_items_dataset (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.order_reviews_dataset
    ADD FOREIGN KEY (order_id)
    REFERENCES public.orders_dataset (order_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.customers_dataset
    ADD CONSTRAINT customer_id FOREIGN KEY (customer_id)
    REFERENCES public.orders_dataset (customer_id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.customers_dataset
    ADD CONSTRAINT customer_zip_code FOREIGN KEY (customer_zip_code_prefix)
    REFERENCES public.geolocation_dataset (geolocation_zip_code_prefix) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE IF EXISTS public.geolocation_dataset
    ADD CONSTRAINT zip_code FOREIGN KEY (geolocation_zip_code_prefix)
    REFERENCES public.sellers_dataset (seller_zip_code_prefix) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
