library(testthat)
library(jsonlite)
library(httr)

# correct data format for csv file
filename.1 = 'test.csv'
data.1 = read.csv(filename.1)
num.1 = length(data.1[,1])
num.eng.1 = length(subset(data.1, language == "en")[,1])
final.output.1 = read.csv('test_out.csv')
IDs.1 = 1:num.1


# Incorrect data in csv files should throw a few errors in error.message
filename.2 = 'testIncorrect.csv'
data.2 = read.csv(filename.2)
num.2 = length(data.2[,1])
num.eng.2 = length(subset(data.2, language == "en")[,1])
final.output.2 = read.csv('test_out_incorrect.csv')
IDs.2 = 1:num.2


# correct Key should not throw error
key.1 = '973072df15b34e1c963c514a0dd5a885'

# Incorrect Key should throw error
key.2 = '55f27237f0eb405da8aaafdac3d29'

# testing textAnalysisFunction function
test_that("sentiment score from text", {

  # Using correct data and key so expect output to match the one already stored in test_out.csv File
  data.1.out <- textAnalysisFunction(filename.1, IDs.1,key.1)
  write.csv(data.1.out, 'new_test_out.csv',  row.names = FALSE)
  new.out.1 <- read.csv('new_test_out.csv')

  # we are comparing dataframes obtanied from csv to ensure that similar datatypes are used.
  expect_equal(new.out.1, final.output.1)


  # for incorrect keys all 5 rows should have an error message related to token missing
  data.1a.out <- textAnalysisFunction(filename.1, IDs.1,key.2)
  l1 <- length(subset(data.1a.out, (data.1a.out$error.message == "Unauthorized. Access token is missing, invalid, audience is incorrect (https://cognitiveservices.azure.com), or have expired."))$Id)
  expect_equal(l1,5)

  # this is to avoid sending too many requests. Limit is 30 per minute.
  Sys.sleep(61)

  # this file test_out_incorrect.csv has some data for cases where incorrect language is present. this is being matched with fresh call to make
  # sure all other rows are showing up properly as they were in past.
  data.2.out <- textAnalysisFunction(filename.2, IDs.2,key.1)
  write.csv(data.2.out, 'new_test_out_incorrect.csv',  row.names = FALSE)
  new.out.2 <- read.csv('new_test_out_incorrect.csv')
  expect_equal(new.out.2, final.output.2)

  # use of incorrect key and some incorrect data in language column. expect all 6 rows to show same invalid token message.
  data.2a.out <- textAnalysisFunction(filename.2, IDs.2,key.2)
  l2 <- length(subset(data.1a.out, (data.2a.out$error.message == "Unauthorized. Access token is missing, invalid, audience is incorrect (https://cognitiveservices.azure.com), or have expired."))$Id)
  expect_equal(l2,6)

  # in incorrect languages we have 2 rows out of 6 where language related error must me shown.
  expect_equal(length(subset(data.2.out, (!is.na(data.2.out$error.message)))$Id), 2)
})


# testing plotting error charts function
test_that("test plotting functions for status code", {

  # this is some data collected in past for 3 status codes
  dat <- read.csv('test_out_incorrect_final.csv')
  p <- plotStatusFunction(dat)
  # expecting 3 bars in bar plot for 3 status codes
  expect_equal(3, attributes(p)$dim[1])

  # this is some data collected in past for 3 status codes
  dat.2 <- read.csv('test_out_incorrect_final_2.csv')
  p.2 <- plotStatusFunction(dat.2)
  # expecting 2 bars in bar plot for 2 status codes
  expect_equal(2, attributes(p.2)$dim[1])

  # this is some data collected in past for 3 status codes
  dat.1 <- read.csv('test_out_incorrect_final_1.csv')
  p.1 <- plotStatusFunction(dat.1)
  # expecting 1 bar in bar plot for 1 status code
  expect_equal(1, attributes(p.1)$dim[1])

  # this file doesnt have status.code so it should throw error
  dat.4 <-  read.csv('test_out_incorrect_final_3.csv')
  expect_error(plotStatusFunction(dat.4))
})


# testing plotting error charts function
test_that("test plotting functions for pairs plot on for review type, sentiments and length of text", {

  # this is some data collected in past for 3 status codes and has all required columns
  dat <- read.csv('test_out_incorrect_final.csv')
  expect_silent(plotFunction(dat))

  # this is some fake data that doesnt have all required columns for pairs plot
  dat.2 <- read.csv('test_out_incorrect_final_3.csv')
  expect_error(plotFunction(dat.2))


})
