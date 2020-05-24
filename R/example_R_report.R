forecast.matches0.displayx <- xtable(forecast.matches0.display,digits = c(0,0,0,2,2,1,1,0,0,1,1,1,1,1,1,1,1,1,1,1))
#names(forecast.matches0.displayx) <- c("","","EG1","EG2","pH","pA","ML","CML","p2-0","p2-1","p1-0","p0-0","p1-1","p2-2","p0-1","p1-2","p0-2")
align(forecast.matches0.displayx) <- "lll|rr|rr|rr|rrr|rrr|rrr|rr"
addtorow <- list()
addtorow$pos <- list(0, 0)
addtorow$command <- c("& & \\multicolumn{2}{|c}{Expected Goals}& \\multicolumn{2}{|c}{Outcome Probs} & \\multicolumn{2}{|c}{Score Picks} & \\multicolumn{3}{|c}{Home wins} & \\multicolumn{3}{|c}{Draws} & \\multicolumn{3}{|c}{Away wins} & \\multicolumn{2}{|c}{Mean Odds} \\\\\n",
                      paste0("\\multicolumn{2}{l|}{",wanteddiv_id[1],"} & Home & Away & Home & Away & Most & Cond & 2-0 & 2-1 & 1-0 & 0-0 & 1-1 & 2-2 & 0-1 & 1-2 & 0-2 & Home & Away \\\\\n"))
print(xtable(forecast.matches0.displayx), add.to.row = addtorow, include.colnames = FALSE)
print(forecast.matches0.displayx, add.to.row = addtorow, include.colnames = FALSE, type = "latex", 
      floating = FALSE,
      include.rownames=FALSE, file=paste0(dbloc,"/data/",wanteddiv_id[2],"/",wanteddiv_id[2],"-2020-",date0,".tex"))

if(closed.door==FALSE) {
  fileConn<-file(paste0(dbloc,"/data/",wanteddiv_id[2],"/",wanteddiv_id[2],"-2020-",date0,"-comp.tex"))
} else {
  fileConn<-file(paste0(dbloc,"/data/",wanteddiv_id[2],"/",wanteddiv_id[2],"-2020-",date0,"-comp-closed-door.tex"))
}
writeLines(c("\\documentclass{standalone}","\\begin{document}",paste0("\\input{",dbloc,"/data/",wanteddiv_id[2],"/",wanteddiv_id[2],"-2020-",date0,".tex}"),"\\end{document}"), fileConn)
close(fileConn)

if(closed.door==FALSE) {
  cmds <- c(paste0("cd ",dbloc,"/data/",wanteddiv_id[2],"/"), 
            paste0("pdflatex ",wanteddiv_id[2],"-2020-",date0,"-comp.tex"), 
            paste0("convert -density 300 ",wanteddiv_id[2],"-2020-",date0,"-comp.pdf ",wanteddiv_id[2],"-2020-",date0,"-comp.jpg"));
} else {
  cmds <- c(paste0("cd ",dbloc,"/data/",wanteddiv_id[2],"/"), 
            paste0("pdflatex ",wanteddiv_id[2],"-2020-",date0,"-comp-closed-door.tex"), 
            paste0("convert -density 300 ",wanteddiv_id[2],"-2020-",date0,"-comp-closed-door.pdf ",wanteddiv_id[2],"-2020-",date0,"-comp-closed-door.jpg"));
}
system(paste(cmds, collapse=";"))