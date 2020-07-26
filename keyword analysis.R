tomatch<-c("testbed","test bed","test-bed")
tomatch<-c("living lab","living-lab")
tomatch<-c("innovation environment")
tomatch<-c("innovation hub")
tomatch<-c("innovation lab")
tomatch<-c("pilot plant")
tomatch<-c("pilot facility","pilot facilities","pilotfacilit")
tomatch<-c("pilot line")
tomatch<-c("scaleup environment","scale up environment","scale-up environment")
tomatch<-c("demonstration plant")
tomatch<-c("demonstration center","demonstration centre")
tomatch<-c("test bench","testbench")
tomatch<-c("pilot and demonstration plant")
tomatch<-c("pilot scale plant","pilot-scale plant")

matches <- unique (grep(paste(tomatch,collapse="|"), 
                        file$TI, value=FALSE))


testbed<-rep(0,length(file$TI))
innovation_lab<-rep(0,length(file$TI))
innovation_hub<-rep(0,length(file$TI))
innovation_environment<-rep(0,length(file$TI))
pilotplant<-rep(0,length(file$TI))
pilot_facility<-rep(0,length(file$TI))
pilot_line<-rep(0,length(file$TI))
pdp<-rep(0,length(file$TI))
pilotscale_plant<-rep(0,length(file$TI))
livinglab<-rep(0,length(file$TI))
scaleup_environment<-rep(0,length(file$TI))
demonstration_center<-rep(0,length(file$TI))
demonstration_plant<-rep(0,length(file$TI))
creation<-rep(0,length(file$TI))
testbench<-rep(0,length(file$TI))

file2<-cbind(file2,testbed,livinglab,innovation_lab,innovation_hub,innovation_environment,pilotplant,pilot_facility,pilot_line,pilotscale_plant,scaleup_environment,demonstration_center,demonstration_plant,pdp,testbench,creation)
write.table(file2,file="table2",sep="\t")



barplot(count, main="keyword count", horiz=TRUE,
        names.arg=c("Testbed", "Pilot plant", "Living lab","Test bench"))
