#prepare
testbed<-rep(0,length(file$TI))
innovation<-rep(0,length(file$TI))
pilotplant<-rep(0,length(file$TI))
livinglab<-rep(0,length(file$TI))
scaleup<-rep(0,length(file$TI))
demonstrate<-rep(0,length(file$TI))
creation<-rep(0,length(file$TI))
testbench<-rep(0,length(file$TI))
falsepos<-rep(0,length(file$TI))

#turn text to lower case
file$TI<-tolower(file$TI) #title
file$DE<-tolower(file$DE) 
file$AB<-tolower(file$AB) #abstract
file$CR<-tolower(file$CR) 
file$WC<-tolower(file$WC)  
file$SC<-tolower(file$SC)
#true word
tomatch<-c("testbed","test bed","test-bed")
tomatch<-c("living lab","living-lab")
tomatch<-c("innovation environment","innovation hub","innovation facility","innovation facilities","innovation space","innovation lab","innovation center","innovation centre","innovation-lab","cooperation lab")
tomatch<-c("creation environment","creation hub","creation facility","creation facilities","creation space","creation lab","creation center","creation centre")
#tomatch<-c("co-creat","cocreat","co creat","co-produc")
tomatch<-c("scaleup center","scaleup centre","scaleup environment","scaleup space","scaleup hub","scaleup lab","scaleup facility","scaleup facilities")
tomatch<-c("scale up center","scale up centre","scale up environment","scale up space","scale up hub","scale up lab","scale up facility","scale up facilities")
tomatch<-c("scale-up center","scale-up centre","scale-up environment","scale-up space","scale-up hub","scale-up lab","scale-up facility","scale-up facilities")
tomatch<-c("pilot plant","pilot facility","pilot facilities","pilot facilit","pilot space","pilot line","pilot environment","pilot lab")
tomatch<-c("pilot-plant","pilotplant")
tomatch<-c("pilot-scale plant","pilot scale plant","demonstration-scale plant","demonstration scale plant")
tomatch<-c("prototype plant","prototyping plant","prototype platform","prototyping platform")
tomatch<-c("demonstration plant")
tomatch<-c("demonstration environment","demonstrate environment","demonstration center","demonstration centre","demonstration facility","demonstration facilities","demonstrate facility","demonstrate facilities")
#matchword: to locate words in the text
matches <- unique (grep(paste(tomatch,collapse="|"), 
                        file$TI, value=FALSE))
matches <- unique (grep(paste(tomatch,collapse="|"), 
                        file$DE, value=FALSE))
matches <- unique (grep(paste(tomatch,collapse="|"), 
                        file$ID, value=FALSE))
matches <- unique (grep(paste(tomatch,collapse="|"), 
                        file$AB, value=FALSE))

#allocate
for (i in 1:length(matches))
{
  demonstrate[matches[i]]=1
}
for (i in 1:length(matches))
{
  testbed[matches[i]]=1
}
for (i in 1:length(matches))
{
  livinglab[matches[i]]=1
}
for (i in 1:length(matches))
{
  scaleup[matches[i]]=1
}
for (i in 1:length(matches))
{
  innovation[matches[i]]=1
}
for (i in 1:length(matches))
{
  creation[matches[i]]=1
}
for (i in 1:length(matches))
{
  pilotplant[matches[i]]=1
}

#false positive word
tomatch<-c("living labour","living labor","live labour","live labor","living-labor","living-labour")
tomatch<-c("innovation labour","innovation labor","innovation-labour","innovation-labor")
tomatch<-c("scaleup environmental","scale-up environmental","scale up environmental")
tomatch<-c("scaleup facilitate","scale up facilitate","scale-up facilitate")
tomatch<-c("pilot demonstrate","pilots demonstrate","pilot demonstrates","pilot demonstrates")
tomatch<-c("demonstrate environmental","demonstrates environmental","demonstrate facilitat","demonstrates facilitat")
#!!!rematch
matches2 <- unique (grep(paste(tomatch,collapse="|"), 
                         file$TI, value=FALSE))

#re-allocate
for (i in 1:length(matches2))
{
  livinglab[matches2[i]]=0
}
for (i in 1:length(matches2))
{
  innovation[matches2[i]]=0
}
for (i in 1:length(matches2))
{
  pilotplant[matches2[i]]=0
}
for (i in 1:length(matches2))
{
  demonstrate[matches2[i]]=0
}



#but true word
tomatch_true<-c("living laborator","living-laborator")
tomatch_true<-c("innovation laborator","innovation-laborator")

#rematch
matches3 <- unique (grep(paste(tomatch_true,collapse="|"), 
                         file$TI, value=FALSE))
#re-allocate
for (i in 1:length(matches3))
{
  livinglab[matches3[i]]=1
}
for (i in 1:length(matches3))
{
  innovation[matches3[i]]=1
}
for (i in 1:length(diff))
{
  falsepos[diff[i]]=1
}

#combine and write to new file
file2<-cbind(file2,testbed,livinglab,innovation,creation,pilotplant,demonstrate)
write.table(file2,file="table",sep="\t")

matches3 <- length (grep(paste(tomatch,collapse="|"), 
                         file3$AB[90], value=FALSE))

for (i in 1:length(file3$AB))
{
  count[i]<-sum(str_count(file3$AB[i],tomatch))
}

for (i in 1:length(matches))
{
  print(file3$ID[matches[i]])
}



