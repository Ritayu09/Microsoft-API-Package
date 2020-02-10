\name{plotStatusFunction}
\alias{plotStatusFunction}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
%%  ~~function to do ... ~~
plotting function for obtaining bar plots of status from api calls.
}
\description{
%%  ~~ A concise (1-5 lines) description of what the function does. ~~
This function allows users to visually explore the data returned by the text analysis function. The typical input is the dataframe object returned by textAnalysisFunction but any dataframe with columns of status.code will work. It will return an error if these columns are not available.
(Currenty this function is very restrictive but should work with data if they are in format like 'test.csv')
}
\usage{
plotStatusFunction(data)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{data}{
%%     ~~Describe \code{data} here~~
dataframe  object like one obtained as an output from textAnalysisFunction. It should have a column named status.code with numeric status codes to work correctly
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
plotStatusFunction(data)
}


## The function is currently defined as
function (data)
{
    u = table(data$status.code)
    return(barplot(u, main = "Barchart for Status Codes", col = "green"))
  }
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ ~kwd1 }% use one of  RShowDoc("KEYWORDS")
\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
