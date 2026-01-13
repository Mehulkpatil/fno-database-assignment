-- 1. Connect to your database
\c fno_database

-- 2. Create tables
CREATE TABLE exchanges (
    exchange_id VARCHAR(10) PRIMARY KEY,
    exchange_name VARCHAR(100) NOT NULL
);

CREATE TABLE instruments (
    instrument_id SERIAL PRIMARY KEY,
    symbol VARCHAR(50) NOT NULL,
    instrument_type VARCHAR(20),
    exchange_id VARCHAR(10) REFERENCES exchanges(exchange_id),
    UNIQUE(symbol, exchange_id, instrument_type)
);

CREATE TABLE trades (
    trade_id SERIAL PRIMARY KEY,
    instrument_id INTEGER REFERENCES instruments(instrument_id),
    trade_timestamp TIMESTAMP NOT NULL,
    expiry_date DATE,
    strike_price DECIMAL(15, 2),
    option_type VARCHAR(2),
    open_price DECIMAL(15, 2),
    high_price DECIMAL(15, 2),
    low_price DECIMAL(15, 2),
    close_price DECIMAL(15, 2),
    settle_price DECIMAL(15, 2),
    contracts_traded INTEGER,
    turnover DECIMAL(20, 2),
    open_interest BIGINT,
    change_in_oi BIGINT
);

-- 3. Insert exchange data
INSERT INTO exchanges VALUES 
('NSE', 'National Stock Exchange'),
('BSE', 'Bombay Stock Exchange'),
('MCX', 'Multi Commodity Exchange');

-- 4. Create indexes for performance
CREATE INDEX idx_trades_timestamp ON trades(trade_timestamp);
CREATE INDEX idx_trades_instrument ON trades(instrument_id);
CREATE INDEX idx_trades_expiry ON trades(expiry_date);