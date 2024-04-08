cd src/ || exit
javac Main.java
for ((i = 0; i < 10; i++)); do
  java Main
  .././eval ../benchs/pieces_set/pieces_16x16.txt ../solutionOutput/overallBestSolutionOutput_pieces_16x16.txt ../solutionOutput/fitness.txt
done
rm ./*.class
