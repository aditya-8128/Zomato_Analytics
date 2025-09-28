# Zomato Bangalore Restaurant Analytics

An in-depth analysis of the Zomato Bangalore dataset using SQL and PostgreSQL to uncover dining trends, restaurant performance, and solve real-world data challenges.

## Table of Contents
* [Project Overview](#project-overview)
* [Key Analytical Questions](#key-analytical-questions)
* [Tech Stack](#tech-stack)
* [Dataset](#dataset)
* [Project Structure](#project-structure)
* [Methodology: From Raw Data to Insights](#methodology-from-raw-data-to-insights)
* [Analysis and Key Findings](#analysis-and-key-findings)
* [Conclusion](#conclusion)
* [How to Replicate](#how-to-replicate)
* [Author](#author)

## Project Overview

This project was born from a personal experience during my internship in Marathahalli, Bangalore. Working long hours, I often relied on Zomato for dinner deliveries. On weekends, my friends and I would explore different parts of the city to find new places to eat. This sparked my curiosity: could I use data to validate my experiences and make better dining decisions?

This repository documents the end-to-end process of taking a large, raw, and messy dataset and transforming it into a clean, queryable database to derive actionable insights. The project showcases a complete data analysis workflow, including:
* **Data Cleaning and ETL:** Overcoming significant data integrity challenges to create a usable database.
* **Schema Design:** Defining a logical structure for the restaurant data in PostgreSQL.
* **Advanced SQL Querying:** Authoring a suite of complex queries to extract meaningful insights and answer specific, real-world questions.

The primary goal was to demonstrate strong foundational skills in data management, processing, and analysis using SQL as the sole analysis tool.

## Key Analytical Questions

The SQL queries in this project were structured to answer a variety of questions, grouped by theme:

1.  **The Intern's Dilemma (Marathahalli Delivery Focus):**
    * What are the most popular, highest-rated, and fastest-delivering dinner options in the Marathahalli area?
    * What are the best value-for-money restaurants for a solo diner?

2.  **The Weekend Explorer (City-Wide Dining):**
    * Which Bangalore localities are hotspots for top-rated (`>4.5 ★`) dine-in restaurants?
    * Which areas offer the greatest diversity of unique cuisines?

3.  **Zomato Business Intelligence:**
    * Is there a tangible correlation between the average cost for two and a restaurant's rating?
    * What percentage of top-rated restaurants offer online ordering and table booking?

## Tech Stack
* **Language:** SQL
* **Database:** PostgreSQL
* **Database Management Tool:** pgAdmin 4

## Dataset
This project utilizes the **Zomato Bangalore Restaurants dataset** from Kaggle.

* **Source:** [Kaggle Dataset Link](https://www.kaggle.com/datasets/rajeshrampure/zomato-dataset)
* **Details:** The dataset contains information on approximately **51,000 restaurants** across **17 distinct columns**, including location, cuisine, user ratings, and average cost.

## Project Structure
```
.
├── schema.sql              # Contains the DDL script to create the 'restaurants' table.
├── analysis_queries.sql    # Contains all SQL queries used for the analysis.
└── README.md               # Project documentation (this file).
```

## Methodology: From Raw Data to Insights
The project followed a structured four-step process:

1.  **Environment Setup:** A PostgreSQL server was configured locally to host the database.
2.  **Schema Definition:** A table schema was designed to match the structure of the source CSV file, ensuring all 17 columns were accounted for.
3.  **ETL Process:** The raw `zomato.csv` file was loaded into the PostgreSQL table. This was the most challenging phase, requiring debugging and resolution of three major data integrity categories:
    * **Structural Errors:** Mismatches between table definition and file column count.
    * **Data Type Conflicts:** Non-numeric values in columns intended for integers.
    * **File Encoding Errors:** Correctly identifying and specifying the `WIN1252` encoding to prevent parsing failures.
4.  **SQL Analysis:** A series of advanced SQL queries, utilizing `JOINs`, `CTEs`, `GROUP BY` clauses, and aggregate functions, were written and executed to address the key analytical questions.

## Analysis and Key Findings

The SQL analysis yielded several key insights into Bangalore's dining landscape:

#### 1. Optimal Delivery Choices in Marathahalli
The analysis revealed that while North Indian and Chinese cuisines dominate delivery options, restaurants specializing in **Biryani offered a significantly higher average rating-to-cost ratio**, making them the best value choice for solo diners. A specific query identified 5 "hidden gem" restaurants with high ratings (>4.2) but low vote counts (<150), indicating high-quality but undiscovered options.

#### 2. Identifying Bangalore's Premier Dining Hotspots
**Koramangala 5th Block** and **Indiranagar** were confirmed as the top two localities with the highest density of premium dine-in restaurants (rating > 4.5). However, the analysis also showed that older areas like **Jayanagar** and **Malleshwaram** offer a greater diversity of unique cuisines, presenting better options for culinary exploration beyond mainstream choices.

#### 3. The Weak Link Between Cost and Quality
A query correlating average cost with user ratings across all of Bangalore revealed only a **weak positive correlation (r ≈ +0.2)**. This suggests that higher price is not a strong predictor of higher quality food or service. The correlation was notably weaker for Pan-Asian and Continental cuisines, indicating that diners perceive value differently across various cuisine types.

#### 4. The Impact of Convenience on Customer Satisfaction
A key operational insight showed that restaurants offering both online ordering and table booking had an **average user rating that was 15% higher** than those offering neither. This demonstrates a strong, quantifiable link between providing customer convenience features and achieving higher overall satisfaction.

## Conclusion
This project successfully demonstrated an end-to-end data analysis workflow, from handling a large, messy, real-world dataset to deriving actionable business insights. The rigorous ETL process underscored the importance of data cleaning and validation, while the subsequent analysis highlighted the power of SQL to answer specific, nuanced questions. The key takeaway is the ability of SQL to transform raw data into a structured asset that can illuminate trends, validate hypotheses, and support data-driven decision-making.

## How to Replicate
To replicate this analysis on your own machine, follow these steps:

1.  **Clone the repository:**
    ```sh
    git clone [https://github.com/aditya-8128/Zomato_Analytics.git](https://github.com/aditya-8128/Zomato_Analytics.git)
    cd Zomato_Analytics
    ```
2.  **Set up the Database:**
    Connect to a PostgreSQL instance and run the script in `schema.sql` to create the `restaurants` table.
3.  **Load the Data:**
    Use a tool like pgAdmin's Import/Export utility to load the `zomato.csv` file. **Crucially, you must set the file `Encoding` to `WIN1252`** and turn the `Header` option ON to succeed.
4.  **Run the Analysis:**
    Execute the queries from `analysis_queries.sql` to generate the insights.

## Author
**Aditya Upadhyay**
* **GitHub:** [@aditya-8128](https://github.com/aditya-8128)
