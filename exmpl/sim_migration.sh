S=80
CO=0.1

cd ../bin/
./niche $S $CO
for m in {0..30..2}
do
   for repl in {1..10}
   do
      for neu in 0 1
      do
         ./pop splist.txt $S $neu 2000 100 mig-$neu-$m-$repl 1 $m 0
      done
   done
done
