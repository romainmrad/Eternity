# Eternity 2 Genetic Algorithm implementation

Romain MRAD

## UML Diagrams
- [Classes UML Diagram](docs/classes.pdf)
- [Sequence UML Diagram](docs/sequence.pdf)

## Algorithm

To solve the eternity 2 16x16 puzzle, we implemented a Genetic Algorithm
and a Tabu Search optimisation to reach a good fitness level. 

### Genetic Algorithm

The GA is implemented using the [Pool](./src/Pool.java) object. 
- Parent selection is random-tournament-based which lets us diversify the selection
while keeping a having elitism. 
- Children are generated using two-point crossover of both parents
- Best of both children is retained for next generation of solutions
- After each breeding process, a Tabu Search optimisation is executed
on each child of the new generation. 

### Tabu Search
The TS is implemented using the [TabuSearch](./src/TabuSearch.java) object.
- Neighbors are generated using mutations on the current solution
- The algorithm runs while two conditions are true : 
  - number of iterations < max iterations
  - number of iterations since last best found solution < max iteration threshold

## Fine tuning

The following graph is generated using a [Python script](./fitness_visualisation.py).
To test each tuning, we execute the [Main java class](./src/Main.java) 10 times.

The parameters we tested were:
- mutation rate
- generation size
- number of iterations in the tabu search

At first, we experimented with different combinations of mutation rate and generation size. We found that a mutation rate of 0.001 performed better than 0.01. The size of the generations did not have much impact, so we fixed it at 10. Finally, we tried different numbers of iterations for the tabu search, and observed that the higher the number of iterations, the better the algorithm was at finding good solutions.

We then introduced stopping criteria instead of fixing parameters outright:
- the genetic algorithm stops if a target fitness value is reached (340 in the Main) or if a maximum number of iterations is exceeded (5 in the Main)
- the tabu search stops if the number of iterations since the last improvement goes beyond a threshold. In other words, if no better solution has been found for N iterations, the search ends.

![image](./graphs/fitness.png)

Execute this command to visualise the fitness .csv file : 
```shell
Python3 fitness_visualisation.py
```

Requirements : 
- seaborn
- matplotlib
- pandas

## Shell Automations

Two Shell scripts are implemented to simplify and automate the execution
of our program : 
- [`run.sh`](./run.sh) script is used to execute the algorithm once
- [`automate_runs.sh`](./automate_runs.sh) is used to execute the [`run.sh`](./run.sh) 10 times

To run any of these automations, execute the following commands in a Shell opened at the root directory "Eternity":
```shell
./run.sh
```
or 
```shell
./automate_runs.sh
```

## Results

All found solutions are output twice : 
- once for fitness evaluation using the provided c++ script [link to directory](./solutionOutput/individualSolutions)
- once for visualisation using the provided processing script [link to directory](./processing)

The maximum found solution has a fitness of 337. See following files for evaluation and visualisation. 
- [Evaluation txt file](./solutionOutput/individualSolutions/fitness337.txt)
- [Processing txt file](./processing/fitness337.txt). You can execute the [processing file](processing/sketch_190510a_copiemodif18h50.pde) directly. The solution is
already referenced in the code.

To evaluate the solution, execute this in a terminal:
```shell
.././eval ../benchs/pieces_set/pieces_16x16.txt ../solutionOutput/fitness337.txt ../solutionOutput/eval.txt
```
The fitness will be output in solutionOutput/eval.txt file. 
