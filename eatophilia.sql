CREATE TABLE login_details (
    id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE CHECK (email = lower(email)),
    password VARCHAR(255) NOT NULL CHECK (password ~ '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+]).{8,}$')
  
);


CREATE TABLE customers (
    id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE CHECK (email = lower(email)),
    phone VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    zip VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (email) REFERENCES login_details(email)

);

CREATE INDEX idx_customers_name ON customers (customer_name);
CREATE INDEX idx_email ON customers (email);

CREATE TABLE restaurants (
    id BIGSERIAL PRIMARY KEY,
    restaurant_name VARCHAR(255) NOT NULL,
    restaurant_address VARCHAR(255) NOT NULL,
    restaurant_city VARCHAR(255) NOT NULL,
    restaurant_state VARCHAR(255) NOT NULL,
    restaurant_zip VARCHAR(255) NOT NULL,
    restaurant_phone VARCHAR(255) NOT NULL UNIQUE,
    restaurant_email VARCHAR(255) NOT NULL UNIQUE  CHECK ( restaurant_email = lower(restaurant_email)),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);


CREATE INDEX idx_restaurants_name ON restaurants (restaurant_name);
CREATE INDEX idx_email ON restaurants (email);
CREATE INDEX idx_phone ON restaurants (phone);

CREATE TABLE food_items (
    id BIGSERIAL PRIMARY KEY,
    food_item_name VARCHAR(255) NOT NULL,
    food_item_description VARCHAR(255) NOT NULL,
    food_item_price INTEGER NOT NULL,
    food_item_image VARCHAR(255) NOT NULL,
    food_item_category VARCHAR(255) NOT NULL,
    food_item_quantity INTEGER NOT NULL,
    food_item_rating INTEGER NOT NULL,
    food_item_discount INTEGER NOT NULL,
    food_item_discount_start_date DATE,
    food_item_discount_end_date DATE
);

CREATE INDEX idx_food_items_name ON food_items (food_item_name);

CREATE TABLE restaurant_menus (
    id BIGSERIAL PRIMARY KEY,
    restaurant_id INTEGER NOT NULL,
    food_item_id INTEGER NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id),
    FOREIGN KEY (food_item_id) REFERENCES food_items(id)
);


CREATE TABLE orders (
    id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date TIMESTAMP DEFAULT NOW(),
    order_status VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE INDEX idx_orders_id ON orders (id);

CREATE TABLE order_items (
    id BIGSERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    food_item_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(id),
    FOREIGN KEY (food_item_id) REFERENCES food_items(id)
);


CREATE TABLE cart (
    id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    food_item_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (food_item_id) REFERENCES food_items(id)
);


CREATE TABLE card_details (
    id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    card_number VARCHAR(255) NOT NULL UNIQUE,
    card_name VARCHAR(255) NOT NULL,
    card_expiration VARCHAR(255) NOT NULL,
    card_cvv VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE payments (
    id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    payment_type VARCHAR(255) NOT NULL,
    payment_amount INTEGER NOT NULL,
    payment_status BOOLEAN NOT NULL,
    payment_date TIMESTAMP DEFAULT NOW(),
    card_id INTEGER NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (card_id) REFERENCES card_details(id)

);


CREATE TABLE bills (
    id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_id INTEGER NOT NULL,
    bill_date TIMESTAMP DEFAULT NOW(),
    bill_amount INTEGER NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);


CREATE TABLE deliveries (
    id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_id INTEGER NOT NULL,
    delivery_status BOOLEAN NOT NULL,
    estimated_time TIME NOT NULL,
    delivery_date TIMESTAMP DEFAULT NOW(),
    delivery_address VARCHAR(255) NOT NULL,
    delivery_city VARCHAR(255) NOT NULL,
    delivery_state VARCHAR(255) NOT NULL,
    delivery_zip VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (order_id) REFERENCES orders(id)
);

CREATE INDEX idx_deliveries_id ON deliveries (id);



CREATE TABLE delivery_persons (
    id BIGSERIAL PRIMARY KEY,
    delivery_person_name VARCHAR(255) NOT NULL,
    delivery_person_phone VARCHAR(255) NOT NULL UNIQUE,
    delivery_person_email VARCHAR(255) NOT NULL UNIQUE CHECK ( delivery_person_email = lower(delivery_person_email)),
    delivery_person_password VARCHAR(255) NOT NULL CHECK ( delivery_person_password ~ '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+]).{8,}$'),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE INDEX idx_delivery_persons_name ON delivery_persons (delivery_person_name);

CREATE TABLE reviews (
    id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    restaurant_id INTEGER NOT NULL,
    review_rating INTEGER NOT NULL,
    review_text VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (customer_id) REFERENCES customers(id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(id)
);



CREATE TABLE promocodes (
    id BIGSERIAL PRIMARY KEY,
    promocode VARCHAR(255) NOT NULL,
    promocode_discount INTEGER NOT NULL,
    promocode_start_date TIMESTAMP DEFAULT NOW(),
    promocode_end_date TIMESTAMP DEFAULT NOW()
);



