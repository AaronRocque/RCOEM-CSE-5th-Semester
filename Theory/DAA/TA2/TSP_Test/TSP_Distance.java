package TSP_Test;

import java.util.*;

public class TSP_Distance {

    private final int N;
    private final int START_NODE;
    private final int FINISHED_STATE;

    private double[][][] distance;
    private double minPathCost = Integer.MAX_VALUE;

    private List<Integer> path = new ArrayList<>();
    private boolean ranSolver = false;

    public TSP_Distance(double[][][] distance) throws IllegalAccessException {
        this(0, distance); // Constructor chaining
        // That is, calling constructor of the same class
    }

    public TSP_Distance(int startNode, double[][][] distance) throws IllegalAccessException {

        this.distance = distance;
        N = distance.length;
        START_NODE = startNode;

        if (START_NODE < 0 || START_NODE >= N) {
            throw new IllegalAccessException("The starting node must be: 0 <= startNode <= N");
        }

        FINISHED_STATE = (1 << N) - 1;
        // This will set all the bits to 1
        // This means that all the nodes have been visited

    }

    // Returns the optimal path for TSP
    public List<Integer> getPath() {
        if (!ranSolver) {
            solve();
        }
        return path;
    }

    // Returns the cost
    public double getPathCost() {
        if (!ranSolver)
            solve();

        return minPathCost;
    }

    public void solve() {

        // Run the solver
        int state = 1 << START_NODE;
        Double[][] memo = new Double[N][1 << N]; // Creates a 4x16 matrix
        Integer[][] prev = new Integer[N][1 << N]; // Creates a 4x16 matrix

        minPathCost = tsp(START_NODE, state, memo, prev);

        // Regenerate the path
        int index = START_NODE;

        while (true) {
            path.add(index);
            Integer nextIndex = prev[index][state];

            if (nextIndex == null)
                break;

            int nextState = state | (1 << nextIndex);
            state = nextState;
            index = nextIndex;
        }

        path.add(START_NODE);
        ranSolver = true;

        //For the MEMO and PREV matrices
        /*
         * System.out.println("-----------------------------------------------");
         * for(Integer[] i:memo){
         * for(Integer i1: i){
         * System.out.print(i1+"\t");
         * }
         * System.out.println();
         * }
         * 
         * System.out.println("-----------------------------------------------");
         * for(Integer[] i:prev){
         * for(Integer i1: i){
         * System.out.print(i1+"\t");
         * }
         * System.out.println();
         * }
         * 
         * System.out.println("-----------------------------------------------");
         */
    }

    private double tsp(int i, int state, Double[][] memo, Integer[][] prev) {

        // Path done
        if (state == FINISHED_STATE)
            return distance[i][START_NODE][0];

        // Returns answer if already calculated 
        if (memo[i][state] != null)
            return memo[i][state];

        double minCost = Integer.MAX_VALUE;
        int index = -1;

        for (int next = 0; next < N; next++) {

            // Skips if the next node is already visited.
            if ((state & (1 << next)) != 0)
                continue;

            int nextState = state | (1 << next);

            double newCost = distance[i][next][0] + tsp(next, nextState, memo, prev);

            if (newCost < minCost) {
                minCost = newCost;
                index = next;
            }
        }

        prev[i][state] = index;
        memo[i][state] = minCost;
        return minCost;

    }

}
