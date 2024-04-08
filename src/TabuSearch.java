import javax.naming.ldap.SortKey;
import java.util.ArrayList;
import java.util.List;

public class TabuSearch {
    private final List<Solution> tabuList;
    private final int maxIterations;
    private final int tabuSize;

    public TabuSearch(int maxIterations, int tabuSize) {
        this.maxIterations = maxIterations;
        this.tabuSize = tabuSize;
        tabuList = new ArrayList<>();
    }

    public Solution solve(Solution initialSolution) {
        Solution bestSolution = new Solution(initialSolution);
        int bestSolutionFitness = bestSolution.getFitness();
        for (int i = 0; i < maxIterations; i++) {
            List<Solution> neighbors = generateNeighbors(bestSolution);
            for (Solution neighbor : neighbors) {
                if (!tabuList.contains(neighbor) && neighbor.getFitness() > bestSolutionFitness) {
                    bestSolution = neighbor;
                    bestSolutionFitness = neighbor.getFitness();
                    tabuList.add(neighbor);
                }
            }
            if (tabuList.size() > tabuSize) {
                tabuList.remove(0);
            }
        }
        return bestSolution;
    }

    private List<Solution> generateNeighbors(Solution solution) {
        List<Solution> neighbors = new ArrayList<>();
        for (int i = 0; i < 10; i++) { // Generate 10 neighbors
            Solution neighbor = new Solution(solution); // Make a copy of the current solution
            neighbor.mutate();
            neighbor.mutate();
            neighbor.evaluate();
            neighbors.add(neighbor); // Add the mutated solution to the list of neighbors
        }
        return neighbors;
    }
}
