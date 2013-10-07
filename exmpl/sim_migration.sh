cd ../bin/
./niche 200 0.10
for m in 0 1 2 3 4 5 10 20 30 50 75 100
do
   for repl in {1..20}
   do
      for neu in 0 1
      do
         ./pop splist.txt 200 $neu 2000 50 mig-$neu-$m-$repl 1 $m 0
      done
   done
done
