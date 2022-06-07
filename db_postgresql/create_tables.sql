-- Создание отдельной схемы для контента:
CREATE SCHEMA content;

--  Информация о товаре:
CREATE TABLE IF NOT EXISTS content.product (
    id uuid PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    address TEXT NOT NULL,
    price_one_day INTEGER,
    price_three_days INTEGER,
    price_seven_days INTEGER,
    price_seven_month INTEGER,
    rating FLOAT,
    user_id uuid NOT NULL,
    category_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);

-- Изображение товара:
CREATE TABLE IF NOT EXISTS content.image (
    id uuid PRIMARY KEY,
    url TEXT NOT NULL,
    created_at timestamp with time zone
);

-- Создание таблицы связи изображений с товаром:
CREATE TABLE IF NOT EXISTS content.image_product (
    id uuid PRIMARY KEY,
    product_id uuid NOT NULL,
    image_id uuid NOT NULL,
    created_at timestamp with time zone,
    UNIQUE (product_id, image_id)
);

-- Категории товаров:
CREATE TABLE IF NOT EXISTS content.category (
    id uuid PRIMARY KEY,
    title TEXT NOT NULL,
    description TEXT,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);
