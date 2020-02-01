\name{sentiment_dist_plot}
\alias{sentiment_dist_plot}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Sentiment Distribution Plot
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
The function produces a density or boxplot for the sentiment score generated using the Microsoft sentiment analysis API. Function divides data into negative, neutral and positive sentiment based on user input values and produces distribution plot for each of the sentiment class.
}
\usage{
sentiment_dist_plot(data, negative_cutoff = 0.35, positive_start = 0.65, graph_alpha = 0.5, graph_type = 'density')
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{ Dataframe containing 'Sentiment Score' column for plotting distribution plot.
}
\item{negative_cutoff}{ Maximum cutoff value for sentiment score to be considered as 'Negative'. The cutoff value will not be bounded (i.e. not inclusive) for negative sentiment. Scores from 0 to cutoff will be considered negative sentiment.
}
\item{positive_start}{ Minimum value for sentiment to be considered as 'Positive'. The value is inclusive for positive sentiment tagging. Scores between positive_start to 1 will be considered positive sentiment.
}
\item{graph_alpha}{ alpha parameter controls the transparency of the plot. Default value considered is 0.5 and it varies from 0 (transparent) to 1 (opaque).
}
\item{graph_type}{ Parameter for type of plot. Function accepts 'density' and 'boxplot' as input values and default value is 'density'.
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
The function helps visualize the results generated for sentiment analysis. The 'Sentiment Score' generated for each sentence is classified under 'Negative', 'Neutral' and 'Positive' sentiment considering user input and density or boxplot is generated for each of the sentiment class to further understand the score distribution within the class. Sentiment score between 'negative_cutoff' and 'positive_start' are tagged under 'Neutral' category.
}
\value{
Function returns requested graph using ggplot2 library.
}
\references{
%% ~put references to the literature/web site here ~
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
}
\examples{

require(ggplot2)

# using get_batch_sentiment function available in the same package to generate sentiment score

sentiment_data <- get_batch_sentiment (dataset, "eda0526b71ff44b29c", "westcentralus")

# density plot

sentiment_dist_plot(sentiment_data, negative_cutoff = 0.35, positive_start = 0.65, graph_alpha = 0.5, graph_type = 'density')

# boxplot

sentiment_dist_plot(sentiment_data, negative_cutoff = 0.3, positive_start = 0.6, graph_alpha = 0.75, graph_type = 'boxplot')

}
