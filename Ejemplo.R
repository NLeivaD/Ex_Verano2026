library(tidyquant)
df_msft <- tq_get("MSFT",
                  from = "2020-01-01",
                  to = "2020-12-31")
df_nvda <- tq_get("NVDA",
                  from = "2020-01-01",
                  to = "2020-12-31")
library(dplyr)
df_msft <- df_msft |> 
  mutate(Retorno = 100 * log(adjusted / lag(adjusted)))
df_nvda <- df_nvda |> 
  mutate(Retorno = 100 * log(adjusted / lag(adjusted)))

var_msft <- var(df_msft$Retorno, na.rm = TRUE)
var_nvda <- var(df_nvda$Retorno, na.rm = TRUE)
cov_2 <- var(df_msft$Retorno, df_nvda$Retorno, na.rm = TRUE)

w_msft <- (var_nvda - cov_2) / (var_msft + var_nvda - 2 * cov_2)
w_nvda <- 1 - w_msft
