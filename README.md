# Batch Backtester — MQL4 Script

A MetaTrader 4 script that automates the generation of **`.set` configuration files** for bulk backtesting by computing every combination of user-defined symbols, timeframes, risk percentages, stop losses, and take profits.

---

## Overview

Manually creating settings files for MT4 Strategy Tester across multiple parameter combinations is time-consuming and error-prone. This script accepts comma-separated lists for each parameter dimension, parses them using `StringSplit()`, and iterates through every combination to write a formatted `.set` file to the MT4 Files sandbox — ready to be loaded directly into the Strategy Tester.

---

## Features

- **Full combinatorial generation** — nested loops produce every symbol × timeframe × risk × SL × TP combination
- **Automatic `.set` file creation** — files written to the MT4 Files sandbox via `FileOpen()` / `FileWrite()`
- **Comma-separated list inputs** — no code changes needed to add new parameter values
- **Input validation** — aborts if any list is empty
- **Combination counter** — logs total files generated on completion
- All output and errors logged to the MT4 **Experts** tab

---

## How It Works

1. Five input strings are parsed into arrays using `StringSplit()` with `,` as delimiter
2. Five nested loops iterate every combination across: symbols × timeframes × risk percentages × stop losses × take profits
3. For each combination, `GenerateSettingsFile()` constructs a filename in the format `SYMBOL_TF_RISK_SL_TP.set` and writes a structured `[Inputs]` block via `FileWrite()`
4. The total count of generated files is printed to the Experts log on completion

---

## Input Parameters

| Parameter            | Type   | Default                    | Description                                      |
|----------------------|--------|----------------------------|--------------------------------------------------|
| `SymbolsList`        | string | `EURUSD,GBPUSD,USDJPY`     | Comma-separated list of symbols to test          |
| `TimeframesList`     | string | `H1,D1`                    | Comma-separated list of timeframes               |
| `RiskPercentagesList`| string | `1.0,2.0`                  | Comma-separated list of risk percentages         |
| `StopLossesList`     | string | `50,100`                   | Comma-separated stop loss values in pips         |
| `TakeProfitsList`    | string | `100,200`                  | Comma-separated take profit values in pips       |

---

## Output File Format

Each `.set` file is written to the MT4 Files sandbox (`MQL4/Files/`) in this structure:

```
[Inputs]
Symbol=EURUSD
Timeframe=H1
RiskPercent=1.0
StopLoss=50
TakeProfit=100
```

Filename example: `EURUSD_H1_1.0_50_100.set`

---

## Installation

1. Copy `Batch_Backtester_001.mq4` to `MQL4/Scripts/` in your MT4 data folder
2. Compile in MetaEditor (F7)
3. Drag onto any chart from Navigator → Scripts
4. Configure input lists and click **OK**
5. Retrieve generated `.set` files from `%APPDATA%\MetaQuotes\Terminal\<ID>\MQL4\Files\`

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
