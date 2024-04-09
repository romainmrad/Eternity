public class Piece {
    // Array of sides colors
    private int[] sides;
    // Piece rotation
    private int rotation;
    // Piece index in input file
    private final int index;

    /**
     * Piece constructor
     * "1 2 3 4" becomes [1, 2, 3, 4]
     *
     * @param numbersString string of numbers to split into integer array
     */
    public Piece(String numbersString, int index) {
        // Splitting string
        String[] numbersArray = numbersString.split(" ");
        this.sides = new int[4];
        // Parsing integers and adding to array
        for (int i = 0; i < numbersArray.length; i++) {
            this.sides[i] = Integer.parseInt(numbersArray[i]);
        }
        // Initialising rotation
        this.rotation = 0;
        // Adding piece index
        this.index = index;
    }

    /**
     * Copy constructor method
     */
    public Piece(Piece other) {
        this.sides = other.sides;
        this.rotation = other.rotation;
        this.index = other.index;
    }


    /**
     * Rotates a piece clockwise
     * Before rotation: [1, 2, 3, 4]
     * After rotation: [4, 1, 2, 3]
     */
    public void rotateClockwise() {
        // Initialising rotated array
        int[] rotatedSides = new int[4];
        rotatedSides[0] = this.sides[3];
        rotatedSides[1] = this.sides[0];
        rotatedSides[2] = this.sides[1];
        rotatedSides[3] = this.sides[2];
        // Updating rotation and sides variable
        if (this.rotation == 3) this.rotation = 0;
        else this.rotation++;
        this.sides = rotatedSides;
    }

    /**
     * Switch back integer array to string
     * [1, 2, 3, 4] becomes "1 2 3 4"
     *
     * @return String representation of the piece
     */
    @Override
    public String toString() {
        // Instantiating string builder
        StringBuilder stringBuilder = new StringBuilder();
        // Adding sides integer values
        for (int i = 0; i < this.sides.length; i++) {
            stringBuilder.append(String.format("%2d", this.sides[i])).append(" ");
            if (i == this.sides.length - 1) stringBuilder.append("  ");
        }
        return stringBuilder.toString();
    }

    @Override
    public boolean equals(Object o) {
        return o instanceof Piece && ((Piece) o).index == this.index && ((Piece) o).rotation == this.rotation;
    }

    /**
     * Checks if a piece is a body piece
     *
     * @return true if piece is a body piece
     */
    public boolean isBody() {
        return (countEdges(this.sides) == 0);
    }

    /**
     * Checks if a piece is an edge
     *
     * @return true if piece is an edge
     */
    public boolean isEdge() {
        return (countEdges(this.sides) == 1);
    }

    /**
     * Checks if a piece is a corner
     *
     * @return true if piece is a corner
     */
    public boolean isCorner() {
        return (countEdges(this.sides) == 2);
    }

    /**
     * Checks if a piece is in an array
     *
     * @param piece target piece
     * @param arr   array to check
     * @return true if target piece is in array
     */
    public static boolean isNotInArray(Piece piece, Piece[] arr) {
        for (Piece otherPiece : arr) {
            if (otherPiece != null && otherPiece.index == piece.index) return false;
        }
        return true;
    }

    /**
     * Checks for the edge orientation of an edge piece
     *
     * @return string orientation: "top", "bottom", "left", "right"
     */
    public String orientation() {
        if (this.top() == 0 && this.left() == 0) return "top-left";
        if (this.top() == 0 && this.right() == 0) return "top-right";
        if (this.bottom() == 0 && this.left() == 0) return "bottom-left";
        if (this.bottom() == 0 && this.right() == 0) return "bottom-right";
        if (this.left() == 0) return "left";
        if (this.right() == 0) return "right";
        if (this.top() == 0) return "top";
        if (this.bottom() == 0) return "bottom";
        return "notEdge";
    }

    /**
     * Modifies an edge orientation
     *
     * @param orientation string orientation of the edge piece: "top", "bottom", "left", "right"
     */
    public void modifyOrientation(String orientation) {
        if (!orientation.equals("notEdge")) {
            while (!this.orientation().equals(orientation)) {
                this.rotateClockwise();
            }
        }
    }

    /**
     * Count number of edges on a piece
     *
     * @param arr piece sides
     * @return number of edges
     */
    private static int countEdges(int[] arr) {
        int count = 0;
        for (int num : arr) {
            if (num == 0) count++;
        }
        return count;
    }

    /**
     * Index accessor
     *
     * @return piece index in initial array
     */
    public int getIndex() {
        return this.index;
    }

    /**
     * Rotation accessor
     *
     * @return piece rotation
     */
    public int getRotation() {
        return this.rotation;
    }

    /**
     * Sides accessor
     *
     * @return sides array
     */
    public int[] getSides() {
        return this.sides;
    }

    /**
     * @return Bottom side
     */
    public int bottom() {
        return this.sides[0];
    }

    /**
     * @return Left side
     */
    public int left() {
        return this.sides[1];
    }

    /**
     * @return Top side
     */
    public int top() {
        return this.sides[2];
    }

    /**
     * @return Right side
     */
    public int right() {
        return this.sides[3];
    }

    public static void main(String[] args) {
        Piece piece1 = new Piece("1 1 0 0", 0);
        Piece piece2 = new Piece("1 1 0 0", 0);
        piece1.rotateClockwise();
        System.out.println(piece1.equals(piece2));
    }
}
