Connec = function(dd)
{
   dd = data.frame(dd)
   dd$marker = rep(1, nrow(dd))
   Co = c()
   # Time series
   t_start = min(dd$time)
   t_stop = max(dd$time)
   TimeSeq = seq(from=t_start, to=t_stop+1, length=80)
   for(i in c(2:length(TimeSeq)))
   {
      ddSub = subset(dd, (dd$time >= TimeSeq[(i-1)])&(dd$time < TimeSeq[i]))
      network = xtabs(marker~pred+prey, ddSub)
      network[network>0] = 1
      Co[(i-1)] = sum(network)/prod(dim(network))
   }
   # Number of interactions
   return(Co)
}

colNames = c('name', 'niche', 'time', 'pred', 'prey', 'pop.pred', 'pop.prey', 'n.pred', 'n.prey', 'k.pred', 'k.prey')

plot(0, xlim=c(0,80), ylim=c(0.0, 0.3))

Sim = c('control','destr','small')
for(s in c(1:length(Sim)))
{
   Cond = Sim[s]
   CondFiles = list.files(path='output',pattern=Cond)
   for(f in CondFiles)
   {
      f = paste('output/',f,sep='')
      d = read.table(f)
      colnames(d) = colNames
      lines(Connec(d),col=s)
   }
}

