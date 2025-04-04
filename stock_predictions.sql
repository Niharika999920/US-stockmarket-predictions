/* PREDICTING FUTURE STOCK MARKET TRENDS USING SQL AND DATA ANALYSIS */

-- Lets begin the project,
/*1) Step1:  before i begin my project, i am trying to look what tables are present in my schema currently */

SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'endeavour';

/*Step2: Now that i have seen all the tables, my main tables would be stocks_price_history → Main stock price table

stocks_lookup → Company stock symbol and names

stock_fundamentals → Financial metrics 

 So, now understand the structure of all these tables */

select column_name, data_type 
from information_schema.columns 
where table_name = 'stocks_lookup';

select column_name, data_type
from information_schema.columns
where table_name = 'stocks_price_history';

select column_name, data_type
from information_schema.columns
where table_name = 'stock_fundamentals';

/* stocks_lookup:

ticker_symbol: The unique stock symbol for each company (e.g., AAPL for Apple).

ticker_name: Name of the company.

stocks_price_history:

ticker_symbol: Stock symbol (e.g., AAPL).

trading_date: Date of the stock's trading data.

close_price: Closing price of the stock on that day.

open_price, high_price, low_price: Opening, highest, and lowest prices during the day.

volume: Number of shares traded.

dividends: Dividends per share.

stock_fundamentals:

ticker_symbol: Stock symbol (e.g., AAPL).

forward_pe, trailing_pe: Price-to-earnings ratios.

sector_id, subsector_id: Classification of the company's sector and subsector.

market_cap: Market capitalization of the company.

current_ratio, debt_equity_ratio, etc.: Financial ratios and metrics used to analyze a company’s financial health. */

--Now, lets start our analysis, for fun part let us analyze which company may increase in the future

/* REQUIREMENT1: PREDICTING FUTURE STOCK GROWTH(MOMENTUM STOCKS) 
 * 
 * -- To break this requirement into a query, lets first analyse the basic requirements, here we are seraching for which company stocks may increase in the future, we may consider stocks_price_history and for the company name we have ticker_name in stocks lookup table, 
 * so we can use join on both table, now the question is to find the momentum growth for each company over a period of time, so we can consider to use lead function for future prediction and group by ticker_name
 * Also, to get the future price, we can compare the close price with the future price(price after lead) for each company_name 
 * to check the stock fluctuations we neeed to analyse the moving average which is average of that close_price over that 7 days 
 * lets say we want to see past 6 months data, so we can use current_date - interval 6 months 
 * so, main concept is if u lead the closing price to 7 days, you can see the future close_prices, now if u compare that with avg(close_price), you can know if that company have anu usual stock fluctuations
 * Lets use cte for clearer representation so, we can just take the lead and avg of closing price and compare , which company would have the highest values will be the company with possible stock profits 

*/ 



with stock_trends as (
select
	sph.ticker_symbol,
	sl.ticker_name ,
	sph.trading_date,
	sph.close_price,
	lead(sph.close_price, 7 ) over ( partition by sph.ticker_symbol
order by
	sph.trading_date) as future_sales,
	avg(sph.close_price) over (partition by sph.ticker_symbol
order by
	sph.trading_date rows between 6 preceding and current row ) as moving_avg
from
	endeavour.stocks_price_history  sph
join endeavour.stocks_lookup  sl on
	sph.ticker_symbol = sl.ticker_symbol
where
	sph.trading_date >= current_date - interval '6 months'

)

select  distinct on (st.ticker_symbol)
st.ticker_name,
st.trading_date,
st.close_price, 
coalesce(st.future_sales, st.close_price) as future_sales, 
st.moving_avg,
case
	when coalesce(st.future_sales, st.close_price) > st.moving_avg then 'stock_profit' -- stocks expected to grow
	else  'stock_loss' -- stocks expected to lose
	

end as stocks_prediction
from
stock_trends st
order by
st.ticker_symbol,
st.trading_date desc; 


-- This seems good, for every company, we got to see the stocks with the future sales and prediction, now i dont want to see every company i just want to know, top 10 companies with stocks_profit and 10 comapny with highest stocks_loss

--lets use multiple cte, to achieve that 

with stock_trends as (
    select
        sph.ticker_symbol,
        sl.ticker_name,
        sph.trading_date,
        sph.close_price,
        lead(sph.close_price, 7) over (partition by sph.ticker_symbol order by sph.trading_date) as future_sales,
        avg(sph.close_price) over (partition by sph.ticker_symbol order by sph.trading_date rows between 6 preceding and current row) as moving_avg
    from
        endeavour.stocks_price_history sph
    join endeavour.stocks_lookup sl on sph.ticker_symbol = sl.ticker_symbol
    where
        sph.trading_date >= current_date - interval '6 months'
),
predictions as (
    select 
        st.ticker_symbol,
        st.ticker_name,
        st.trading_date,
        st.close_price,
        coalesce(st.future_sales, st.close_price) as future_sales,
        st.moving_avg,
        case
            when coalesce(st.future_sales, st.close_price) > st.moving_avg then 'stock_profit'
            else 'stock_loss'
        end as stocks_prediction,
        row_number() over (partition by st.ticker_symbol order by st.trading_date desc) as recent_rank,
        rank() over (order by coalesce(st.future_sales, st.close_price) desc) as profit_rank
    from stock_trends st
)
select 
    ticker_symbol,
    ticker_name,
    trading_date,
    close_price,
    future_sales,
    moving_avg,
    stocks_prediction
from 
    predictions
where 
    stocks_prediction = 'stock_profit' 
    and recent_rank = 1  -- Ensuring only the most recent record for each company
order by 
    profit_rank
limit 10;





