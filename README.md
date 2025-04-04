🚀 Predicting Future Stock Market Trends Using SQL & Data Analysis 📊📈
Welcome to the Stock Market Prediction project! 🎯 If you've ever wondered which stocks will rise or what factors drive stock prices, this project dives deep into that world. With the power of SQL, we can predict future stock trends based on historical data and key financial metrics.

🎯 Project Goal
Our mission? To predict which stocks might show momentum growth in the near future and analyze trends that could help investors make smarter decisions. 🏆📉

🔍 What We Did?
In this project, we utilize SQL queries to analyze stock price history, company financials, and much more. By leveraging techniques like moving averages and LEAD() functions, we’re able to forecast future stock prices and categorize stocks into growth or loss predictions.

🚀 How It Works?
Let’s break it down into easy-to-understand steps:

1. Start with Understanding the Data 📂
We first inspect the data stored in the endeavour database. The three key tables that hold all the magic are:

stocks_price_history: Historical stock prices.

stocks_lookup: Ticker symbols & company names.

stock_fundamentals: Financial metrics of each company.

To get an idea of the data structure, we query the column details of these tables:
SELECT column_name, data_type 
FROM information_schema.columns 
WHERE table_name = 'stocks_lookup';

2. Analyzing Stock Trends 📊
Now comes the fun part! We join the stock price data with the company info, then use the LEAD() function to predict future prices. By comparing these predictions with the moving average of past prices, we create a simple rule to predict whether a stock will grow or decline.

3. Focus on Momentum Stocks 🔥
To narrow it down to the top 10 stocks with highest momentum, we rank companies based on their stock growth potential and return the top performers.

5. Result 🏆
Now, we have a prediction of top stocks that are most likely to experience future growth. This analysis helps investors identify high momentum stocks to potentially make profitable investments. 💰

🌟 Key Insights & Features:
Prediction Functionality: We leverage SQL's powerful window functions to predict future stock prices and compare them with historical averages to find momentum stocks.

Dynamic Time-Frame: We focus on the last 6 months of data, ensuring up-to-date and relevant predictions.

Top Performers: The final list includes only the top-performing stocks, categorized as growth stocks (stock_profit) or decline stocks (stock_loss).
🔧 Technologies Used:
SQL: Used extensively to manipulate and analyze stock data using window functions (LEAD(), RANK(), etc.).

Database: Queries run on the endeavour schema, which contains tables with stock price history, company details, and financial metrics.
Used python, matplotlib, seaborn to visualise the result.
🌍 Why It Matters:
In the world of investing, data-driven decisions are key. This project empowers investors to make smarter choices by predicting which stocks are likely to show momentum growth based on historical trends and financial data. Whether you're an aspiring investor or a data enthusiast, this project combines the power of data analysis and financial insight to drive better investment strategies. 📈💸

Feel free to explore the code, contribute to the project, or simply learn how SQL can predict stock market trends. Try this on your favourite data!
