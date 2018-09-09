## Google search from R for JSNAs

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

search_term <- "jsna"

url <-URLencode(paste0("https://www.google.com/search?q=", search_term, "&num=",  100))




url1 <-URLencode(paste0("https://www.google.com/search?q=", search_term, "&num=",  100, "&start=", 100))

jsna1 <- read_html(url1)  

results1 <- jsna %>%
  html_nodes("cite") %>%
  html_text()

results_all <- c(results, results1)

results_all[1]

## Cambridge JSNAs

camb_jsna <- paste0(results_all[1], "published-joint-strategic-needs-assessments" )

camb_jsna_pdfs <- download_pdfs(camb_jsna)

cambs_jsna_pdfs <- camb_jsna_pdfs %>% 
  separate(doc_id, c("doc_id", "file", "topic"), sep = "/") %>%
  select(-file)

cambs_jsna_pdfs[1,]$text

kwic(corpus(cambs_jsna_pdfs$text), "fingertips")

                