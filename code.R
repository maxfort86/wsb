install.packages("tidyquant")

library("tidyverse")
library("tidyquant")

options("getSymbols.warning4.0"=FALSE)
options("getSymbols.yahoo.warning"=FALSE)


#tickers = c("SPCE", "CPRX", "BABA", "AMZN", "SNE", "APHA", "GOOGL", "MSFT", "NRZ", "PLUG", "CRM", "PTON", "NKE", "PYPL", "FB", "GM", "KO", "V", "UBER", "MRNA", "ZNGA", "TXMD", "LI", "JNJ", "RCL", "NTDOY", "WMT", "DKNG", "AZN", "JPM", "PENN", "SNAP", "GE", "ET", "NOK", "BP", "DAL", "LUV", "DIS", "SIRI", "NFLX", "NVDA", "BAC", "AAPL", "NIO", "OGI", "WORK", "PFE", "SQ", "SBUX", "ZM", "KOS", "GILD", "UAL", "SAVE", "AMD", "BA", "NCLH", "BRK-B", "INTC", "T", "JBLU", "WFC", "MRO", "INO", "RKT", "TSLA", "CRON", "TWTR", "CGC", "BYND", "MGM", "AAL", "F", "ACB", "GPRO", "MFA", "TLRY", "CCL", "XOM", "HEXO", "FIT", "NKLA", "AMC", "PLTR", "WKHS", "GNUS", "FCEL", "VOO", "GUSH", "IDEX", "IVR", "PSEC", "ABNB", "USO", "UCO", "SPHD", "XPEV", "SRNE", "SPY", "GMRE", "HCAT", "MTBC", "RCM", "SRTS", "ARCC", "HZNP", "CHNG", "CNC", "VIAV", "CI", "LH", "LIVN", "EHC", "HAE", "AVTR", "TAK", "TENB", "PHR", "TFX", "HEAR", "PI", "SGRY", "QTS", "TRHC", "HELE", "NSIT", "IQV", "IRTC", "LHCG", "TMO", "JBL", "AMN", "AMED", "HTA", "TXMD", "UNH", "ITOCY", "RHHBY", "TKOMY", "JNJ", "HOLX", "MDT", "CVS", "ABT", "NUAN", "PHG", "ZBH", "HCA", "MRK", "ANTM", "HUM", "HQY", "BEAT", "SIEGY", "DGX", "VEEV", "MCK", "SWK", "BAYRY", "NVS", "DOC", "CSWC", "ABM", "VCRA", "CERN", "SNY", "GMED", "HMSY", "HOCPY", "PG", "CMPGY", "CDW", "WBS", "GE", "IDXX", "EGHT", "CBRE", "TDOC", "MOH", "ABC", "LLY", "CAE", "CHCT", "BDX", "EVH", "SLAB", "PEAK", "DRE", "NMFC", "TPVG", "TBK", "UHS", "LLESY", "EPAY", "FMS", "GSK", "COO", "TU", "XRAY", "DQ", "CKHUY", "SY", "QFIN", "ZLAB", "VNET", "HOLI", "BABA", "LX", "BILI", "TCEHY", "TAL", "GDS", "TTNDY", "HCM", "GHG", "AAGIY", "CEO", "MLCO", "YUMC", "CHU", "CHA", "BGNE", "HUYA", "CHL", "BCAUY", "HTHT", "BEST", "DAO", "ACH", "LFC", "CLPHY", "CEA", "HGKGY", "ATHM", "VIPS", "DOYU", "NIO", "TCOM", "SWRAY", "PDD", "AACAY", "IQ", "GSX", "CPRX", "VKTX", "EVRI", "MTNB", "RIGL", "GRWG", "OVID", "APPS", "ADMA", "GERN", "TBIO", "AUPH", "CBAY", "ARCT", "APTO", "PRPL", "MEIP", "AQST", "XFOR", "TRIL", "RAPT", "EXAS", "CLRB", "ORTX", "TGTX", "CYTK", "FIXX", "LOVE", "HARP", "SURF", "GMDA", "GTHX", "PRVL", "PHAS", "ALEC", "MOTS", "GOSS", "CALA", "SIEN", "BDSI", "IOVA", "EGAN", "RCKT", "BTAI", "NPSNY", "HTGC", "HRTX", "TXG", "ITCI", "ATNX", "ACAD", "SNPS", "ARCC", "RNG", "LHX", "APHA", "GLUU", "BILI", "TCEHY", "GOOGL", "GOOG", "CHNG", "MSFT", "LLNW", "KTOS", "KPTI", "ARVN", "DHR", "ICE", "PLUG", "WIX", "WIFI", "QIWI", "NBIX", "RCUS", "ADVM", "GWPH", "CRM", "CARA", "DTIL", "PING", "MYOV", "CRNC", "LITE", "DAN", "LRCX", "TSM", "MRSN", "DT", "TAK", "PYPL", "FB", "HEAR", "ALNA", "ABEO", "SNDX", "OSMT", "DD", "SE", "BSX", "GRWG", "NOVA", "INN", "LOVE", "CKHUY", "EGAN", "LAD", "SNX", "BABA", "ETSY", "AMZN", "ARCC", "SNE", "SFTBY", "WH", "KEYS", "MDLZ", "SKX", "VST", "TAL", "MSFT", "WYND", "TTNDY", "TJX", "WIX", "WIFI", "QIWI", "LSCC", "NXST", "PTON", "FUN", "VAC", "NKE", "ATVI", "JD", "MGP", "VLO", "MSGS", "FHN", "NJDCY", "FLWS", "MBUU", "FUJIY", "PYPL", "SU", "HEAR", "SPWH", "RC", "PI", "TAST", "LKQ", "GTN", "DD", "SE", "BLK", "MLCO", "BAM", "GPN", "KO", "TMUS", "CHGG", "NRG", "FTCH", "KMX", "BZUN", "ATUS", "TTWO", "FIS", "LVS", "ITOCY", "NCR", "ROST", "OLLI", "LOW", "JNJ", "HAS", "IIVI", "NTDOY", "WMT", "MU", "CVS", "VWAGY", "REAL", "BDORY", "PHG", "EL", "AEP", "GOOS", "IMBBY", "MFC", "ELF", "TSCDY", "FIVE", "TWNK", "STAY", "EPRT", "HUM", "BIDU", "FDX")

tickers = c("SPCE", "CPRX", "BABA", "AMZN", "SNE", "APHA", "GOOGL", "MSFT", "NRZ", "PLUG", "CRM", "PTON", "NKE", "PYPL", "FB", "GM", "KO", "V", "UBER", "MRNA", "ZNGA", "TXMD", "LI", "JNJ", "RCL", "NTDOY", "WMT", "DKNG", "AZN", "JPM", "PENN", "SNAP", "GE", "ET", "NOK", "BP", "DAL", "LUV", "DIS", "SIRI", "NFLX", "NVDA", "BAC", "AAPL", "NIO", "OGI", "WORK", "PFE", "SQ", "SBUX", "ZM", "KOS", "GILD", "UAL", "SAVE", "AMD", "BA", "NCLH", "BRK-B", "INTC", "T", "JBLU", "WFC", "MRO", "INO", "RKT", "TSLA", "CRON", "TWTR", "CGC", "BYND", "MGM", "AAL", "F", "ACB", "GPRO", "MFA", "TLRY", "CCL", "XOM", "HEXO", "FIT", "NKLA", "AMC", "PLTR", "WKHS", "GNUS", "FCEL", "VOO", "GUSH", "IDEX", "IVR", "PSEC", "ABNB", "USO", "UCO", "SPHD", "XPEV", "SRNE", "SPY")

tickers <- unique(tickers)

prices <- tq_get(tickers,
                 from = "2020-01-01",
                 to = "2020-12-19",
                 get = "stock.prices")


prices <- prices %>% mutate(r = (close - open) / open * 100) %>% select(symbol, date, r)

prices2 <- prices %>% pivot_wider(names_from = symbol, values_from = r) %>% rename(BRKB = `BRK-B`)

#tickers = c("SPCE", "CPRX", "BABA", "AMZN", "SNE", "APHA", "GOOGL", "MSFT", "NRZ", "PLUG", "CRM", "PTON", "NKE", "PYPL", "FB", "GM", "KO", "V", "UBER", "MRNA", "ZNGA", "TXMD", "LI", "JNJ", "RCL", "NTDOY", "WMT", "DKNG", "AZN", "JPM", "PENN", "SNAP", "GE", "ET", "NOK", "BP", "DAL", "LUV", "DIS", "SIRI", "NFLX", "NVDA", "BAC", "AAPL", "NIO", "OGI", "WORK", "PFE", "SQ", "SBUX", "ZM", "KOS", "GILD", "UAL", "SAVE", "AMD", "BA", "NCLH", "BRKB", "INTC", "T", "JBLU", "WFC", "MRO", "INO", "RKT", "TSLA", "CRON", "TWTR", "CGC", "BYND", "MGM", "AAL", "F", "ACB", "GPRO", "MFA", "TLRY", "CCL", "XOM", "HEXO", "FIT", "NKLA", "AMC", "PLTR", "WKHS", "GNUS", "FCEL", "VOO", "GUSH", "IDEX", "IVR", "PSEC", "ABNB", "USO", "UCO", "SPHD", "XPEV", "SRNE", "GMRE", "HCAT", "MTBC", "RCM", "SRTS", "ARCC", "HZNP", "CHNG", "CNC", "VIAV", "CI", "LH", "LIVN", "EHC", "HAE", "AVTR", "TAK", "TENB", "PHR", "TFX", "HEAR", "PI", "SGRY", "QTS", "TRHC", "HELE", "NSIT", "IQV", "IRTC", "LHCG", "TMO", "JBL", "AMN", "AMED", "HTA", "TXMD", "UNH", "ITOCY", "RHHBY", "TKOMY", "JNJ", "HOLX", "MDT", "CVS", "ABT", "NUAN", "PHG", "ZBH", "HCA", "MRK", "ANTM", "HUM", "HQY", "BEAT", "SIEGY", "DGX", "VEEV", "MCK", "SWK", "BAYRY", "NVS", "DOC", "CSWC", "ABM", "VCRA", "CERN", "SNY", "GMED", "HMSY", "HOCPY", "PG", "CMPGY", "CDW", "WBS", "GE", "IDXX", "EGHT", "CBRE", "TDOC", "MOH", "ABC", "LLY", "CAE", "CHCT", "BDX", "EVH", "SLAB", "PEAK", "DRE", "NMFC", "TPVG", "TBK", "UHS", "LLESY", "EPAY", "FMS", "GSK", "COO", "TU", "XRAY", "DQ", "CKHUY", "SY", "QFIN", "ZLAB", "VNET", "HOLI", "BABA", "LX", "BILI", "TCEHY", "TAL", "GDS", "TTNDY", "HCM", "GHG", "AAGIY", "CEO", "MLCO", "YUMC", "CHU", "CHA", "BGNE", "HUYA", "CHL", "BCAUY", "HTHT", "BEST", "DAO", "ACH", "LFC", "CLPHY", "CEA", "HGKGY", "ATHM", "VIPS", "DOYU", "NIO", "TCOM", "SWRAY", "PDD", "AACAY", "IQ", "GSX", "CPRX", "VKTX", "EVRI", "MTNB", "RIGL", "GRWG", "OVID", "APPS", "ADMA", "GERN", "TBIO", "AUPH", "CBAY", "ARCT", "APTO", "PRPL", "MEIP", "AQST", "XFOR", "TRIL", "RAPT", "EXAS", "CLRB", "ORTX", "TGTX", "CYTK", "FIXX", "LOVE", "HARP", "SURF", "GMDA", "GTHX", "PRVL", "PHAS", "ALEC", "MOTS", "GOSS", "CALA", "SIEN", "BDSI", "IOVA", "EGAN", "RCKT", "BTAI", "NPSNY", "HTGC", "HRTX", "TXG", "ITCI", "ATNX", "ACAD", "SNPS", "ARCC", "RNG", "LHX", "APHA", "GLUU", "BILI", "TCEHY", "GOOGL", "GOOG", "CHNG", "MSFT", "LLNW", "KTOS", "KPTI", "ARVN", "DHR", "ICE", "PLUG", "WIX", "WIFI", "QIWI", "NBIX", "RCUS", "ADVM", "GWPH", "CRM", "CARA", "DTIL", "PING", "MYOV", "CRNC", "LITE", "DAN", "LRCX", "TSM", "MRSN", "DT", "TAK", "PYPL", "FB", "HEAR", "ALNA", "ABEO", "SNDX", "OSMT", "DD", "SE", "BSX", "GRWG", "NOVA", "INN", "LOVE", "CKHUY", "EGAN", "LAD", "SNX", "BABA", "ETSY", "AMZN", "ARCC", "SNE", "SFTBY", "WH", "KEYS", "MDLZ", "SKX", "VST", "TAL", "MSFT", "WYND", "TTNDY", "TJX", "WIX", "WIFI", "QIWI", "LSCC", "NXST", "PTON", "FUN", "VAC", "NKE", "ATVI", "JD", "MGP", "VLO", "MSGS", "FHN", "NJDCY", "FLWS", "MBUU", "FUJIY", "PYPL", "SU", "HEAR", "SPWH", "RC", "PI", "TAST", "LKQ", "GTN", "DD", "SE", "BLK", "MLCO", "BAM", "GPN", "KO", "TMUS", "CHGG", "NRG", "FTCH", "KMX", "BZUN", "ATUS", "TTWO", "FIS", "LVS", "ITOCY", "NCR", "ROST", "OLLI", "LOW", "JNJ", "HAS", "IIVI", "NTDOY", "WMT", "MU", "CVS", "VWAGY", "REAL", "BDORY", "PHG", "EL", "AEP", "GOOS", "IMBBY", "MFC", "ELF", "TSCDY", "FIVE", "TWNK", "STAY", "EPRT", "HUM", "BIDU", "FDX")

tickers = c("SPCE", "CPRX", "BABA", "AMZN", "SNE", "APHA", "GOOGL", "MSFT", "NRZ", "PLUG", "CRM", "PTON", "NKE", "PYPL", "FB", "GM", "KO", "V", "UBER", "MRNA", "ZNGA", "TXMD", "LI", "JNJ", "RCL", "NTDOY", "WMT", "DKNG", "AZN", "JPM", "PENN", "SNAP", "GE", "ET", "NOK", "BP", "DAL", "LUV", "DIS", "SIRI", "NFLX", "NVDA", "BAC", "AAPL", "NIO", "OGI", "WORK", "PFE", "SQ", "SBUX", "ZM", "KOS", "GILD", "UAL", "SAVE", "AMD", "BA", "NCLH", "BRKB", "INTC", "T", "JBLU", "WFC", "MRO", "INO", "RKT", "TSLA", "CRON", "TWTR", "CGC", "BYND", "MGM", "AAL", "F", "ACB", "GPRO", "MFA", "TLRY", "CCL", "XOM", "HEXO", "FIT", "NKLA", "AMC", "PLTR", "WKHS", "GNUS", "FCEL", "VOO", "GUSH", "IDEX", "IVR", "PSEC", "ABNB", "USO", "UCO", "SPHD", "XPEV", "SRNE")

tickers <- unique(tickers)

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
    
    if(sum(prices2[, t_today], na.rm = T) < 5 | sum(prices2[, t_tomorrow], na.rm = T) < 5){
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




reg <- lm(lead(`F`) ~ BA, prices2)
summary(reg)
