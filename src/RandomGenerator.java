import java.util.Random;

public class RandomGenerator {
    // Single instance of the class
    private static RandomGenerator instance;
    // Instance of Random class
    private final Random random;

    /**
     * Private constructor
     */
    private RandomGenerator() {
        random = new Random();
    }

    /**
     * Get the unique instance of the class
     *
     * @return the instance of the class
     */
    public static RandomGenerator getInstance() {
        if (instance == null) {
            instance = new RandomGenerator();
        }
        return instance;
    }

    /**
     * Generate an integer number between 0 and bound
     *
     * @param bound interval bound (exclusive)
     * @return random integer between 0 and bound
     */
    public int generateInt(int bound) {
        return random.nextInt(bound);
    }

    /**
     * Generate and integer number in an interval
     *
     * @param lb lower bound (inclusive)
     * @param ub upper bound (exclusive)
     * @return random integer between lower and upper bound
     */
    public int generateInt(int lb, int ub) {
        return random.nextInt(lb, ub);
    }

    /**
     * Generate float number between 0 and 1
     *
     * @return random number between 0 and 1
     */
    public double generateDouble() {
        return random.nextDouble();
    }
}
