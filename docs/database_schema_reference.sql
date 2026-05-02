-- Database Schema Reference for AH DCF Valuation System
-- This file is a design reference, not production implementation code.

CREATE TABLE stock_master (
    stock_code TEXT PRIMARY KEY,
    stock_name TEXT NOT NULL,
    market TEXT NOT NULL,
    exchange TEXT NOT NULL,
    industry TEXT,
    currency TEXT NOT NULL,
    listing_status TEXT NOT NULL,
    is_ah_dual_listed INTEGER NOT NULL,
    update_time TEXT NOT NULL
);

CREATE TABLE market_daily (
    trade_date TEXT NOT NULL,
    stock_code TEXT NOT NULL,
    close_price REAL NOT NULL,
    market_cap REAL,
    shares_outstanding REAL NOT NULL,
    turnover REAL,
    currency TEXT NOT NULL,
    data_source TEXT NOT NULL,
    PRIMARY KEY (trade_date, stock_code)
);

CREATE TABLE financial_statement (
    stock_code TEXT NOT NULL,
    report_date TEXT NOT NULL,
    fiscal_year INTEGER NOT NULL,
    statement_type TEXT NOT NULL,
    revenue REAL,
    ebit REAL,
    tax_expense REAL,
    depreciation_amortization REAL,
    capex REAL,
    operating_cash_flow REAL,
    cash REAL,
    total_debt REAL,
    currency TEXT NOT NULL,
    data_source TEXT NOT NULL,
    PRIMARY KEY (stock_code, report_date, statement_type)
);

CREATE TABLE valuation_assumption (
    valuation_date TEXT NOT NULL,
    stock_code TEXT NOT NULL,
    forecast_years INTEGER NOT NULL,
    revenue_growth_method TEXT,
    wacc REAL,
    risk_free_rate REAL,
    beta REAL,
    market_risk_premium REAL,
    cost_of_debt REAL,
    tax_rate REAL,
    terminal_growth_rate REAL,
    scenario TEXT,
    parameter_version TEXT NOT NULL,
    PRIMARY KEY (valuation_date, stock_code, scenario, parameter_version)
);

CREATE TABLE valuation_result (
    valuation_date TEXT NOT NULL,
    stock_code TEXT NOT NULL,
    market TEXT NOT NULL,
    close_price REAL,
    enterprise_value REAL,
    equity_value REAL,
    intrinsic_value_per_share REAL,
    valuation_gap REAL,
    wacc REAL,
    terminal_growth_rate REAL,
    terminal_value_ratio REAL,
    data_quality_flag TEXT NOT NULL,
    model_version TEXT NOT NULL,
    parameter_version TEXT NOT NULL,
    created_at TEXT NOT NULL,
    PRIMARY KEY (valuation_date, stock_code, model_version, parameter_version)
);
