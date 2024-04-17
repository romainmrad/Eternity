#!/bin/bash

# Go to source directory
cd src/ || exit
# Compile java code
javac Main.java
# Execute java code
java Main
# Remove compiled classes
rm ./*.class
# Execute compiled cpp evaluation
.././eval ../benchs/pieces_set/pieces_16x16.txt ../solutionOutput/solution.txt ../solutionOutput/eval.txt