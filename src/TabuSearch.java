import java.util.ArrayList;

public class TabuSearch {
    private final ArrayList<Solution> tabuList;
    private final int maxIterations;
    private final int tabuSize;

    public TabuSearch(int maxIterations) {
        this.maxIterations = maxIterations;
        this.tabuSize = 100;
        this.tabuList = new ArrayList<>();
    }

    public Solution solve(Solution initialSolution) {
        Solution bestSolution = new Solution(initialSolution);
        for (int i = 0; i < this.maxIterations; i++) {
            ArrayList<Solution> neighbors = generateNeighbors(bestSolution);
            boolean neighborFound = false;
            while (!neighborFound && !neighbors.isEmpty()) {
                Solution bestNeighbor = getBestSolution(neighbors);
//                System.out.println("Current " + bestSolution.getFitness() + " -- Neighbor " + bestNeighbor.getFitness());
                if (!this.tabuList.contains(bestNeighbor)) {
//                    System.out.println("New best neighbor found");
                    neighborFound = true;
                    if (bestNeighbor.getFitness() > bestSolution.getFitness()) {
//                        System.out.println("New best solution found");
                        bestSolution = bestNeighbor;
                        this.tabuList.add(bestNeighbor);
                        if (this.tabuList.size() >= this.tabuSize) {
                            this.tabuList.remove(0);
                        }
                    }
                } else {
                    neighbors.remove(bestNeighbor);
                }
            }
        }
        return bestSolution;
    }

    private ArrayList<Solution> generateNeighbors(Solution solution) {
        ArrayList<Solution> neighbors = new ArrayList<>();
        for (int i = 0; i < 10; i++) { // Generate 10 neighbors
            Solution neighbor = new Solution(solution); // Make a copy of the current solution
            neighbor.mutate();
            neighbor.evaluate();
            neighbors.add(neighbor); // Add the mutated solution to the list of neighbors
        }
        return neighbors;
    }

    private static Solution getBestSolution(ArrayList<Solution> solutionList) {
        Solution bestSolution = null;
        int bestSolutionFitness = 0;
        for (Solution otherSolution : solutionList) {
            if (bestSolutionFitness < otherSolution.getFitness()) {
                bestSolution = otherSolution;
                bestSolutionFitness = bestSolution.getFitness();
            }
        }
        return bestSolution;
    }

    public static void main(String[] args) {
        // Initialising eternity 2 puzzle
        String targetBench = "pieces_16x16";
        // Instantiating Set and Pool
        Set set = new Set("./benchs/pieces_set/" + targetBench + ".txt");
        Solution solution = new Solution(set);
        solution.shufflePieces(true);
        solution.positionPieces();
        solution.evaluate();
        TabuSearch search = new TabuSearch(5000);
        Solution bestSolution = search.solve(solution);
        System.out.println(bestSolution.getFitness());
    }
}
