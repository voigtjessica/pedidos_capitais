#Function not in

`%notin%` = function(x,y) !(x %in% y)

# Planilha das Capitais do BR

library(dplyr)
library(tibble)
library(googlesheets)

obras <- read.csv(url("http://simec.mec.gov.br/painelObras/download.php"), sep=";")


#Capitais do BR

capitais <- c( "Município, UF", "Rio Branco, AC", "Maceió, AL",
               "Macapá, AP", "Manaus, AM", "Salvador, BA",
               "Fortaleza, CE", "Brasília, DF", "Vitória, ES", 
               "Goiânia, GO", "São Luís, MA",
               "Cuiabá, MT", "Campo Grande, MS", 
               "Belo Horizonte, MG", "Belém, PA", 
               "João Pessoa, PB", "Curitiba, PR", 
               "Recife, PE", "Teresina, PI", "Rio de Janeiro, RJ",
               "Natal, RN", "Porto Alegre, RS", "Porto Velho, RO", 
               "Boa Vista, RR", "Florianópolis, SC",
               'São Paulo, SP', "Aracaju, SE", "Palmas, TO")


capitais <- read.csv(text = capitais , strip.white = TRUE)


filtro_google_situacao <- c("Inacabada",
                            "Planejamento pelo proponente",
                            "Execução",
                            "Paralisada",
                            "Contratação",
                            "Licitação",
                            "Em Reformulação")

filtro_google_tipodeprojeto <- c("Espaço Educativo - 12 Salas",
                                 "Espaço Educativo - 01 Sala",
                                 "Espaço Educativo - 02 Salas",
                                 "Espaço Educativo - 04 Salas",
                                 "Espaço Educativo - 06 Salas",
                                 "Projeto 1 Convencional",
                                 "Projeto 2 Convencional")  

pedidos_capitais <- obras %>%
  filter(Tipo.do.Projeto %notin% filtro_google_tipodeprojeto,
         Situação %in% filtro_google_situacao) %>%
  inner_join(capitais)

#validado =)

setwd("C:\\Users\\jvoig\\OneDrive\\Documentos\\tadepe\\cronogramas_capitais")
write.table(pedidos_capitais, 
            file="pedidos_capitais.csv", sep=";",
            row.names = FALSE)
