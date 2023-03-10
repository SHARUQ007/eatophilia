
CREATE TABLE customers (
    customer_id BIGSERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    phone VARCHAR(255) NOT NULL UNIQUE,
    address VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL,
    state VARCHAR(255) NOT NULL,
    zip VARCHAR(255) NOT NULL
);


CREATE TABLE login_details (
    login_id BIGSERIAL PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE CHECK (email = lower(email)),
    password VARCHAR(255) NOT NULL CHECK (password ~ '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+]).{8,}$'),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE restaurants (
    restaurant_id BIGSERIAL PRIMARY KEY,
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

CREATE TABLE food_items (
    food_item_id BIGSERIAL PRIMARY KEY,
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

CREATE TABLE restaurant_menus (
    restaurant_menu_id BIGSERIAL PRIMARY KEY,
    restaurant_id INTEGER NOT NULL,
    food_item_id INTEGER NOT NULL,
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id),
    FOREIGN KEY (food_item_id) REFERENCES food_items(food_item_id)
);

CREATE TABLE orders (
    order_id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_date TIMESTAMP DEFAULT NOW(),
    order_status VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);


CREATE TABLE order_items (
    order_item_id BIGSERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL,
    food_item_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (food_item_id) REFERENCES food_items(food_item_id)
);


CREATE TABLE cart (
    cart_id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    food_item_id INTEGER NOT NULL,
    quantity INTEGER NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (food_item_id) REFERENCES food_items(food_item_id)
);


CREATE TABLE card_details (
    card_id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    card_number VARCHAR(255) NOT NULL UNIQUE,
    card_name VARCHAR(255) NOT NULL,
    card_expiration VARCHAR(255) NOT NULL,
    card_cvv VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE payments (
    payment_id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    payment_type VARCHAR(255) NOT NULL,
    payment_amount INTEGER NOT NULL,
    payment_status BOOLEAN NOT NULL,
    payment_date TIMESTAMP DEFAULT NOW(),
    card_id INTEGER NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (card_id) REFERENCES card_details(card_id)

);


CREATE TABLE bills (
    bill_id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_id INTEGER NOT NULL,
    bill_date TIMESTAMP DEFAULT NOW(),
    bill_amount INTEGER NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


CREATE TABLE deliveries (
    delivery_id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    order_id INTEGER NOT NULL,
    delivery_status BOOLEAN NOT NULL,
    delivery_date TIMESTAMP DEFAULT NOW(),
    delivery_address VARCHAR(255) NOT NULL,
    delivery_city VARCHAR(255) NOT NULL,
    delivery_state VARCHAR(255) NOT NULL,
    delivery_zip VARCHAR(255) NOT NULL,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
);


CREATE TABLE delivery_persons (
    delivery_person_id BIGSERIAL PRIMARY KEY,
    delivery_person_name VARCHAR(255) NOT NULL,
    delivery_person_phone VARCHAR(255) NOT NULL UNIQUE,
    delivery_person_email VARCHAR(255) NOT NULL UNIQUE CHECK ( delivery_person_email = lower(delivery_person_email)),
    delivery_person_password VARCHAR(255) NOT NULL CHECK ( delivery_person_password ~ '^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+]).{8,}$'),
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW()
);


CREATE TABLE reviews (
    review_id BIGSERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    restaurant_id INTEGER NOT NULL,
    review_rating INTEGER NOT NULL,
    review_text VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT NOW(),
    updated_at TIMESTAMP DEFAULT NOW(),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (restaurant_id) REFERENCES restaurants(restaurant_id)
);



CREATE TABLE promocodes (
    promocode_id BIGSERIAL PRIMARY KEY,
    promocode VARCHAR(255) NOT NULL,
    promocode_discount INTEGER NOT NULL,
    promocode_start_date TIMESTAMP DEFAULT NOW(),
    promocode_end_date TIMESTAMP DEFAULT NOW()
);


