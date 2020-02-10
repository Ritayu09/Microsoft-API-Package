#' Title
#'
#' @param data this is the dataframe conatining status codes from the api calls.
#'
#' @return
#' @export
#'
#' @examples
#' This function returns a barplot showing the distribution of various status codes in dataframe.
#' This is helpful in getting an estimate of how many calls were successful and how many failed.
#'
plotStatusFunction <- function(data) {
  cols = colnames(data)
  if ("status.code" %in% cols  && length(data[,1] > 0)){
  u = table(data$status.code)
  return(barplot(u,
       main="Barchart for Status Codes",
       col="green"))
  } else {
    throw("The dataframe doesn't consist of columns (status.code)")
  }
}
