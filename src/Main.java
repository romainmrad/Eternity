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
        for (int i = 0; i < 200; i++) {
            // Crossover
            pool.crossover();
            // Tabu Search optimisation
            pool.solveTabuSearch();
            // Log
            System.out.println("Iteration: " + i + " --- Best solution score: " + pool.getBestSolution().getFitness());
            // Update best solution
            if (pool.getBestSolution().getFitness() > overallBestFitness) {
                overallBestSolution = pool.getBestSolution();
                overallBestFitness = overallBestSolution.getFitness();
            }
        }
        // Output last solution and overall solution for evaluation and processing
        assert overallBestSolution != null;
        overallBestSolution.outputEval("../solutionOutput/individualSolutions/fitness" + overallBestFitness + ".txt");
        overallBestSolution.outputEval("../solutionOutput/solution.txt");
        overallBestSolution.outputProcessing("../processing/fitness" + overallBestFitness + ".txt");
    }
}