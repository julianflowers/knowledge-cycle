library(pacman)
p_load(httr, searchConsoleR, rvest, RCurl, XML, urltools, quanteda)

download_pdfs <- function(url){
  require(rvest)
  require(dplyr)
  require(readtext)
  
  pdfs- read_html(url) %>%
    html_nodes("a") %>%
    html_attr("href") %>%
    .[grepl("pdf", .)] %>%
    readtext()
}

search_term <- "director public health annual report"

url <-URLencode(paste0("https://www.google.com/search?q=", search_term, "&num=",  100))
aphr <- read_html(url)  

results <- aphr %>%
  html_nodes("cite") %>%
  html_text()

aphr <- read_html(url)  

results <- aphr %>%
  html_nodes("a") %>%
  html_attr("href") 

aphr_links <- results %>%
  str_extract_all(., "http.+") %>%
  str_replace_all(., "&.+", "") %>%
  .[str_detect(. , "^http")] %>%
  .[!str_detect(., "webcache|\\+")]

aphr_pdfs <- aphr_links %>%
  .[str_detect(. , "pdf$")]

aphr_pdfs1 <- readtext(aphr_pdfs[c(1:4, 6:8, 10:11, 13:16, 18:19, 22)]) 

corpus <- corpus(aphr_pdfs1)

corpus

kwic(corpus, "finger*", 10) %>% View()
kwic(corpus, "phe*", 10) %>% View()


