//+------------------------------------------------------------------+
//|                              BatchBacktester.mq4                 |
//|      Automates the preparation of settings for backtesting       |
//+------------------------------------------------------------------+
#property strict

// Input parameters
input string SymbolsList = "EURUSD,GBPUSD,USDJPY";    // Comma-separated list of symbols
input string TimeframesList = "H1,D1";               // Comma-separated list of timeframes
input string RiskPercentagesList = "1.0,2.0";        // Comma-separated list of risk percentages
input string StopLossesList = "50,100";              // Comma-separated list of stop losses in pips
input string TakeProfitsList = "100,200";            // Comma-separated list of take profits in pips

//+------------------------------------------------------------------+
//| Main Function                                                   |
//+------------------------------------------------------------------+
void OnStart()
{
   // Parse input strings into arrays
   string symbols[], timeframes[], riskPercentages[], stopLosses[], takeProfits[];
   int symbolCount = StringSplit(SymbolsList, ',', symbols);
   int timeframeCount = StringSplit(TimeframesList, ',', timeframes);
   int riskCount = StringSplit(RiskPercentagesList, ',', riskPercentages);
   int stopLossCount = StringSplit(StopLossesList, ',', stopLosses);
   int takeProfitCount = StringSplit(TakeProfitsList, ',', takeProfits);

   // Validate inputs
   if (symbolCount < 1 || timeframeCount < 1 || riskCount < 1 || stopLossCount < 1 || takeProfitCount < 1) {
      Print("Invalid input. Ensure all parameter lists are populated.");
      return;
   }

   // Generate combinations and create .set files
   int combinations = 0;
   for (int i = 0; i < symbolCount; i++) {
      for (int j = 0; j < timeframeCount; j++) {
         for (int k = 0; k < riskCount; k++) {
            for (int l = 0; l < stopLossCount; l++) {
               for (int m = 0; m < takeProfitCount; m++) {
                  // Generate settings file
                  string settingsFile = GenerateSettingsFile(
                     symbols[i], timeframes[j], riskPercentages[k], stopLosses[l], takeProfits[m]);
                  if (settingsFile != "") {
                     combinations++;
                     Print("Generated settings file: ", settingsFile);
                  }
               }
            }
         }
      }
   }

   Print("Batch Backtester completed. Total combinations: ", combinations);
}

//+------------------------------------------------------------------+
//| Function to Generate a .set File                                |
//+------------------------------------------------------------------+
string GenerateSettingsFile(string symbol, string timeframe, string risk, string stopLoss, string takeProfit)
{
   // File name for the .set file
   string fileName = StringFormat("%s_%s_%s_%s_%s.set", symbol, timeframe, risk, stopLoss, takeProfit);

   // Open file for writing
   int handle = FileOpen(fileName, FILE_WRITE | FILE_CSV, ";");
   if (handle < 0) {
      Print("Failed to create settings file: ", fileName);
      return "";
   }

   // Write settings to file
   FileWrite(handle, "[Inputs]");
   FileWrite(handle, "Symbol=", symbol);
   FileWrite(handle, "Timeframe=", timeframe);
   FileWrite(handle, "RiskPercent=", risk);
   FileWrite(handle, "StopLoss=", stopLoss);
   FileWrite(handle, "TakeProfit=", takeProfit);

   // Close the file
   FileClose(handle);

   // Return the file name
   return fileName;
}

