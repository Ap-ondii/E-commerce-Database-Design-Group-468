-- Create Database
CREATE DATABASE ecommerce_db;
USE ecommerce_db;

--  brand
CREATE TABLE brand (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- product_category
CREATE TABLE product_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);

-- product
CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    brand_id INT,
    category_id INT,
    base_price DECIMAL(10,2) NOT NULL,
    description TEXT,
    FOREIGN KEY (brand_id) REFERENCES brand(id),
    FOREIGN KEY (category_id) REFERENCES product_category(id)
);

--  product_image
CREATE TABLE product_image (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    image_url VARCHAR(500) NOT NULL,
    alt_text VARCHAR(255),
    FOREIGN KEY (product_id) REFERENCES product(id) ON DELETE CASCADE
);
--  color
CREATE TABLE color (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    hex_code VARCHAR(7) 
);
--  size_category
CREATE TABLE size_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);
-- size_option
CREATE TABLE size_option (
    id INT AUTO_INCREMENT PRIMARY KEY,
    size_category_id INT NOT NULL,
    size_label VARCHAR(50) NOT NULL,
    FOREIGN KEY (size_category_id) REFERENCES size_category(id)
);
-- product_variation
CREATE TABLE product_variation (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    color_id INT,
    size_option_id INT,
    stock_quantity INT DEFAULT 0,
    extra_price DECIMAL(10,2) DEFAULT 0.00,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (color_id) REFERENCES color(id),
    FOREIGN KEY (size_option_id) REFERENCES size_option(id)
);

-- product_item 
CREATE TABLE product_item (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_variation_id INT NOT NULL,
    sku VARCHAR(100) UNIQUE,
    barcode VARCHAR(100),
    available BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (product_variation_id) REFERENCES product_variation(id)
);

-- attribute_category
CREATE TABLE attribute_category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- attribute_type
CREATE TABLE attribute_type (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL 
);

--  product_attribute
CREATE TABLE product_attribute (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product_id INT NOT NULL,
    attribute_category_id INT,
    attribute_type_id INT,
    name VARCHAR(100) NOT NULL,
    value VARCHAR(255) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES product(id),
    FOREIGN KEY (attribute_category_id) REFERENCES attribute_category(id),
    FOREIGN KEY (attribute_type_id) REFERENCES attribute_type(id)
);

-- Insert sample brands
INSERT INTO brand (name, description) VALUES
('Nike', 'Sports brand'),
('Apple', 'Tech brand'),
('Samsung', 'Electronics manufacturer');

-- Insert sample product categories
INSERT INTO product_category (name, description) VALUES
('Clothing', 'Men and women clothing'),
('Electronics', 'Mobile phones, laptops');

-- Insert products
INSERT INTO product (name, brand_id, category_id, base_price, description) VALUES
('Running Shoes', 1, 1, 120.00, 'Comfortable running shoes'),
('iPhone 15', 2, 2, 999.99, 'Latest Apple iPhone');

-- Insert product images
INSERT INTO product_image (product_id, image_url, alt_text) VALUES
(1, 'https://www.pexels.com/photo/white-and-red-sneakers-on-gray-surface-10963373/', 'Running Shoes'),
(2, 'https://www.pexels.com/photo/white-smartphone-on-black-book-14557601/', 'iPhone 12');

-- Insert colors
INSERT INTO color (name, hex_code) VALUES
('Red', '#FF0000'),
('Black', '#000000'),
('White', '#FFFFFF');

-- Insert size categories
INSERT INTO size_category (name) VALUES
('Shoe Sizes'),
('Phone Storage');

-- Insert size options
INSERT INTO size_option (size_category_id, size_label) VALUES
(1, '42'),
(1, '44'),
(2, '128GB'),
(2, '256GB');

-- Insert product variations
INSERT INTO product_variation (product_id, color_id, size_option_id, stock_quantity, extra_price) VALUES
(1, 1, 1, 10, 0),
(1, 2, 2, 5, 10),
(2, 3, 3, 20, 0),
(2, 2, 4, 15, 50);

-- Insert product items
INSERT INTO product_item (product_variation_id, sku, barcode, available) VALUES
(1, 'SHOE-RED-42', '1234567890', TRUE),
(2, 'SHOE-BLACK-44', '1234567891', TRUE),
(3, 'IPHONE15-WHITE-128', '1234567892', TRUE),
(4, 'IPHONE15-BLACK-256', '1234567893', FALSE);

-- Insert attribute categories
INSERT INTO attribute_category (name) VALUES
('Material'),
('Technical Specifications');

-- Insert attribute types
INSERT INTO attribute_type (name) VALUES
('Text'),
('Number');

-- Insert product attributes
INSERT INTO product_attribute (product_id, attribute_category_id, attribute_type_id, name, value) VALUES
(1, 1, 1, 'Material', 'Leather'),
(2, 2, 2, 'Battery Life', '20');

