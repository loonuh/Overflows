#you will need to install.package(<package>)
#'R.matlab'
#'ggplot2'
#'reshape'
#'grid'

#you will need to create an alias=Rscript <path to this script>/plotDens.r
#you can then use that alias like this:
#alias <only name of .mat file excluding .mat part> <name you want for pdf file excluding .pdf> <args>
#For example, if I named my alias rplot2D, and I was in a directory with the file mu.mat.
#I could execute the following at the commmand line:
#rplot2D mu muplot 'Degree (k)' 'Rewiring coefficient (w)' 'Degree Density u(k,w)';evince muplot.pdf

#You will need these libraries
library(R.matlab);
library(ggplot2);
library(reshape);
library(grid);

#This is used for entrepreting your inputs from the command line
args <- commandArgs(TRUE)

nameIn = paste(args[1],'.mat',sep='') #1st arugment 
nameOut = paste(args[2],'.pdf',sep='') #2nd argument
nameX = toString(args[3])	       #3rd argument is x-axis title
nameY = toString(args[4])	       #4th argument is y-axis title
nameTitle = toString(args[5]) 	       #5th argument is plot title

filenameread = toString(nameIn)
data <- readMat(filenameread)

evalStr = paste('data$',args[1],sep='')

M = eval(parse(text=evalStr))
Melt <- melt(M)

p <- ggplot(Melt, aes(X1, X2, fill = value)) + geom_tile()
q <- p + theme(plot.background = element_blank(),
panel.grid.major = element_blank(),
panel.grid.minor = element_blank(),
panel.background = element_blank()
)

xstep = 2  #You'll have to edit this for your problem
ystep = .025*2 #You'll have to edit this for your problem 

xlabels <- as.character(seq(0,20,by=xstep))
ylabels <- as.character(seq(0,1,by=ystep))

pdf(toString(nameOut))
q <- q + coord_fixed(ratio = dim(M)[1]/dim(M)[2]) #Makes plot ~square
#q <- q + scale_fill_continuous(low = "white",high="green4")  #Pick your poison
#q <- q + scale_fill_continuous(fill=rainbow(10))	      #Pick your poison
q<-q + scale_fill_gradientn(colours = rev(rainbow(50)))	      #Pick your poison

q <- q + guides(fill = guide_colorbar(title=NULL,barwidth = 0.5, barheight = 25,color="black"))
#q <- q + guides(fill = guide_colorbar(barwidth = 0.5, barheight = 21,color="black"))

q <- q + scale_x_continuous(nameX,breaks=seq(1,21,by=2),labels=xlabels) + #You'll have to edit this for your problem
       	 scale_y_continuous(nameY,breaks=seq(1,41,by=2),labels=ylabels) + #You'll have to edit this for your problem
	 theme(axis.ticks.length=unit(0,"cm"),  axis.ticks.margin=unit(-.5,"cm"), 
	 axis.title.x = element_text(vjust = -.5),
	 axis.title.y = element_text(vjust = 1.5),
	 plot.title = element_text(vjust = -1.25))

q + geom_tile(colour = "black") + ggtitle(nameTitle)
dev.off()


