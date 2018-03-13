setwd(normalizePath(dirname(R.utils::commandArgs(asValues=TRUE)$"f")))
source("../../scripts/h2o-r-test-setup.R")
##
# PUBDEV-5266
# Test out the merge() functionality with String columns in both left and right frames
# Test out the sort() functionality with String columns in the frame
##

test.merge <- function() {
  browser()
  runtest = sample(c(T,T))  # to save test time, only do one of the following tests
  cnames <- c("int1","stringf1","stringf1.2","intf1.2","stringf2","stringf2.2","stringf2.3","intf2.5",
  "intf2.3","intf2.4","stringf2.4")

  if (runtest[1]) { # test merge
    f1 <- h2o.importFile(locate("bigdata/laptop/jira/PUBDEV_5266_merge_with_string_columns/PUBDEV_5266_f1.csv")) # c1:int, c2:real, c3:string, c4:enum
    f1names <- c("int1", "stringf1", "stringf1-2", "intf1-2")
    colnames(f1) <- f1names
    f2 <- h2o.importFile(locate("bigdata/laptop/jira/PUBDEV_5266_merge_with_string_columns/PUBDEV_5266_f2.csv")) # c1:real, c2:int, c3:string, c4/c5:enum, c6/c7:string, c8:int
    f2names <- c("int1", "stringf2", "stringf2-2", "stringf2-3", "intf2-5", "intf2-3", "intf2-4", "stringf2-4")
    colnames(f2) <- f2names
    fmergedXans <- h2o.importFile(locate("bigdata/laptop/jira/PUBDEV_5266_merge_with_string_columns/mergedf1_f2_R_y_T.csv"))
    h2omerge <- h2o.merge(f1, f2, all.x = FALSE, all.y = TRUE)  # perform merge by h2o
    all.equal(as.data.frame(fmergedXans), as.data.frame(h2omerge))
  } else {  # test sorting
    f2 <- h2o.importFile(locate("bigdata/laptop/jira/PUBDEV_5266_merge_with_string_columns/PUBDEV_5266_f2.csv")) # c1:real, c2:int, c3:string, c4/c5:enum, c6/c7:string, c8:int
    fsortedf2ans <- h2o.importFile(locate("bigdata/laptop/jira/PUBDEV_5266_merge_with_string_columns/sortedF2_R_C1_C7_C5.csv"))
    h2osort <- h2o.arrange(f2, C1, C7, C5)
    all.equal(as.data.frame(fsortedf2ans), as.data.frame(fsortedf2ans))
  }
}

doTest("Test out the merge() functionality", test.merge)
