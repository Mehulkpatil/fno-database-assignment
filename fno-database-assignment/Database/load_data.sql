-- First, create a temporary table matching CSV structure
CREATE TEMP TABLE temp_trades (
    instrument VARCHAR(50),
    symbol VARCHAR(50),
    expiry_dt DATE,
    strike_pr DECIMAL(15, 2),
    option_typ VARCHAR(2),
    open DECIMAL(15, 2),
    high DECIMAL(15, 2),
    low DECIMAL(15, 2),
    close DECIMAL(15, 2),
    settle_pr DECIMAL(15, 2),
    contracts BIGINT,
    val_inlakh DECIMAL(20, 2),
    open_int BIGINT,
    chg_in_oi BIGINT,
    timestamp TIMESTAMP,
    exchange VARCHAR(10)
);

-- Load CSV (adjust path)
\copy temp_trades FROM '/path/to/nse_sample.csv' WITH (FORMAT CSV, HEADER true);

-- Insert unique instruments
INSERT INTO instruments (symbol, instrument_type, exchange_id)
SELECT DISTINCT symbol, instrument, exchange
FROM temp_trades
ON CONFLICT DO NOTHING;

-- Insert trade data
INSERT INTO trades (
    instrument_id, trade_timestamp, expiry_date, strike_price,
    option_type, open_price, high_price, low_price, close_price,
    settle_price, contracts_traded, turnover, open_interest, change_in_oi
)
SELECT 
    i.instrument_id,
    t.timestamp,
    t.expiry_dt,
    t.strike_pr,
    t.option_typ,
    t.open,
    t.high,
    t.low,
    t.close,
    t.settle_pr,
    t.contracts,
    t.val_inlakh,
    t.open_int,
    t.chg_in_oi
FROM temp_trades t
JOIN instruments i ON t.symbol = i.symbol 
    AND t.instrument = i.instrument_type 
    AND t.exchange = i.exchange_id;

-- Clean up
DROP TABLE temp_trades;