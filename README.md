# Analytical SQL Patterns Using Northwind

## Project Overview

This project focuses on using analytical SQL functions to answer practical business questions using the Northwind dataset.

The main objective is to understand how ROW_NUMBER, RANK, and LAG can be used for ranking, comparison, and trend analysis.

## Objective

Learn and apply analytical SQL patterns to solve business problems using the Northwind database.

## Tool Used

MySQL

## Dataset

Northwind

The Northwind database contains information about customers, orders, employees, products, categories, suppliers, and other business operations.

## SQL Functions Used

ROW_NUMBER

RANK

LAG

PARTITION BY

ORDER BY

Common Table Expressions

## Business Questions Covered

1. How can products be numbered based on their unit price?

2. How can products be ranked based on unit price?

3. What is the difference between ROW_NUMBER and RANK?

4. How can products be ranked within each category?

5. How can products be sequentially numbered within each category?

6. What are the top three products in each category?

7. Which employees handled the highest number of orders?

8. Which customers placed the highest number of orders?

9. How many orders were placed each month?

10. How did monthly orders compare with the previous month?

11. How much did orders increase or decrease month over month?

12. How can employee order counts be compared with the previous employee?

## Key Concepts

### ROW_NUMBER

ROW_NUMBER assigns a unique sequential number to each row based on the specified ordering.

### RANK

RANK assigns the same rank to rows with equal values. When ties occur, the next rank can contain a gap.

### LAG

LAG retrieves a value from a previous row. It is useful for comparing current business performance with previous periods or records.

### PARTITION BY

PARTITION BY allows ranking to restart within separate groups, such as product categories.

## Deliverables

12 analytical SQL queries

Query outputs

Notes explaining the purpose of each query

Comparison of ROW_NUMBER and RANK

Trend analysis using LAG

## Key Learnings

Learned how to use window functions for business analysis.

Understood the difference between ROW_NUMBER and RANK.

Learned how to rank records within groups using PARTITION BY.

Used LAG to compare current values with previous values.

Applied analytical SQL techniques to product, customer, employee, and order data.

## Conclusion

This project demonstrates how analytical SQL functions can transform business data into useful rankings, comparisons, and trends. The techniques learned can be applied to real-world sales, customer, employee, and performance analysis.
