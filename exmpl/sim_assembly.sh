S=80
CO=0.1

cd ../bin/
./niche $S $CO
for m in 2 10
do
   for repl in {1..10}
   do
      for neu in 0 1
      do
         for assembly in 0 1
         do
            ./pop splist.txt $S $neu 3000 3000 assembly-$neu-$m-$repl-$assembly 1 $m $assembly
         done
      done
   done
done
