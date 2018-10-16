extraire <- function(entree,motif){
	res <- regexec(motif,entree)
	if(length(res[[1]])==2){
		debut <- (res[[1]])[2]
		fin <- debut+(attr(res[[1]],"match.length"))[2]-1
		return(substr(entree,debut,fin))
	}else return(NA)}