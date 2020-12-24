
#####Pacotes####

library(comtradr) # This package allows users to interact with the API directly from R, and features functions for making queries and importing data
library(tidyverse)
library(ggplot2)
library(extrafont)
extrafont::font_import()
extrafont::loadfonts()


# str(dadosbol) # consulta das variáveis 



#####Coleta dos dados #####

#dados sobre o Ecuador

ecuadorexpo <- ct_search(reporters = "Ecuador", 
                      partners = c("China", "USA"), 
                      trade_direction = "exports")

ecuadorimpo <- ct_search(reporters = "Ecuador", 
                     partners = c("China", "USA"), 
                     trade_direction = "imports")

dadosecu <- merge(ecuadorexpo, ecuadorimpo, all = T)


#dados sobre a Bolívia


bolexpo <- ct_search(reporters = "Bolivia (Plurinational State of)", 
                         partners = c("China", "USA"), 
                         trade_direction = "exports")


bolimpor <- ct_search(reporters = "Bolivia (Plurinational State of)", 
                     partners = c("China", "USA"), 
                     trade_direction = "imports")


dadosbol <- merge(bolexpo, bolimpor, all = T)


#write_csv2(dadosecu, "dadosecu.csv")
#write_csv2(dadosbol, "dadosbol.csv")

#gráficos


#grafico ecuador

ecu <- ggplot(dadosecu) +
 aes(x = year, y = trade_value_usd, colour = partner) +
 geom_line(size = 1L) +
 scale_color_hue() +
 labs(x = "  ", y = "Value (USD)", color = "  ") +
 theme_classic(base_size = 10) +
 facet_wrap(vars(trade_flow))+
 scale_y_continuous(labels = scales::dollar_format(), breaks = waiver()) +
 scale_x_continuous(limits = c(1991, 2020))

ecu + theme(text = element_text(family = "Cambria", size = 10))



#grafico Bolivia

bol <- ggplot(dadosbol) +
  aes(x = year, y = trade_value_usd, colour = partner) +
  geom_line(size = 1L) +
  scale_color_hue() +
  labs(x = "", y = "Value (USD)", color = " ") +
  theme_classic(base_size = 10) +
  facet_wrap(vars(trade_flow)) +
  scale_y_continuous(labels = scales::dollar) +
  scale_x_continuous(limits = c(1991, 2020))

bol + theme(text = element_text(family = "Cambria", size = 10))


citation("comtradr")

