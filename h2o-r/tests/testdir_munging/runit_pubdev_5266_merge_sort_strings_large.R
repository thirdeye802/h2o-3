setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../scripts/h2o-r-test-setup.R")
##
# PUBDEV-5266
# Test out the merge() functionality with String columns in both left and right frames
# Test out the sort() functionality with String columns in the frame
##

test.merge <- function() {
  browser()
  runtest = sample(c(T,F))
  
  if (runtest[1]) {
  f1 <- h2o.importFile(locate("bigdata/laptop/jira/PUBDEV_5266_merge_with_string_columns/PUBDEV_5266_f1.csv")) # c1:int, c2:real, c3:string, c4:enum
  f1names <- c("int", "realf1", "stringf1", "enum")
  colnames(f1) <- f1names
  f2 <- h2o.importFile(locate("bigdata/laptop/jira/PUBDEV_5266_merge_with_string_columns/PUBDEV_5266_f2.csv")) # c1:real, c2:int, c3:string, c4/c5:enum, c6/c7:string, c8:int
  f2names <- c("realf2", "int", "stringf21", "enum", "enumf2", "stringf22", "stringf23", "intf2")
  colnames(f2) <- f2names
  fmergedXans <- h2o.importFile(locate("bigdata/laptop/jira/PUBDEV_5266_merge_with_string_columns/mergedf1_f2_R_y_T.csv"))
  h2omerge <- h2o.merge(f1, f2, all.x = TRUE, all.y = FALSE)  # perform merge by h2o
  all.equal(as.data.frame(fmergedXans), as.data.frame(h2omerge))
  } else {
  f2 <- h2o.importFile(locate("bigdata/laptop/jira/PUBDEV_5266_merge_with_string_columns/PUBDEV_5266_f2.csv")) # c1:real, c2:int, c3:string, c4/c5:enum, c6/c7:string, c8:int
  fsortedf2ans <- h2o.importFile(locate("bigdata/laptop/jira/PUBDEV_5266_merge_with_string_columns/sortedf2_R_C2_C4.csv"))
  h2osort <- h2o.arrange(f2, C2, C4)
  all.equal(as.data.frame(fsortedf2ans), as.data.frame(fsortedf2ans))
  }
}

doTest("Test out the merge() functionality", test.merge)
