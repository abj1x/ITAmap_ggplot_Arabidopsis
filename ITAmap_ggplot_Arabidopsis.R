## after https://www.rpubs.com/spoonerf/countrymapggplot2

library(maptools)
library(raster)
library(ggplot2)
library(rgdal)
library(plyr)

## download Italy shapefile data

italy<-getData("GADM",country="IT",level=0)

## make base map

ity<-ggplot()+geom_polygon(data=italy,aes(x=long,y=lat,group=group))+coord_fixed(1.3)

## input of dataset with Arabidopsis 1001 genome accession details

ecotypes_all<-read.csv('LHY_SNP_WRLD_dataset.csv', header=TRUE)

## obtaining the ITA specific accessions from dataset

ITAdata<-ecotypes_all[which(ecotypes_all$country.x=="ITA"),]

## cast ecotype locations as lat long coordinates on base map

ity+theme_dark() +
  geom_point(data=ITAdata,aes(x=long,y=lat,color=factor(genotype_comp)),size=1.0) +
  labs(x="longitude", y="latitude",col="haplotype") +
  scale_color_manual(values=c("dodgerblue1","chartreuse2","firebrick1","lightgoldenrod2")) +
  theme(legend.background = element_rect(fill="gray 90"),legend.title=element_blank()) +
  theme(legend.justification = c(0,0),legend.position = c(0,0)) +
  theme(legend.background = element_rect(colour="black",size=0.25))

ggsave('Italy_map_LHY_haplotype.png')
