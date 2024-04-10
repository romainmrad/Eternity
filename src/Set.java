import java.io.*;

public class Set {
    // First given dimension in input file
    private int xDim;

    // Second given dimension in input file
    private int yDim;

    // Array of pieces
    private Piece[] pieces;

    /**
     * Constructor
     *
     * @param filePath path to input file
     */
    public Set(String filePath) {
        // Truing to read file
        try {
            // Instantiating buffered reader
            BufferedReader bufferedReader = new BufferedReader(new FileReader(filePath));
            // Reading first line to extract dimensions
            String[] dimensions = bufferedReader.readLine().split(" ");
            // Storing board dimensions
            this.xDim = Integer.parseInt(dimensions[0]);
            this.yDim = Integer.parseInt(dimensions[1]);
            int numPieces = this.xDim * this.yDim;
            // Instantiating Pieces array
            this.pieces = new Piece[numPieces];
            // Reading other lines to add pieces to array
            for (int i = 0; i < numPieces; i++) {
                this.pieces[i] = new Piece(bufferedReader.readLine(), i);
            }
            // Closing buffered reader
            bufferedReader.close();
        } catch (FileNotFoundException e) {
            // If file is not found
            System.out.println("File not found: " + filePath);
        } catch (IOException e) {
            // If IO error occurs
            System.out.println("IO error occurred in Set constructor");
        }
    }

    /**
     * @return String representation of a Set
     */
    @Override
    public String toString() {
        // Instantiating string builder
        StringBuilder stringBuilder = new StringBuilder();
        // Adding pieces string representations
        for (Piece piece : this.pieces) {
            stringBuilder.append(piece.toString()).append('\n');
        }
        return stringBuilder.toString();
    }

    /**
     * xDim accessor
     *
     * @return x dimension
     */
    public int getxDim() {
        return this.xDim;
    }

    /**
     * yDim accessor
     *
     * @return y dimension
     */
    public int getyDim() {
        return this.yDim;
    }

    /**
     * Get corner pieces
     *
     * @return corner pieces in a list
     */
    public Piece[] getCornerPieces() {
        // Instantiating corners array of size 4
        Piece[] pieces = new Piece[4];
        // Copying piece objects in new array
        for (int i = 0; i < 4; i++) {
            pieces[i] = new Piece(this.pieces[i]);
        }
        return pieces;
    }

    /**
     * Get edge pieces
     *
     * @return edge pieces in a list
     */
    public Piece[] getEdgePieces() {
        // Instantiating number of edge pieces and array of edge pieces
        int numPieces = 2 * ((this.xDim - 2) + (this.yDim - 2));
        Piece[] pieces = new Piece[numPieces];
        // Copying piece objects in new array
        for (int i = 0; i < numPieces; i++) {
            pieces[i] = new Piece((this.pieces[i + 4]));
        }
        return pieces;
    }

    /**
     * Get body pieces
     *
     * @return body pieces in a list
     */
    public Piece[] getBodyPieces() {
        // Instantiating number of body pieces, array of pieces and start index in original pieces list
        int numPieces = (this.xDim - 2) * (this.yDim - 2);
        int startIndex = 4 + 2 * ((this.xDim - 2) + (this.yDim - 2));
        Piece[] pieces = new Piece[numPieces];
        // Copying piece objects in new array
        for (int i = 0; i < numPieces; i++) {
            pieces[i] = new Piece(this.pieces[i + startIndex]);
        }
        // Copying pieces in array and returning it
        return pieces;
    }
}
