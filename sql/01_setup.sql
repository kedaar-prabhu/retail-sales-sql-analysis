-- ============================================================
-- FILE: 01_setup.sql
-- PROJECT: Retail Sales Intelligence — SQL Analysis
-- DESCRIPTION: Creates the retail_sales_db schema and all tables
-- ============================================================

CREATE DATABASE IF NOT EXISTS retail_sales_db;
USE retail_sales_db;

CREATE TABLE stores (
    store_nbr INT PRIMARY KEY,
    city VARCHAR(100),
    state VARCHAR(100),
    type CHAR(1),
    cluster INT
);

CREATE TABLE oil (
    date DATE PRIMARY KEY,
    dcoilwtico FLOAT
);

CREATE TABLE holidays_events (
    date DATE,
    type VARCHAR(50),
    locale VARCHAR(20),
    locale_name VARCHAR(100),
    description VARCHAR(200),
    transferred VARCHAR(5)
);

CREATE TABLE transactions (
    date DATE,
    store_nbr INT,
    transactions INT
);

CREATE TABLE sales (
    id BIGINT PRIMARY KEY,
    date DATE,
    store_nbr INT,
    family VARCHAR(100),
    sales DECIMAL(14,4),
    onpromotion INT
);
