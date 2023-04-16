package TSP_JAVA;

import java.util.*;

//All comments are in TSP_Distance.java file

public class TSP_Time {

    private final int N;
    private final int START_NODE;
    private final int FINISHED_STATE;

    private double[][][] time;
    private double minPathCost = Integer.MAX_VALUE;

    private List<Integer> path = new ArrayList<>();
    private boolean ranSolver = false;

    public TSP_Time(double[][][] time) throws IllegalAccessException {
        this(0, time);
    }

    public TSP_Time(int startNode, double[][][] time) throws IllegalAccessException {

        this.time = time;
        N = time.length;
        START_NODE = startNode;

        if (START_NODE < 0 || START_NODE >= N) {
            throw new IllegalAccessException("The starting node must be: 0 <= startNode <= N");
        }

        FINISHED_STATE = (1 << N) - 1;

    }

    public List<Integer> getPath() {
        if (!ranSolver) {
            solve();
        }
        return path;
    }

    public double getPathCost() {
        if (!ranSolver)
            solve();
        return minPathCost;
    }

    public void solve() {

        int state = 1 << START_NODE;
        Double[][] memo = new Double[N][1 << N];
        Integer[][] prev = new Integer[N][1 << N];

        minPathCost = tsp(START_NODE, state, memo, prev);

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

    }

    private double tsp(int i, int state, Double[][] memo, Integer[][] prev) {

        if (state == FINISHED_STATE)
            return time[i][START_NODE][1];

        if (memo[i][state] != null)
            return memo[i][state];

        double minCost = Integer.MAX_VALUE;
        int index = -1;

        for (int next = 0; next < N; next++) {

            if ((state & (1 << next)) != 0)
                continue;

            int nextState = state | (1 << next);

            double newCost = time[i][next][1] + tsp(next, nextState, memo, prev);

            if (newCost < minCost) {
                minCost = newCost;
                index = next;
            }
        }

        prev[i][state] = index;
        return memo[i][state] = minCost;

    }

}
