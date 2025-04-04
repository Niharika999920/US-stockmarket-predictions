#!/usr/bin/env python
# coding: utf-8

# In[5]:


import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Sample Data (Replace this with actual query results if needed)
data = {
    "ticker_symbol": ["WTM", "FCNCA", "FICO", "TDG", "ORLY", "COKE", "GHC", "BLK", "NFLX", "NOW"],
    "close_price": [1883.08, 1807.48, 1799.90, 1346.5, 1327.41, 1318.46, 933.04, 928.70, 918.00, 844.33],
    "future_sales": [1883.08, 1807.48, 1799.90, 1346.5, 1327.41, 1318.46, 933.04, 928.70, 918.00, 844.33],
    "moving_avg": [1869.65, 1782.80, 1770.12, 1334.89, 1320.98, 1303.97, 920.72, 924.48, 898.15, 829.86]
}

# Convert to DataFrame
df = pd.DataFrame(data)

# Set the style
sns.set_style("whitegrid")

# Plot the data
plt.figure(figsize=(12, 6))
sns.barplot(x="ticker_symbol", y="future_sales", data=df, palette="viridis")

# Titles and labels
plt.title("Top 10 Stock Predictions - Future Sales", fontsize=14)
plt.xlabel("Stock Ticker", fontsize=12)
plt.ylabel("Future Sales", fontsize=12)

# Show the plot
plt.show()


# In[6]:


import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

# Sample Data (Replace this with actual query results)
data = {
    "ticker_name": [
        "WHITE MOUNTAINS INSURANCE GROUP LTD",
        "FIRST CITIZENS BANCSHARES INC /DE/",
        "FAIR ISAAC CORP",
        "TransDigm Group Inc",
        "O REILLY AUTOMOTIVE INC",
        "Coca-Cola Consolidated, Inc.",
        "Graham Holdings Co",
        "BlackRock Finance, Inc.",
        "NETFLIX INC",
        "ServiceNow, Inc."
    ],
    "close_price": [1883.08, 1807.48, 1799.90, 1346.5, 1327.41, 1318.46, 933.04, 928.70, 918.00, 844.33],
    "future_sales": [1883.08, 1807.48, 1799.90, 1346.5, 1327.41, 1318.46, 933.04, 928.70, 918.00, 844.33],
    "moving_avg": [1869.65, 1782.80, 1770.12, 1334.89, 1320.98, 1303.97, 920.72, 924.48, 898.15, 829.86]
}

# Convert to DataFrame
df = pd.DataFrame(data)

# Set the style
sns.set_style("whitegrid")

# Increase figure size
plt.figure(figsize=(14, 6))

# Bar plot
sns.barplot(y="future_sales", x="ticker_name", data=df, palette="viridis")

# Rotate X-axis labels to show full names
plt.xticks(rotation=45, ha="right", fontsize=10)

# Titles and labels
plt.title("Top 10 Stock Predictions - Future Sales", fontsize=14)
plt.xlabel("Company Name", fontsize=12)
plt.ylabel("Future Sales", fontsize=12)

# Adjust layout
plt.tight_layout()

# Show the plot
plt.show()


# In[7]:


plt.savefig("stocks_visualization.png", dpi=300)


# In[ ]:




