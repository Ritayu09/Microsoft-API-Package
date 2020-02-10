\name{plotFunction}
\alias{plotFunction}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
plotting function for obtaining pair plots if users provide text, length of text and type of review.

}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
this function allows users to visually explore the data returned by the text analysis function. The typical input is the dataframe object returned by textAnalysisFunction but any dataframe with columns of type, text and length should work. It will return an error if these columns are not available.
(Currenty this function is very restrictive but should work with data if they are in format like 'test.csv')
}
\usage{
plotFunction(data)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
%%     ~~Describe \code{data} here~~
data is a dataframe like one obtatined as output from textAnalysisFunction. This dataframe should have  atleast three columns namely 'text', 'length', and 'score' to work correctly. please see 'test.csv' which has the correct labels that should be used here.
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

data = textAnalysisFunction('test.csv', 1:10, '973072df15b34e1c963c514a0dd5a885')
plotFunction(data)
}


## The function is currently defined as
function (data)
{
    cols <- colnames(data)
    if ("Score" \%in\% cols && "length" \%in\% cols && "type" \%in\%
        cols && length(data[, 1] > 0)) {
        u = data.frame(data$Score, data$length, data$type)
        return(pairs(u))
    }
    else {
        throw("The dataframe doesn't consist of one or more of these columns (Score, length, type)")
    }
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
