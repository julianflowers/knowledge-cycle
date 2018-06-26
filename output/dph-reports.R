## Script for scraping DPH reports from LGA website

library(pacman)
p_load(rvest, tidyverse, readtext, myScrapers)

url <- "https://www.local.gov.uk/directors-public-health-annual-reports"
get_links <- function(url){
  read_html(url) %>%
    html_nodes("a") %>%
    html_attr("href")
  
}

links_lga <- get_links(url) %>%
  .[81:166] %>%
  .[!is.na(.)]

  
  
get_pdfs <- links_lga[grepl("pdf", links_lga)]  
  

pdf1 <- downloader::download(get_pdfs, destfile = paste0("file", 1:20, ".pdf"))

files <- list.files(pattern = "*.pdf")

dph_pdf <- readtext::readtext(files[1:15]) 


dph_pdf %>%
  group_by(doc_id) %>%
  create_bigrams(text) %>%
  count(bigram) %>%
  filter(n > 9) %>%
  create_network_plot(textsize = 2, layout = "fr")


dph_pdf %>%
  group_by(doc_id) %>%
  create_bigrams(text) %>%
  count(bigram) %>%
  filter(n > 19) %>%
  ggplot(aes(doc_id, bigram, fill = n)) +
  geom_tile() +
  theme(axis.text.x = element_text(size = 7, angle = 45, hjust = 1)) +
  coord_flip() +
  scale_color_manual(position = "top")
  
  