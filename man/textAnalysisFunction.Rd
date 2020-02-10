\name{textAnalysisFunction}
\alias{textAnalysisFunction}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
Text analysis function for obtaining the sentiment of a row of text input in a csv file
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
This function allows users to pass in a Microsoft text analysis api key, sequence if Rows to be processed and a file (currently only csv is supported in very specific format. Please see test.csv file for what columns might be needed) to obtain a sentiment score for text in the file. This function outputs a dataframe with 8 columns including text, Id, sentiment scre and some infomartion about status code and error message from the microsoft text analytics api call
}
\usage{
textAnalysisFunction(filename, IDs, key)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{filename}{
%%     ~~Describe \code{filename} here~~
filename is the name of file that need to be processed currently only csv files are supported. please see test.csv file for format of columns that are needed.
}
  \item{IDs}{
%%     ~~Describe \code{IDs} here~~
this is a sequence of ID's that need to be processed in the dataset that's being processed by user
example : 1:10 if only first ten rows need to be processed
}
  \item{key}{
%%     ~~Describe \code{key} here~~
Miscrosoft Text Analytics API Subscription Key. (You might need to create an account to get one)
}
}
\details{
%%  ~~ If necessary, more details than the description above ~~
}
\value{
%%  ~Describe the value returned
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...

}
\references{
%% ~put references to the literature/web site here ~
https://azure.microsoft.com/en-us/services/cognitive-services/text-analytics/
}
\author{
%%  ~~who you are~~
Swapil
}
\note{
%%  ~~further notes~~
}

%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
%% ~~objects to See Also as \code{\link{help}}, ~~~
}
\examples{
##---- Should be DIRECTLY executable !! ----
##-- ==>  Define data, use random,
##--	or do  help(data=index)  for the standard data sets.
\donttest{

textAnalysisFunction('test.csv', 1:10, '973072df15b34e1c963c514a0dd5a885')
}

## The function is currently defined as
function (filename, IDs, key)
{
    data.i = read.csv(filename, stringsAsFactors = FALSE)
    data.i = data.i[IDs, ]
    data_for_api <- data.i[, 1:3]
    data_table <- data.frame(Id = integer(), Text = character(),
        Score = double(), length = integer(), type = character(),
        status.code = integer(), error.message = character(),
        url = character(), stringsAsFactors = FALSE)
    for (i in 1:length(data_for_api[, 1])) {
        data <- data_for_api[i, ]
        p = toJSON(list(documents = data), auto_unbox = TRUE)
        r <- POST("https://westcentralus.api.cognitive.microsoft.com/text/analytics/v2.1/sentiment?showStats=1",
            body = p, add_headers(.headers = c(`Content-Type` = "application/json",
                `Ocp-Apim-Subscription-Key` = key)))
        if (r$status_code == 200 && length(content(r)$documents) >
            0) {
            id = data$Id
            tryCatch(expr = {
                score <- as.numeric(content(r)$documents[[1]]$score)
            }, error = function(e) {
                score <- NA
            })
            error.code = 200
            error.message = NA
            url = r$url
        }
        else {
            id = data$Id
            score = NA
            error.code = r$status_code
            if (is.null(content(r)$error)) {
                error.message = content(r)$message
                url = r$url
            }
            else if (length(content(r)$documents) == 0 && length(content(r)$errors) >
                0) {
                error.message = content(r)$errors[[1]]$message
                url = r$url
            }
            else {
                error.message = content(r)$error$message
                url = r$url
            }
        }
        data_table[nrow(data_table) + 1, ] = c(id, data$text,
            score, as.numeric(data.i[i, ]$length_processed_text),
            data.i[i, ]$type, error.code, error.message, url)
        if (i > 1 && i\%\%30 == 0 && test == 0) {
            Sys.sleep(61)
        }
    }
    data_table$Score = as.numeric(data_table$Score)
    data_table$length = as.numeric(data_table$length)
    data_table$type = as.factor(data_table$type)
    return(data_table)
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
