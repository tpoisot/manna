S=100
CO=0.1

cd ../bin/
./niche $S $CO
for m in {1..100..5}
do
   for repl in {1..20}
   do
      for neu in 0 1
      do
         ./pop splist.txt $S $neu 3000 50 mig-$neu-$m-$repl 1 $m 0
      done
   done
done
