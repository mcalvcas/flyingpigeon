#Computing weather regimes in a dataset (here NCEP) projecting NCEP-EOFs during a reference period (1970-2010) 
#by Pascal Yiou & Carmen Alvarez-Castro
rm(list=ls())
ptm <- proc.time()# starting time script
#library(mclust)
library(ncdf4)
library(maps)
NCEPdir="/home/estimr2/calvarez/birdhouse/libraryregimes.R"
Results=NCEPdir
source(paste(NCEPdir,"libraryregimes.R",sep=""))
varname="slp"
modelname="NCEP"
yr1=1948
yr2=2014
seas="JJA"

## load weather regimes calculated in a reference period (1970-2010)
y1=1970
y2=2010
fname=paste(NCEPdir,"NCEP_regimes_",y1,"-",y2,"_",seas,".Rdat",sep="")
print(paste("Reading",fname,"for reference WR"))
load(fname)

## load EOFs for the reference period (NCEP 1970-2010)
fname=paste(NCEPdir,varname,"_EOF_",seas,"_clim.dat",sep="")
print(paste("Reading",fname,"for EOFs"))
EOF.r=read.table(file=fname)
n.eof=ncol(EOF.r)


#open netcdf4
fname = paste(NCEPdir,"slp.",yr1,"-",yr2,"_NA.nc",sep="")
nc = nc_open(fname)
datNCEP=lirevarnc(nc,varname)
dat.NCEP.dum=sousseasmean(datNCEP$dat,datNCEP$conv.time,l.year=c(1970:1999))
datNCEP$anom=dat.NCEP.dum$anom
datNCEP$seascyc=dat.NCEP.dum$seascyc
conv.time=datNCEP$conv.time
nc_close(nc)

#Define months and seasons
#seas=JJA
l.seas=list(JJA=6:8,SON=9:11,DJF=c(12,1,2),SONDJF=c(9:12,1,2),MAM=c(3,4,5),all=c(1:12),
            JJAS=6:9,DJFM=c(1:3,12),MAMJ=3:6,FMA=c(2,3,4),DJFM=c(12,1,2,3),MAMJ=c(3:6),JJAS=c(6:9),SOND=c(9:12))
ISEAS=which(datNCEP$conv.time$month %in% l.seas[[seas]])
dat.m=datNCEP$anom[ISEAS,]
print(paste("Classification for",seas))

## SLP Climatology and ponderation by latitude
dat.climatol=apply(datNCEP$dat[ISEAS,]/100,2,mean,na.rm=TRUE)
mean.clim=mean(dat.climatol)
#correction:removing spatial average. To be used with models or different datasets
#mean.clim.ref=1013.96389304258  #NCEP(1970-2010)
# dif.mean=mean.clim.ref-mean.clim
# dat.m=dat.m+dif.mean


## Calculate projections for EOFs(PC empirics)
## Normalization by latitude
lon=datNCEP$lon
lat=datNCEP$lat
pond.slp=1/sqrt(cos(lat*pi/180))
scale.slp=rep(pond.slp,length(lon))
dat.scale=scale(dat.m,scale=scale.slp)
## Projection of EOFs (1970-2010)
PC.e = dat.scale %*% as.matrix(EOF.r)

# compute distance, correlation and best WR
rms.reg=c()
cor.reg=c()
for(i in 1:nreg){
  diffi=t(t(PC.e) - dat.class$kmeans$centers[i,])
    diffi=diffi^2
    rms=apply(diffi,1,sum,na.rm=TRUE)
    dum=cor(t(dat.m),dat.class$reg.var[,i])
    rms.reg=cbind(rms.reg,rms)
    cor.reg=cbind(cor.reg,dum)
}
best.reg=apply(rms.reg,1,which.min)
dist.reg=sqrt(apply(rms.reg,1,min)/nrow(datNCEP$anom))

## Save classification in Results
timeout=datNCEP$time[ISEAS]
varout=cbind(timeout,best.reg,dist.reg,cor.reg)
fname=paste(Results,"NCEP_SLP_",seas,"_",yr1,"-",yr2,"_classif.dat",sep="")
header=c("Time","Best.reg","rms","Cor1","Cor2","Cor3","Cor4")
write.table(file=fname,varout,quote=FALSE,row.names=FALSE,col.names=header)

#Frequencies of Weather regimes for each "seas"
R=read.table(fname,header=TRUE)
yyyy=floor(R$Time/10000)
mm=floor(R$Time/100) %% 100
yyyy[mm==12]=yyyy[mm==12]+1
uyyyy=sort(unique(yyyy))
yyyymm=yyyy*100+mm
dum=rep(1,length=length(yyyymm))
reg.freq=c()
for(i in 1:nreg){
  tdum=tapply(dum[R$Best.reg==i],yyyy[R$Best.reg==i],length)
  ldum=tapply(dum,yyyy,length)
  rdum=rep(0,length=length(uyyyy))
  rdum[uyyyy %in% as.numeric(names(tdum))]=tdum
  rdum=rdum/ldum
  reg.freq=cbind(reg.freq,rdum)
}
WR.freq <- as.data.frame(reg.freq*100)
WR.freq$year <- uyyyy
#imposing names. Attention!! check names!
name.reg=c("NAO-","AL","BLO","AR")
#name.reg=c("Reg.1","Reg.2","Reg.3","Reg.4")
names(WR.freq) <- c(name.reg,"year")

## Save frequencies of Weather Regimes per seas in Results
fname=paste(Results,"frec_percent_WR_",modelname,"_SLP_",seas,"_",yr1,"-",yr2,".dat",sep="")
write.table(file=fname,WR.freq,quote=FALSE,row.names=FALSE)

## Plotting Weather regimes
fname=paste(Results,"projNCEP_regimes_",yr1,"-",yr2,"_",seas,".pdf",sep="")
pdf(file=fname)
layout(matrix(1:(2*ceiling(nreg/2)),2,ceiling(nreg/2)))
par(mar=c(4,6,2,2))
for(i in 1:nreg){ 
  image.cont.mc(lon,lat,dat.class$reg.var[,i]/100,
                xlab="",ylab="",mar=c(2.5,2,2,1),paquet="maps",
                titre=paste(modelname,"(",y1,"-",y2,")",name.reg[i],"(",
                            format(dat.class$perc.r[i],digits=3),"%)"))
}#end for i
dev.off()
proc.time() - ptm #ending time script
#end
