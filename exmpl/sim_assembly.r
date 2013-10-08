# Output folder, files prefix
prefix = 'assembly'
of = '../output/'
files = list.files(path=of, pattern=prefix)

# Required libraries
library(rjson)
library(ggplot2)

timeSeries = function(rec)
{
   series = NULL
   Times = as.numeric(names(rec$times))
   tSeq = seq(from=min(Times), to=max(Times)+1, by=50)
   for(i in c(2:length(tSeq)))
   {
      sTime = as.character(c(tSeq[i-1]:(tSeq[i]-1)))
      subRec = rec$times[names(rec$times)%in%sTime]
      subRec$times = subRec
      mTime = mean(as.numeric(sTime))
      cLine = c(time=mTime, unlist(singleOutput(subRec)))
      series = rbind(series, cLine)
   }
   return(series)
}

# Function to analyze a timesteps pool
singleOutput = function(rec)
{
   # We get the list of all species
   speciesPool = lapply(rec$times, function(x) names(x$pop))
   uniqueSpecies = unique(unlist(speciesPool))
   # We then measure the average number of species
   averageRichness = mean(unlist(lapply(speciesPool, length)))
   # Let's build a food web
   FW = matrix(0, ncol=length(uniqueSpecies), nrow=length(uniqueSpecies))
   colnames(FW) = rownames(FW) = uniqueSpecies
   for(ti in rec$times)
   {
      for(int in ti$int)
      {
         FW[as.character(int$pred), as.character(int$prey)] = FW[as.character(int$pred), as.character(int$prey)] + 1
      }
   }
   # Get the adjacency matrix
   ADJ = FW
   ADJ[ADJ>0] = 1
   L = sum(ADJ)
   # Return some elements
   return(list(S=averageRichness, L=L, Co=L/averageRichness^2))
}

# Read all the files
assembl = NULL
for(f in files)
{
   # Full file path
   f_path = paste(of,f,sep='')
   # Read the JSON object
   rec = fromJSON(file=f_path)
   # Analyse the simulation
   metrics = timeSeries(rec)
   # Get simulation parameters
   f_split = unlist(strsplit(unlist(strsplit(f,'\\.'))[1],'-'))
   s_n = as.numeric(f_split[2]) # Neutral ?
   s_m = as.numeric(f_split[3]) # Mutants each time
   s_a = as.numeric(f_split[5]) # Assembly ?
   s_r = f_split[4] # Replicate
   # Wrap up the output
   metrics = data.frame(metrics)
   metrics$neutral = rep(s_n, nrow(metrics))
   metrics$m = rep(s_m, nrow(metrics))
   metrics$assembly = rep(s_a, nrow(metrics))
   assembl = rbind(assembl, metrics)
}

assembl = data.frame(assembl)

# Plot: connectance as a function of migrant density in neutral / non-neutral
PL = ggplot(assembl) + theme_bw()
print(PL + geom_point(aes(x=time,y=Co,colour=factor(neutral))) + facet_wrap(factor(m)))
