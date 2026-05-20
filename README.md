# Quantitative Mean Reversion Signals — MQL4 Script

A MetaTrader 4 script that detects **statistically extreme price deviations** from a rolling mean using standard deviation analysis and fires alerts when price moves beyond a configurable number of standard deviations — signalling potential mean reversion setups.

---

## Overview

This script applies a quantitative mean reversion framework directly inside MT4. On each cycle it computes the rolling mean and population standard deviation of closing prices over a configurable lookback window, then measures how many standard deviations the current price sits from that mean. When the deviation exceeds the threshold, it alerts whether price is extended above or below — providing a statistically grounded entry signal for mean reversion strategies.

---

## Features

- **Rolling mean and standard deviation** — computed from scratch each cycle using `iClose()` over `LookbackPeriod` bars
- **Z-score style deviation measurement** — `|price − mean| / stdDev` compared against `DeviationThreshold`
- **Directional alerts** — distinguishes between deviation above and below the mean
- **Three notification channels:** sound alert, email, and mobile push
- **Lightweight loop** — polls once per minute (`Sleep(60000)`)
- Logs current price, mean, standard deviation, and deviation magnitude to the MT4 **Experts** tab

---

## How It Works

1. Every minute, `CalculateStats()` iterates over `LookbackPeriod` closing prices to compute:
   - `mean = sum / period`
   - `stdDev = sqrt((sumSq / period) − mean²)` (population standard deviation)
2. The current close is fetched via `iClose(..., 0)`
3. Deviation is computed: `deviation = |currentPrice − mean| / stdDev`
4. If `deviation >= DeviationThreshold`:
   - `currentPrice > mean` → **Extreme Deviation Above Mean**
   - `currentPrice < mean` → **Extreme Deviation Below Mean**
5. Alert message includes price, mean, stdDev, and deviation in standard deviations

---

## Input Parameters

| Parameter            | Type            | Default     | Description                                                 |
|----------------------|-----------------|-------------|-------------------------------------------------------------|
| `TradeSymbol`        | string          | `EURUSD`    | Symbol for analysis                                         |
| `Timeframe`          | ENUM_TIMEFRAMES | `PERIOD_H1` | Timeframe for analysis                                      |
| `LookbackPeriod`     | int             | `20`        | Bars used to compute rolling mean and standard deviation    |
| `DeviationThreshold` | double          | `2.0`       | Minimum deviation in standard deviations to trigger alert   |
| `EnableAlerts`       | bool            | `true`      | Fire an on-screen/sound alert                               |
| `EnableEmail`        | bool            | `false`     | Send an email notification                                  |
| `EnablePush`         | bool            | `false`     | Send a mobile push notification                             |

---

## Alert Message Format

```
Extreme Deviation Above Mean detected on EURUSD (Timeframe: PERIOD_H1)
Current Price: 1.08620
Mean Price: 1.08210
Std Dev: 0.00180
Deviation: 2.28 SD
```

---

## Installation

1. Copy `Bayesian_001.mq4` to `MQL4/Scripts/` in your MT4 data folder
2. Compile in MetaEditor (F7)
3. Drag onto any chart from Navigator → Scripts
4. Configure inputs and click **OK**

---

## Requirements

- MetaTrader 4 (`#property strict` compatible build)
- MQL4 compiler (MetaEditor)

---

## License

MIT License

Copyright (c) 2026

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
