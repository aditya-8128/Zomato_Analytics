-- This script drops the existing table (if it exists) and creates the 'restaurants' table
-- with a structure that perfectly matches the 17 columns of the Zomato Bangalore dataset.
-- Data types are set to VARCHAR or TEXT to ensure a successful initial data import,
-- even with messy or inconsistent data.

DROP TABLE IF EXISTS restaurants;

CREATE TABLE restaurants (
    url TEXT,
    address TEXT,
    name TEXT,
    online_order VARCHAR(10),
    book_table VARCHAR(10),
    rate VARCHAR(10),
    votes VARCHAR(20),
    phone VARCHAR(100),
    location TEXT,
    rest_type TEXT,
    dish_liked TEXT,
    cuisines TEXT,
    approx_cost_for_two VARCHAR(20),
    reviews_list TEXT,
    menu_item TEXT,
    listed_in_type VARCHAR(100),
    listed_in_city VARCHAR(100)
);
