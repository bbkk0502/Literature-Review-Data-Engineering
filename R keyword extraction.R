x <- udpipe_download_model(language = "english")
x$file_model
if(!x$download_failed){
  ud_dutch <- udpipe_load_model(x$file_model)
}



udmodel <- udpipe_load_model(file = "english-ewt-ud-2.4-190531.udpipe")
x <- udpipe_annotate(udmodel, x = abstract$AB)
x <- as.data.frame(x)

#option 1: extract only nouns
stats <- subset(x, upos %in% "NOUN")
stats <- txt_freq(x = stats$lemma)
library(lattice)
stats$key <- factor(stats$key, levels = rev(stats$key))
barchart(key ~ freq, data = head(stats, 50), col = "cadetblue", main = "Most occurring nouns", xlab = "Freq")
head(stats, 50) #top 50 words

#option 2:
## Collocation (words following one another)
stats2 <- keywords_collocation(x = x, 
                              term = "token", group = c("doc_id", "paragraph_id", "sentence_id"),
                              ngram_max = 4)

## Co-occurrences: How frequent do words occur in the same sentence, in this case only nouns or adjectives
stats3 <- cooccurrence(x = subset(x, upos %in% c("NOUN", "ADJ")), 
                      term = "lemma", group = c("doc_id", "paragraph_id", "sentence_id"))

## Co-occurrences: How frequent do words follow one another
stats4 <- cooccurrence(x = x$lemma, 
                      relevant = x$upos %in% c("NOUN", "ADJ"))

## Co-occurrences: How frequent do words follow one another even if we would skip 2 words in between
stats5 <- cooccurrence(x = x$lemma, 
                      relevant = x$upos %in% c("NOUN", "ADJ"), skipgram = 2)

head(stats5)

#visualise
library(igraph)
library(ggraph)
library(ggplot2)
wordnetwork <- head(stats2, 30)
wordnetwork <- graph_from_data_frame(wordnetwork)
ggraph(wordnetwork, layout = "fr") +
  geom_edge_link(aes(width = cooc, edge_alpha = cooc), edge_colour = "pink") +
  geom_node_text(aes(label = name), col = "darkgreen", size = 4) +
  theme_graph(base_family = "Arial Narrow") +
  theme(legend.position = "none") +
  labs(title = "Cooccurrences within 3 words distance", subtitle = "Nouns & Adjective")

#Option 3: Textrank
stats6 <- textrank_keywords(x$lemma, 
                           relevant = x$upos %in% c("NOUN", "ADJ"), 
                           ngram_max = 8, sep = " ")
stats6 <- subset(stats6$keywords, ngram > 1 & freq >= 5)
#library(wordcloud)
#wordcloud(words = stats6$keyword, freq = stats6$freq)


#option 4: phrase
x$phrase_tag <- as_phrasemachine(x$upos, type = "upos")
stats7 <- keywords_phrases(x = x$phrase_tag, term = x$token, 
                          pattern = "(A|N)+N(P+D*(A|N)*N)*", 
                          is_regex = TRUE, ngram_max = 4, detailed = FALSE)
head(subset(stats7, ngram > 2))