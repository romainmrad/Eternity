public class Main {
    public static void main(String[] args) {
        // Initialising eternity 2 puzzle
        String targetBench = "pieces_16x16";
        // Instantiating Set and Pool
        Set set = new Set("../benchs/pieces_set/" + targetBench + ".txt");
        Pool pool = new Pool(set);
        // Keeping track of best solution
        Solution overallBestSolution = null;
        int overallMaxScore = Integer.MIN_VALUE;
        // Initialising pool with random solutions and saving score
        pool.initialisePoolSolutions(20);
        pool.saveCurrentBestScore();
        // Performing genetic algorithm
        for (int i = 0; i < 5000; i++) {
            // Crossover
            pool.crossover();
            // Evaluate each solution in current pool
            pool.evaluate();
            // Save current best score
            pool.saveCurrentBestScore();
            // Log
            System.out.println("Iteration: " + i + " --- Best solution score: " + pool.getBestSolution().getFitness());
            // Update best solution
            if (pool.getBestSolution().getFitness() > overallMaxScore) {
                overallMaxScore = pool.getBestSolution().getFitness();
                overallBestSolution = pool.getBestSolution();
            }
        }
        // Output score history
        pool.outputScoreHistory("../score/scoreEvolution_" + targetBench + ".csv");
        // Output last solution and overall solution for evaluation and processing
        assert overallBestSolution != null;
        overallBestSolution.outputEval("../solutionOutput/overallBestSolutionOutput_" + targetBench + ".txt");
        overallBestSolution.outputProcessing("../processing/overallBestSolutionProcessing_" + targetBench + ".txt");
    }
}