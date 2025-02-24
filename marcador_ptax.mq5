//+------------------------------------------------------------------+
//|                                                marcador_ptax.mq5 |
//|                                  Copyright 2023, MetaQuotes Ltd. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2023, MetaQuotes Ltd."
#property link      "https://www.mql5.com"
#property version   "1.00"

#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit()
  {

   
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {

   
  }


// Função para verificar se o tempo corresponde a um dos horários alvo
bool IsTargetTime(datetime time)
{
   MqlDateTime tm;
   TimeToStruct(time, tm);
   
   if ((tm.hour == 10 && tm.min == 10) ||
       (tm.hour == 11 && tm.min == 10) ||
       (tm.hour == 12 && tm.min == 10) ||
       (tm.hour == 13 && tm.min == 10))
   {
      return true;
   }
   return false;
}

// Função para desenhar uma linha vertical no gráfico
void DrawVerticalLine(string name, datetime time, color clr)
{
   ObjectCreate(0, name, OBJ_VLINE, 0, time, 0);
   ObjectSetInteger(0, name, OBJPROP_COLOR, clr);
   ObjectSetInteger(0, name, OBJPROP_WIDTH, 1);
   ObjectSetInteger(0, name, OBJPROP_RAY_RIGHT, false);
}

//+------------------------------------------------------------------+
//| OnTick - Executado a cada novo tick                              |
//+------------------------------------------------------------------+
void OnTick()
{
   static datetime lastCheckedTime = 0;
   datetime currentTime = iTime(Symbol(), PERIOD_M1, 0);
   
   if (currentTime != lastCheckedTime && IsTargetTime(currentTime))
   {
      string lineName = "TimeMark_" + IntegerToString(currentTime);
      DrawVerticalLine(lineName, currentTime, clrRed);
      Print("Marcado horário: ", TimeToString(currentTime, TIME_SECONDS));
      lastCheckedTime = currentTime;
   }
}
