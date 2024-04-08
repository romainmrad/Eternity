import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashSet;

public class Solution {
    // Pieces set
    private final Set set;

    // Array of pieces
    private final Piece[][] pieces;

    // Array of corner pieces [top left, top right, bottom left, bottom right]
    private final Piece[] cornerPieces;

    // Array of edge pieces [top edges, bottom edges, left edges, right edges]
    private final Piece[] edgePieces;

    // Array of body pieces
    private final Piece[] bodyPieces;

    // Solution fitness
    private int fitness;

    // Random generator
    private final RandomGenerator random;

    /**
     * Constructor uses Set constructor
     */
    public Solution(Set set) {
        // Referencing Set object
        this.set = set;
        // Initialising number of errors
        this.fitness = 0;
        // Initialising pieces arrays
        this.pieces = new Piece[this.set.getxDim()][this.set.getyDim()];
        this.cornerPieces = this.set.getCornerPieces();
        this.edgePieces = this.set.getEdgePieces();
        this.bodyPieces = this.set.getBodyPieces();
        // Initialising random generator
        this.random = RandomGenerator.getInstance();
    }

    public Solution(Set set, Piece[] pieces) {
        // Referencing Set object
        this.set = set;
        // Initialising number of errors
        this.fitness = 0;
        // Initialising pieces arrays
        this.pieces = new Piece[this.set.getxDim()][this.set.getyDim()];
        this.cornerPieces = new Piece[4];
        this.edgePieces = new Piece[2 * ((this.set.getxDim() - 2) + (this.set.getyDim() - 2))];
        this.bodyPieces = new Piece[(this.set.getxDim() - 2) * (this.set.getyDim() - 2)];
        System.arraycopy(pieces, 0, this.cornerPieces, 0, 4);
        System.arraycopy(pieces, 4, this.edgePieces, 0, this.edgePieces.length);
        System.arraycopy(pieces, 4 + this.edgePieces.length, this.bodyPieces, 0, this.bodyPieces.length);
        // Initialising random generator
        this.random = RandomGenerator.getInstance();
    }

    /**
     * Copy constructor
     *
     * @param other solution to copy
     */
    public Solution(Solution other) {
        this.set = other.set;
        this.fitness = other.fitness;
        this.random = RandomGenerator.getInstance();
        this.pieces = new Piece[this.set.getxDim()][this.set.getyDim()];
        this.cornerPieces = new Piece[4];
        this.edgePieces = new Piece[2 * ((this.set.getxDim() - 2) + (this.set.getyDim() - 2))];
        this.bodyPieces = new Piece[(this.set.getxDim() - 2) * (this.set.getyDim() - 2)];
        for (int i = 0; i < this.set.getxDim(); i++) {
            for (int j = 0; j < this.set.getyDim(); j++) {
                this.pieces[i][j] = new Piece(other.pieces[i][j]);
            }
        }
        for (int i = 0; i < cornerPieces.length; i++) {
            this.cornerPieces[i] = new Piece(other.cornerPieces[i]);
        }
        for (int i = 0; i < edgePieces.length; i++) {
            this.edgePieces[i] = new Piece(other.edgePieces[i]);
        }
        for (int i = 0; i < bodyPieces.length; i++) {
            this.bodyPieces[i] = new Piece(other.bodyPieces[i]);
        }
    }

    /**
     * Shuffle an array of object Piece
     *
     * @param arr the array
     */
    private void fisherYatesShuffle(Piece[] arr) {
        for (int i = arr.length - 1; i > 0; i--) {
            int index = this.random.generateInt(0, i + 1);
            // Swap arr[i] and arr[index]
            Piece temp = arr[i];
            arr[i] = arr[index];
            arr[index] = temp;
        }
    }

    /**
     * Shuffle all pieces in current solution
     */
    public void shufflePieces(boolean withRotation) {
        // Shuffling corner, edge and body pieces
        fisherYatesShuffle(this.cornerPieces);
        fisherYatesShuffle(this.edgePieces);
        fisherYatesShuffle(this.bodyPieces);
        // Rotate body pieces
        if (withRotation) {
            for (Piece bodyPiece : this.bodyPieces) {
                for (int i = 0; i < this.random.generateInt(4); i++) {
                    bodyPiece.rotateClockwise();
                }
            }
        }
    }

    /**
     * Convert 2D grid-like Piece array to 1D array
     *
     * @return 1D array of Pieces
     */
    public Piece[] toOneDimension() {
        Piece[] oneDimensionPieces = new Piece[this.set.getxDim() * this.set.getyDim()];
        int oneDimensionPiecesIndex = 0;
        for (Piece[] column : this.pieces) {
            for (Piece piece : column) {
                oneDimensionPieces[oneDimensionPiecesIndex] = piece;
                oneDimensionPiecesIndex++;
            }
        }
        return oneDimensionPieces;
    }

    /**
     * Position all corners in solution pieces array
     */
    private void positionCornerPieces() {
        // Placing first corner - top left
        this.pieces[0][0] = this.cornerPieces[0];
        // Placing second corner - top right
        this.pieces[0][this.set.getyDim() - 1] = this.cornerPieces[1];
        // Placing third corner - bottom left
        this.pieces[this.set.getxDim() - 1][0] = this.cornerPieces[2];
        // Placing third corner - bottom left
        this.pieces[this.set.getxDim() - 1][this.set.getyDim() - 1] = this.cornerPieces[3];
    }

    /**
     * Reorient corner pieces in right direction
     */
    private void reorientCornerPieces() {
        // Reorienting first corner - top left
        if (this.pieces[0][0] != null && this.pieces[0][0].isCorner()) this.pieces[0][0].modifyOrientation("top-left");
        // Reorienting second corner - top right
        if (this.pieces[0][this.set.getyDim() - 1] != null && this.pieces[0][this.set.getyDim() - 1].isCorner())
            this.pieces[0][this.set.getyDim() - 1].modifyOrientation("top-right");
        // Reorienting third corner - bottom left
        if (this.pieces[this.set.getxDim() - 1][0] != null && this.pieces[this.set.getxDim() - 1][0].isCorner())
            this.pieces[this.set.getxDim() - 1][0].modifyOrientation("bottom-left");
        // Reorienting third corner - bottom left
        if (this.pieces[this.set.getxDim() - 1][this.set.getyDim() - 1] != null && this.pieces[this.set.getxDim() - 1][this.set.getyDim() - 1].isCorner())
            this.pieces[this.set.getxDim() - 1][this.set.getyDim() - 1].modifyOrientation("bottom-right");
    }

    /**
     * Position edge pieces
     */
    private void positionEdgePieces() {
        int edgeIndex = 0;
        // Placing top and bottom edges
        for (int j = 1; j < this.set.getyDim() - 1; j++) {
            this.pieces[0][j] = this.edgePieces[edgeIndex];
            edgeIndex++;
        }
        // Placing left and right edges
        for (int i = 1; i < this.set.getxDim() - 1; i++) {
            // Placing left edge
            this.pieces[i][0] = this.edgePieces[edgeIndex];
            edgeIndex++;
            // Placing left edge
            this.pieces[i][this.set.getyDim() - 1] = this.edgePieces[edgeIndex];
            edgeIndex++;
        }
        // Placing bottom edge
        for (int j = 1; j < this.set.getxDim() - 1; j++) {
            this.pieces[this.set.getxDim() - 1][j] = this.edgePieces[edgeIndex];
            edgeIndex++;
        }
    }

    /**
     * Reorient edge pieces in right direction
     */
    private void reorientEdgePieces() {
        // Reorienting top and bottom edges
        for (int j = 0; j < this.set.getyDim() - 2; j++) {
            if (this.pieces[0][j + 1] != null && this.pieces[this.set.getxDim() - 1][j + 1] != null) {
                // Reorienting top edges
                if (this.pieces[0][j + 1].isEdge()) this.pieces[0][j + 1].modifyOrientation("top");
                // Reorienting bottom edges
                if (this.pieces[this.set.getxDim() - 1][j + 1].isEdge())
                    this.pieces[this.set.getxDim() - 1][j + 1].modifyOrientation("bottom");
            }
        }
        // Reorienting left and right edges
        for (int i = 0; i < this.set.getxDim() - 2; i++) {
            if (this.pieces[i + 1][0] != null && this.pieces[i + 1][this.set.getyDim() - 1] != null) {
                // Reorienting left edge
                if (this.pieces[i + 1][0].isEdge()) this.pieces[i + 1][0].modifyOrientation("left");
                // Reorienting right edge
                if (this.pieces[i + 1][this.set.getyDim() - 1].isEdge())
                    this.pieces[i + 1][this.set.getyDim() - 1].modifyOrientation("right");
            }
        }
    }

    /**
     * Positioning body pieces
     */
    private void positionBodyPieces() {
        // Initialising piece index to iterate in bodyPieces array
        int pieceIndex = 0;
        // Iterating over body pieces
        for (int i = 0; i < this.set.getxDim() - 2; i++) {
            for (int j = 0; j < this.set.getyDim() - 2; j++) {
                this.pieces[i + 1][j + 1] = this.bodyPieces[pieceIndex];
                pieceIndex++;
            }
        }
    }

    /**
     * Position all pieces in initial order
     */
    public void positionPieces() {
        // Placing pieces
        this.positionCornerPieces();
        this.positionEdgePieces();
        this.positionBodyPieces();
        // Orienting edges and corners
        this.reorientCornerPieces();
        this.reorientEdgePieces();
    }

    /**
     * Evaluating borders current solution
     */
    private void evaluateBorders() {
        // Checking left and right edges
        for (int i = 0; i < this.set.getxDim(); i++) {
            // Checking left edge
            if (this.pieces[i][0].left() != 0) {
                this.fitness = -1;
                return;
            }
            // Checking right edge
            if (this.pieces[i][this.set.getyDim() - 1].right() != 0) {
                this.fitness = -1;
                return;
            }
        }
        // Checking top and bottom edges
        for (int j = 0; j < this.set.getyDim(); j++) {
            // Checking top edge
            if (this.pieces[0][j].top() != 0) {
                this.fitness = -1;
                return;
            }
            // Checking bottom edge
            if (this.pieces[this.set.getxDim() - 1][j].bottom() != 0) {
                this.fitness = -1;
                return;
            }
        }
    }

    /**
     * Evaluate color matching
     */
    private void evaluateBody() {
        // Iterating over all puzzle pieces
        for (int i = 0; i < this.set.getxDim(); i++) {
            for (int j = 0; j < this.set.getyDim(); j++) {
                // If piece is not on right-most column
                if (j < this.set.getyDim() - 1) {
                    // Check compatibility with east neighbor
                    if (this.pieces[i][j].right() == this.pieces[i][j + 1].left()) this.fitness++;
                }
                // If piece is not on last row
                if (i < this.set.getxDim() - 1) {
                    // Check compatibility with south neighbor
                    if (this.pieces[i][j].bottom() == this.pieces[i + 1][j].top()) this.fitness++;
                }
            }
        }
    }

    /**
     * Current solution evaluation
     */
    public void evaluate() {
        // Evaluating borders
        this.evaluateBorders();
        if (this.fitness == 0) {
            // Evaluating color matching
            this.evaluateBody();
        }
    }

    /**
     * Performs mutation by swapping body pieces
     */
    public void mutate() {
        // Mutation rate
        double mutationRate = 0.001;
        for (int i = 0; i < this.set.getxDim(); i++) {
            for (int j = 0; j < this.set.getyDim(); j++) {
                if (this.random.generateDouble() < mutationRate) {
                    // Swap current piece with a random piece in the solution
                    int randX = this.random.generateInt(this.set.getxDim());
                    int randY = this.random.generateInt(this.set.getyDim());
                    if ((this.pieces[i][j].isCorner() && this.pieces[randX][randY].isCorner()) || (this.pieces[i][j].isEdge() && this.pieces[randX][randY].isEdge())) {
                        // Reorienting edges before swap
                        String currentEdgeOrientation = this.pieces[i][j].orientation();
                        String otherEdgeOrientation = this.pieces[randX][randY].orientation();
                        this.pieces[i][j].modifyOrientation(otherEdgeOrientation);
                        this.pieces[randX][randY].modifyOrientation(currentEdgeOrientation);
                        // Swapping pieces
                        Piece temp = this.pieces[i][j];
                        this.pieces[i][j] = this.pieces[randX][randY];
                        this.pieces[randX][randY] = temp;
                    } else if (this.pieces[i][j].isBody() && this.pieces[randX][randY].isBody()) {
                        // Swapping pieces
                        Piece temp = this.pieces[i][j];
                        this.pieces[i][j] = this.pieces[randX][randY];
                        this.pieces[randX][randY] = temp;
                    }
                }
            }
        }
    }

    /**
     * Checks that all pieces in solution are used only once
     *
     * @return true if all pieces are unique
     */
    public boolean checkUniqueness() {
        HashSet<Integer> seenIndices = new HashSet<>();
        for (Piece[] column : this.pieces) {
            for (Piece piece : column) {
                if (seenIndices.contains(piece.getIndex())) {
                    // Found a duplicate index
                    return false;
                }
                seenIndices.add(piece.getIndex());
            }
        }
        return true;
    }

    /**
     * Get score of current solution
     *
     * @return score
     */
    public int getFitness() {
        return this.fitness;
    }

    /**
     * @return string representation of Solution object
     */
    @Override
    public String toString() {
        // Instantiating string builder
        StringBuilder stringBuilder = new StringBuilder();
        // Adding pieces to string representation
        for (Piece[] column : this.pieces) {
            for (Piece piece : column) {
                if (piece != null) stringBuilder.append(piece);
            }
            stringBuilder.append('\n');
        }
        return stringBuilder.toString();
    }

    /**
     * Checks if two solutions are equal
     *
     * @param obj another solution
     * @return true if both solutions are equal
     */
    @Override
    public boolean equals(Object obj) {
        if (obj instanceof Solution) {
            return this.toString().equals(obj.toString());
        }
        return false;
    }

    /**
     * Outputs current solution to a given filepath
     *
     * @param filePath the path to the file
     */
    public void outputEval(String filePath) {
        StringBuilder stringBuilder = new StringBuilder();
        for (Piece[] column : this.pieces) {
            for (Piece piece : column) {
                stringBuilder.append(piece.getIndex()).append(' ').append(piece.getRotation()).append('\n');
            }
        }
        // Write content to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            writer.write(stringBuilder.toString());
            System.out.println("Content written to " + filePath);
        } catch (IOException e) {
            System.err.println("Error writing to file: " + e.getMessage());
        }
    }

    /**
     * Outputs current solution to a given filepath
     *
     * @param filePath the path to the file
     */
    public void outputProcessing(String filePath) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append(this.set.getxDim()).append('\t').append(this.set.getyDim()).append('\n');
        stringBuilder.append("23").append('\n');
        for (Piece piece : this.toOneDimension()) {
            stringBuilder.append(piece.getSides()[2]).append('\t');
            stringBuilder.append(piece.getSides()[1]).append('\t');
            stringBuilder.append(piece.getSides()[0]).append('\t');
            stringBuilder.append(piece.getSides()[3]).append('\t');
            stringBuilder.append('\n');
        }
        // Write content to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            writer.write(stringBuilder.toString());
            System.out.println("Content written to " + filePath);
        } catch (IOException e) {
            System.err.println("Error writing to file: " + e.getMessage());
        }
    }
}
