library(testthat)
library(proto)
library(TextSentiment)

# correct dataframe format
data.test <- data.frame('text' = c('I am good Person', 'This is bad game'), 'language' = c('en', 'en'))

# incorrect dataframe, language column not present
data.test2 <- data.frame('text' = c('I am good Person', 'This is bad game'), 'text_lang' = c('en', 'en'))

# incorrect dataframe, language format 'eng' is incorrect
data.test3 <- data.frame('text' = c('I am good Person', 'This is bad game'), 'language' = c('en', 'eng'))

# expected results
expected_result <- data.frame('Id' = c(1,2), 'text' = c('I am good Person', 'This is bad game'), 'language' = c('en', 'en'), 'Sentiment Score' = c(0.9909486,0.1099730), check.names = FALSE)
expected_result2 <- data.frame('Id' = c(1,2), 'text' = c('I am good Person', 'This is bad game'), 'language' = c('en', 'eng'), 'Sentiment Score' = c(0.9909486,NA), check.names = FALSE)

# testing sentiment score function
test_that("sentiment score from text", {
  sentiment_res <- get_batch_sentiment(data.test, "eda0526b71ff44b29c259b9a37fa4970", "westcentralus")
  sentiment_res1 <- get_batch_sentiment(data.test, "eda0526b71ff44b29c259b9a37fa4911", "westcentralus")
  sentiment_res3 <- get_batch_sentiment(data.test2, "eda0526b71ff44b29c259b9a37fa4970", "westcentralus")
  sentiment_res4 <- get_batch_sentiment(data.test3, "eda0526b71ff44b29c259b9a37fa4970", "westcentralus")
  expect_equal(sentiment_res, expected_result, tolerance = 0.00999)
  expect_equal(sentiment_res1, NA)
  expect_error(get_batch_sentiment(data.test, "eda0526b71ff44b29c259b9a37fa4911", "westcentralsu"))
  expect_equal(sentiment_res3, NA)
  expect_equal(sentiment_res4, expected_result2, tolerance = 0.00999)
})

# testing plotting function

# Sentiment Score column is necessary for distribution function to work
dummy_results <- data.frame('Id' = c(1:100), 'Sentiment Score' = runif(100), check.names = FALSE)
dummy_results2 <- data.frame('Id' = c(1:100), 'Sentiment' = runif(100), check.names = FALSE)

test_that("Plot layers match expectations",{
  dist.plot <- sentiment_dist_plot(dummy_results, graph_type = 'boxplot')
  dist.plot2 <- sentiment_dist_plot(dummy_results, graph_type = 'density')
  dist.plot3 <- sentiment_dist_plot(dummy_results, positive_start=1.1)
  dist.plot4 <- sentiment_dist_plot(dummy_results2, graph_alpha = 0.75)
  dist.plot5 <- sentiment_dist_plot(dummy_results, negative_cutoff = 0.6, positive_start = 0.45)
  dist.plot6 <- sentiment_dist_plot(dummy_results, graph_type = 'scatter')

  expect_identical(sapply(dist.plot$layers, function(x) class(x$geom)[1]), "GeomBoxplot")
  expect_identical(sapply(dist.plot2$layers, function(x) class(x$geom)[1]), "GeomDensity")
  expect_identical(dist.plot3, "Error: Sentiment Cutoff values cannot be greater than 1.0")
  expect_identical(dist.plot4, "Error: 'Sentiment Score' column not provided in data.")
  expect_identical(dist.plot5, "Error: Either non numeric input for sentiment score cutoff or negative score cutoff is greater than positive score cutoff")
  expect_identical(dist.plot6, "Error: Invalid Graph Type Passed")

})





