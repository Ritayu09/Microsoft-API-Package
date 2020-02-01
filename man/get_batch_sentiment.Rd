\name{get_batch_sentiment}
\alias{get_batch_sentiment}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Sentiment Score Calculation
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
The function send batch request (100 IDs per request) to microsoft sentiment analysis API and get a sentiment score between 0 to 1 for each textual data point. Each document/sentence size should not exceed 5,120 character.
}
\usage{
get_batch_sentiment(data, auth_key, api_region)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{ dataframe with 2 columns - 'text' and 'language' - is necessary to get sentiment score. Other columns will be maintained as is in the returned dataframe. Check Microsoft API website for more information on language options available.
%%     ~~Describe \code{x} here~~
}
\item{auth_key}{ Authorization key associated with Microsoft API
%%     ~~Describe \code{x} here~~
}
\item{api_region}{ Provide region for which the authorization key is valid.
%%     ~~Describe \code{x} here~~
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
The API wrapper uses the Microsoft Cognitive Services - Text Analytics API. The API uses Sentiment Analysis - v2.1 version. API generates sentiment score between 0 and 1 with scores closer to 1 indicate positive sentiment and score close to 0 indicate negative sentiment.
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
\item{}{Function returns dataframe with additional 'Id' and 'Sentiment Score' columns for input data.}
%% ...
}
\references{
%% ~put references to the literature/web site here ~
\href{https://docs.microsoft.com/en-in/azure/cognitive-services/text-analytics/how-tos/text-analytics-how-to-sentiment-analysis?tabs=version-2}{Microsoft Sentiment Analysis Website}
}
\author{
%%  ~~who you are~~
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
\href{https://westcentralus.dev.cognitive.microsoft.com/docs/services/TextAnalytics-v2-1/operations/56f30ceeeda5650db055a3c9}{API Documentation}
}
\examples{

require(httr)
require(jsonlite)

sent_data <- c('It was a beautiful day', 'I do not like this game')
sent_lang <- c('en', 'en')
dataset <- data.frame('text'=sent_data, 'language'=sent_lang)

# auth_key is your unique API access key and has region associated with it

sentiment_data <- get_batch_sentiment (dataset, "eda0526b71ff44b29c", "westcentralus")

}
