### Travis Build Status [![Build Status](https://travis-ci.org/Ritayu09/Microsoft-API-Package.svg?branch=master)](https://travis-ci.org/Ritayu09/Microsoft-API-Package)

#### Contributions Code of Conduct

Please note that the 'TextSentiment' project is released with a
[Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By contributing to this project, you agree to abide by its terms.

### Package Details

This package introduces us to Microsoft’s set of tools, and shows how to apply them to data to generate sentiment using Microsoft Cognitive Services API.  

Before using this package, make sure that you have a valid Microsoft account have generated a valid Text Analytics API key for any one of the regions. Save your API key and region information as it will be required for extracting sentiment score. The package creates a wrapper around the RESTful API using POST method to get information.    

For more information about the Microsoft API, [click here](https://docs.microsoft.com/en-us/azure/cognitive-services/text-analytics/overview)

##### Batch Sentiment Request `get_batch_sentiment()`:

Batch sentiment request function lets you to send request to API for sentiment score in batch of 100 documents/sentences (default value) but batch size can be changed as per data volume.

```{r}
data_with_sentiment <- get_batch_sentiment(dataset, "api_key", "api_key_region", batch_size=100)
head(data_with_sentiment)
```
*Note: An additional 'Id' column will be created for the dataset passed to the function. Make sure that dataset does not contains any column named 'Id'*

##### Sentiment Distribution Analysis `sentiment_dist_plot()`:

The function produces a density or boxplot for the sentiment score generated using the Microsoft sentiment analysis API. Function divides data into categories based on user input values and produces distribution plot for each of the sentiment class.  

The funtion allows to classify the sentiment score in 3 categories - Negative, Neutral and Positive. The 'negative_cutoff' (default value = 0.35) and 'positive_start' (default value = 0.65) parameters govern the sentiment score range for all the 3 classes.  

```{r}
# 'density' parameter in graph type for density distribution plot
sentiment_dist_plot(data_with_sentiment, negative_cutoff = 0.35, positive_start = 0.65, graph_alpha = 0.5, graph_type = 'density')

# 'boxplot' parameter in graph type for generating boxplot for each category
sentiment_dist_plot(data_with_sentiment, negative_cutoff = 0.20, positive_start = 0.70, graph_alpha = 0.75, graph_type = 'boxplot')
```

The above distribution plots further help in analyzing the score within each class to better understand sentiment in each class.  
