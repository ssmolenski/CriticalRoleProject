unshorten <- function(url){
	uri <- getURL(url, header=TRUE, nobody=TRUE, followlocation=FALSE, 
       cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl"))
	res <- try(extraire(uri,"\r\nlocation: (.*?)\r\nserver"))
	return(res)}