# Eternity 2 Genetic Algorithm implementation

Élèves : 
- MRAD Romain
- COYAUD Erwan

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
To test each tuning, we execute the [Main](./src/Main.java) script 10 times.

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

To run any of these automations, execute the following commands in a Shell:
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

The maximum found solution has a fitness of 337 
- [Evaluation txt file](./solutionOutput/individualSolutions/fitness337.txt)
- [Processing txt file](./processing/fitness337.txt)
