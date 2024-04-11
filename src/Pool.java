import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;

public class Pool {
    // Arraylist of pool solutions
    private ArrayList<Solution> storedSolutions;

    // Random generator
    private final RandomGenerator random;

    // Set object
    private final Set set;


    /**
     * Constructor
     */
    public Pool(Set set) {
        this.storedSolutions = new ArrayList<>();
        this.random = RandomGenerator.getInstance();
        this.set = set;
    }

    /**
     * Add a solution to the gene pool
     *
     * @param solution to add
     */
    private void addSolution(Solution solution) {
        storedSolutions.add(solution);
    }

    /**
     * Initialise pool solutions
     *
     * @param numSolutions number of solutions to add
     */
    public void initialisePoolSolutions(int numSolutions) {
        for (int i = 0; i < numSolutions; i++) {
            Solution solution = new Solution(set);
            solution.shufflePieces(true);
            solution.positionPieces();
            solution.evaluate();
            addSolution(solution);
        }
    }

    /**
     * Performs crossover genetic algorithm
     */
    public void crossover() {
        ArrayList<Solution> newGeneration = new ArrayList<>();
        // Select parents for crossover
        for (int i = 0; i < this.storedSolutions.size(); i++) {
            Solution parent1 = selectParent();
            Solution parent2 = selectParent();
            // Perform crossover
            Solution child = performCrossover(parent1, parent2);
            if (!child.checkUniqueness()) {
                System.out.println("Solution not unique");
                return;
            }
            // Mutate the child solution
            child.mutate();
            child.evaluate();
            // Add child to the new generation
            newGeneration.add(child);
        }
        // Replace the old generation with the new one
        this.storedSolutions = newGeneration;
    }

    /**
     * Randomly select parents for tournament
     *
     * @return return best parent
     */
    private Solution selectParent() {
        // Tournament size
        int tournamentSize = 3;

        // Randomly select tournamentSize solutions
        Solution bestSolution = null;
        int bestScore = Integer.MIN_VALUE;
        for (int i = 0; i < tournamentSize; i++) {
            // Get candidate
            Solution candidate = this.storedSolutions.get(this.random.generateInt(this.storedSolutions.size()));
            int score = candidate.getFitness();
            if (score > bestScore) {
                bestScore = score;
                bestSolution = candidate;
            }
        }
        // Return best candidate
        return bestSolution;
    }

    /**
     * Perform crossover between parents
     *
     * @param parent1 first parent
     * @param parent2 second parent
     * @return best of both children
     */
    private Solution performCrossover(Solution parent1, Solution parent2) {
        // Number of total pieces
        int numPieces = this.set.getxDim() * this.set.getyDim();
        // Crossover point
        int secondCrossoverPoint = this.random.generateInt(1, numPieces);
        int firstCrossoverPoint = this.random.generateInt(secondCrossoverPoint);
        // Converting parents to one dimensional pieces array
        Piece[] firstParentPieces = parent1.toOneDimension();
        Piece[] secondParentPieces = parent2.toOneDimension();
        // Creating children 1D pieces array
        Piece[] firstChildPieces = new Piece[numPieces];
        Piece[] secondChildPieces = new Piece[numPieces];
        for (int i = 0; i < numPieces; i++) {
            // If between crossover points, copy parent
            if (i >= firstCrossoverPoint && i <= secondCrossoverPoint) {
                for (Piece piece : firstParentPieces) {
                    if (Piece.isNotInArray(piece, firstChildPieces)) {
                        firstChildPieces[i] = new Piece(piece);
                        break;
                    }
                }
                for (Piece piece : secondParentPieces) {
                    if (Piece.isNotInArray(piece, secondChildPieces)) {
                        secondChildPieces[i] = new Piece(piece);
                        break;
                    }
                }
                // If outside crossover points, copy other parent
            } else {
                for (Piece piece : secondParentPieces) {
                    if (Piece.isNotInArray(piece, firstChildPieces)) {
                        firstChildPieces[i] = new Piece(piece);
                        break;
                    }
                }
                for (Piece piece : firstParentPieces) {
                    if (Piece.isNotInArray(piece, secondChildPieces)) {
                        secondChildPieces[i] = new Piece(piece);
                        break;
                    }
                }
            }
        }
        // Resetting pieces order
        firstChildPieces = resetPiecesOrder(firstChildPieces);
        secondChildPieces = resetPiecesOrder(secondChildPieces);
        // Instantiating solutions
        Solution child1 = new Solution(this.set, firstChildPieces);
        child1.positionPieces();
        Solution child2 = new Solution(this.set, secondChildPieces);
        child2.positionPieces();
        // Returning best child
        child1.evaluate();
        child2.evaluate();
        if (child1.getFitness() > child2.getFitness()) return child1;
        else return child2;
    }

    /**
     * Perform tabu search on all solutions in current pool
     */
    public void solveTabuSearch(int iterations, boolean verbose) {
        this.storedSolutions.replaceAll(initialSolution -> new TabuSearch(iterations).solve(initialSolution, verbose));
    }

    /**
     * Reorder pieces as follows: corners, edges, body
     *
     * @param pieces 1D array of pieces
     * @return reordered pieces array
     */
    private Piece[] resetPiecesOrder(Piece[] pieces) {
        // Instantiating variables
        Piece[] newPieces = new Piece[pieces.length];
        int cornerIndex = 0;
        int edgeIndex = 4;
        int bodyIndex = 4 + 2 * (this.set.getxDim() - 2) + 2 * (this.set.getyDim() - 2);
        // Reordering pieces for positioning
        for (Piece piece : pieces) {
            if (piece.isCorner()) {
                newPieces[cornerIndex] = piece;
                cornerIndex++;
            } else if (piece.isEdge()) {
                newPieces[edgeIndex] = piece;
                edgeIndex++;
            } else {
                newPieces[bodyIndex] = piece;
                bodyIndex++;
            }
        }
        return newPieces;
    }

    /**
     * Get the best solution from current pool
     *
     * @return the solution with the lowest number of errors
     */
    public Solution getBestSolution() {
        Solution bestSolution = null;
        int minFitness = Integer.MIN_VALUE;
        for (Solution solution : this.storedSolutions) {
            int fitness = solution.getFitness();
            if (fitness > minFitness) {
                minFitness = fitness;
                bestSolution = solution;
            }
        }
        return bestSolution;
    }

    /**
     * String representation of the gene pool
     */
    @Override
    public String toString() {
        // Instantiating string builder
        StringBuilder stringBuilder = new StringBuilder();
        // Adding solutions string representation
        for (int i = 0; i < this.storedSolutions.size(); i++) {
            // Adding solution index
            stringBuilder.append("Solution: ").append(i);
            // Adding solution score
            stringBuilder.append(" --- Fitness: ").append(this.storedSolutions.get(i).getFitness()).append('\n');
            // Adding solution string representation
            stringBuilder.append(this.storedSolutions.get(i));
            // Adding line breaks
            stringBuilder.append('\n').append('\n');
        }
        return stringBuilder.toString();
    }

    public static void main(String[] args) {
        System.out.print("ok");
        System.out.print("okk");
    }
}
