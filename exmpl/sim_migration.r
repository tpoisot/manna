# Output folder, files prefix
prefix = 'mig'
of = '../output/'
files = list.files(path=of, pattern=prefix)

# Required libraries
library(rjson)
library(lattice)

# Function to analyze a SINGLE simulation
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
migrate = NULL
for(f in files)
{
   # Full file path
   f_path = paste(of,f,sep='')
   # Read the JSON object
   rec = fromJSON(file=f_path)
   # Analyse the simulation
   metrics = singleOutput(rec)
   # Get simulation parameters
   f_split = unlist(strsplit(unlist(strsplit(f,'\\.'))[1],'-'))
   s_n = as.numeric(f_split[2]) # Neutral ?
   s_m = as.numeric(f_split[3]) # Mutants each time
   s_r = f_split[4] # Replicate
   # Wrap up the output
   line_output = c('neutral'=s_n, 'm'=s_m, unlist(metrics))
   migrate = rbind(migrate, line_output)
}

migrate = data.frame(migrate)

# Plot: connectance as a function of migrant density in neutral / non-neutral
PL = ggplot(migrate) + theme_bw()
PL + geom <- boxplot(aes(x=factor(m),y=Co,colour=factor(neutral)))
