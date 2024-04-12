import java.util.ArrayList;

public class TabuSearch {
    // Tabu list to store visited solutions
    private final ArrayList<Solution> tabuList;

    // Max number of iterations
    private final int maxIterations;

    /**
     * Constructor
     *
     * @param maxIterations maximum number of iterations
     */
    public TabuSearch(int maxIterations) {
        this.maxIterations = maxIterations;
        this.tabuList = new ArrayList<>();
    }

    /**
     * Solve tabu search optimisation
     *
     * @param initialSolution initial solution
     * @return best found solution after all iterations
     */
    public Solution solve(Solution initialSolution, boolean verbose) {
        // Instantiate the best solution and set it to initial solution
        Solution bestSolution = initialSolution;
        int indexTracker = 0;
        int i = 0;
        // Start iterations
        while (i < this.maxIterations && i - indexTracker < 5000) {
            // Get current best solution neighbors
            ArrayList<Solution> neighbors = generateNeighbors(bestSolution);
            // Reset bestNeighborFound variable
            boolean bestNeighborFound = false;
            // While no best neighbor found and neighbor list is not empty
            while (!bestNeighborFound && !neighbors.isEmpty()) {
                // Get best neighbor of current neighbor list
                Solution bestNeighbor = getBestSolution(neighbors);
                // If best neighbor not in tabu list
                if (!this.tabuList.contains(bestNeighbor)) {
                    // Set bestNeighborFound to true to exist while loop
                    bestNeighborFound = true;
                    if (verbose)
                        System.out.print("TS Iteration: " + String.format("%5d", i) + " --- Best solution fitness: " + bestSolution.getFitness() + "\r");
                    // Update tabu list
                    // If current best neighbor better than current best solution
                    if (bestNeighbor.getFitness() > bestSolution.getFitness()) {
                        // Set best solution to current best neighbor
                        bestSolution = bestNeighbor;
                        indexTracker = i;
                        this.tabuList.add(bestNeighbor);
                        if (this.tabuList.size() >= 100) {
                            this.tabuList.remove(0);
                        }
                    }
                    // If best neighbor in tabu list, remove it from neighbors list and try again
                } else {
                    neighbors.remove(bestNeighbor);
                }
            }
            i++;
        }
        if (verbose) System.out.println();
        return bestSolution;
    }

    /**
     * Generate a list of neighbors for a given solution.
     * Neighbors are generated using mutations (swaps and rotations).
     *
     * @param solution the solution
     * @return list of neighbors to the solution
     */
    private ArrayList<Solution> generateNeighbors(Solution solution) {
        // Instantiate neighbors list
        ArrayList<Solution> neighbors = new ArrayList<>();
        // Generate 10 neighbors
        for (int i = 0; i < 10; i++) {
            // Make a copy of the current solution
            Solution neighbor = solution.clone();
            // Mutate it and evaluate it
            neighbor.mutate();
            neighbor.mutate();
            neighbor.evaluate();
            // Add the mutated solution to the list of neighbors
            neighbors.add(neighbor);
        }
        return neighbors;
    }

    /**
     * Get the best solution in a list of solutions
     *
     * @param solutionList list of solutions
     * @return the best solution
     */
    private static Solution getBestSolution(ArrayList<Solution> solutionList) {
        // Instantiate best solution pointer to null
        Solution bestSolution = null;
        int bestSolutionFitness = 0;
        // Find solution with max fitness in list and return it
        for (Solution otherSolution : solutionList) {
            if (bestSolutionFitness < otherSolution.getFitness()) {
                bestSolution = otherSolution;
                bestSolutionFitness = bestSolution.getFitness();
            }
        }
        return bestSolution;
    }
}
