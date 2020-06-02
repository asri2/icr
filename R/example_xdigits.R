data(tli)
tli.table <- xtable(tli[1:10, ])
display(tli.table)[c(2,6)] <- "f"
digits(tli.table) <- 1
tli.table
