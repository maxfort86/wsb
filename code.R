install.packages("tidyquant")

library("tidyverse")
library("tidyquant")

options("getSymbols.warning4.0"=FALSE)
options("getSymbols.yahoo.warning"=FALSE)


tickers = c("SPCE", "CPRX", "BABA", "AMZN", "SNE", "APHA", "GOOGL", "MSFT", "NRZ", "PLUG", "CRM", "PTON", "NKE", "PYPL", "FB", "GM", "KO", "V", "UBER", "MRNA", "ZNGA", "TXMD", "LI", "JNJ", "RCL", "NTDOY", "WMT", "DKNG", "AZN", "JPM", "PENN", "SNAP", "GE", "ET", "NOK", "BP", "DAL", "LUV", "DIS", "SIRI", "NFLX", "NVDA", "BAC", "AAPL", "NIO", "OGI", "WORK", "PFE", "SQ", "SBUX", "ZM", "KOS", "GILD", "UAL", "SAVE", "AMD", "BA", "NCLH", "BRK-B", "INTC", "T", "JBLU", "WFC", "MRO", "INO", "RKT", "TSLA", "CRON", "TWTR", "CGC", "BYND", "MGM", "AAL", "F", "ACB", "GPRO", "MFA", "TLRY", "CCL", "XOM", "HEXO", "FIT", "NKLA", "AMC", "PLTR", "WKHS", "GNUS", "FCEL", "VOO", "GUSH", "IDEX", "IVR", "PSEC", "ABNB", "USO", "UCO", "SPHD", "XPEV", "SRNE", "SPY")

prices <- tq_get(tickers,
                 from = "2020-01-01",
                 to = "2020-12-19",
                 get = "stock.prices")


prices <- prices %>% mutate(r = (close - open) / open * 100) %>% select(symbol, date, r)

prices2 <- prices %>% pivot_wider(names_from = symbol, values_from = r) %>% rename(BRKB = `BRK-B`)

tickers = c("SPCE", "CPRX", "BABA", "AMZN", "SNE", "APHA", "GOOGL", "MSFT", "NRZ", "PLUG", "CRM", "PTON", "NKE", "PYPL", "FB", "GM", "KO", "V", "UBER", "MRNA", "ZNGA", "TXMD", "LI", "JNJ", "RCL", "NTDOY", "WMT", "DKNG", "AZN", "JPM", "PENN", "SNAP", "GE", "ET", "NOK", "BP", "DAL", "LUV", "DIS", "SIRI", "NFLX", "NVDA", "BAC", "AAPL", "NIO", "OGI", "WORK", "PFE", "SQ", "SBUX", "ZM", "KOS", "GILD", "UAL", "SAVE", "AMD", "BA", "NCLH", "BRKB", "INTC", "T", "JBLU", "WFC", "MRO", "INO", "RKT", "TSLA", "CRON", "TWTR", "CGC", "BYND", "MGM", "AAL", "F", "ACB", "GPRO", "MFA", "TLRY", "CCL", "XOM", "HEXO", "FIT", "NKLA", "AMC", "PLTR", "WKHS", "GNUS", "FCEL", "VOO", "GUSH", "IDEX", "IVR", "PSEC", "USO", "UCO", "SPHD", "XPEV", "SRNE")

for(ticker in tickers){
  prices2[, ticker] = prices2[, ticker] - prices2[, "SPY"]
  prices2[, ticker] = ifelse(prices2[, ticker] >= 4.99, 1, 0)
}

results = tibble(today = c(), tomorrow = c(), t = c(), b = c())

for(t_today in tickers){
  best_sym = '';
  best_b = 0;
  best_t = 0
  for(t_tomorrow in tickers){
    
    if(t_today == t_tomorrow){
      next
    }
    
    if(sum(prices2[, t_today], na.rm = T) < 3 | sum(prices2[, t_tomorrow], na.rm = T) < 3){
      next
    }

    prices2 <- prices2 %>% mutate(lead_moon = lead(get(t_tomorrow)))
    
    f <- str_c("lead_moon ~ ", t_today)
    reg <- summary(lm(as.formula(f), prices2))
    
    if( nrow(coef(reg)) < 2){
      next
    }
    
    if(coef(reg)[t_today, 2] == 0){
      next
    }
    
    t <- coef(reg)[t_today, 3]
    
    if(abs(t) > abs(best_t) ){
      best_t = t
      best_b <- coef(reg)[t_today, 1]
      best_sym <- t_tomorrow
    }
    
  }
  
  results <- bind_rows(results, tibble(today = t_today, tomorrow = best_sym, t = best_t, b = best_b))
}





