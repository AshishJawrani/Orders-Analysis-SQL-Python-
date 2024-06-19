# Orders-Analysis-SQL-Python-
An end to end data analysis of orders data using SQL and Python.

## Tech used
Python [Pandas, Sqlalchemy] - For data cleaning and transformation<br>
SQL - To draw insights.

## Data Cleaning & Transformation
1. While reading the csv file, replaced the null values with nan.
2. Used str.lower() method to change the column name to lower case and str.replace() method to replace spaces with underscore(_).
3. Added 'discount' column by calculating product of list_price and discount_percent.
4. Added sale_price column by subtracting list_price with discount.
5. Added profit column by by subtracting sale_price with cost_price.
6. Corrected data type for order_date column with the help of to_datetime method.
7. Dropped unnecessary column like list_price, cost_price and discount_percent.

## Data Loading
1. Imported Sqlalchemy library and linked to SQL server databse with the help of create_engine() method
2. Loaded the data into SQL server using append option.

