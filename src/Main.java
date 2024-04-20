/**
 * Projet Optimisation Combinatoire sur Eternity II
 * <p>
 * Romain MRAD, Erwan COYAUD
 */
public class Main {
    public static void main(String[] args) {
        // Initialising eternity 2 puzzle
        String targetBench = "pieces_16x16";
        // Instantiating Set and Pool
        Set set = new Set("../benchs/pieces_set/" + targetBench + ".txt");
        Pool pool = new Pool(set);
        // Keeping track of best solution
        Solution overallBestSolution = null;
        int overallBestFitness = Integer.MIN_VALUE;
        // Initialising pool with random solutions and saving score
        pool.initialisePoolSolutions(10);
        // Performing genetic algorithm
        int i = 0;
        while (overallBestFitness <= 340 && i < 5) {
            System.out.println("================ GA Iteration: " + String.format("%2d", i) + " ================");
            // Crossover
            pool.crossover();
            // Tabu Search optimisation
            pool.solveTabuSearch(100000, 2000, true);
            // Log
            System.out.println();
            System.out.println(">>> Best solution fitness: " + pool.getBestSolution().getFitness());
            // Update best solution
            if (pool.getBestSolution().getFitness() > overallBestFitness) {
                overallBestSolution = pool.getBestSolution();
                overallBestFitness = overallBestSolution.getFitness();
                // Output last solution and overall solution for evaluation and processing
                overallBestSolution.outputEval("../solutionOutput/individualSolutions/fitness" + overallBestFitness + ".txt");
                overallBestSolution.outputEval("../solutionOutput/solution.txt");
                overallBestSolution.outputProcessing("../processing/fitness" + overallBestFitness + ".txt");
            }
            System.out.println();
            i++;
        }
    }
}