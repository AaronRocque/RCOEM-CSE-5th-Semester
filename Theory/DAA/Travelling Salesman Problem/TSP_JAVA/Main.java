package TSP_JAVA;

import java.util.*;
import java.text.DecimalFormat;

public class Main {

    private static final DecimalFormat df = new DecimalFormat("0.00");

    public static void main(String[] args) throws IllegalAccessException {

        // double[][][] matrix = { { { 0, 0 }, { 10, 15 }, { 15, 4 }, { 20, 7 } },
        //                         { { 5, 13 }, { 0, 0 }, { 9, 3 }, { 10, 2 } },
        //                         { { 6, 10 }, { 13, 10 }, { 0, 0 }, { 12, 9 } },
        //                         { { 8, 14 }, { 8, 15 }, { 9, 16 }, { 0, 0 } } };

        // double[][][] matrix = { { { 0, 0 }, { 7, 13 }, { 6, 9 }, { 8, 13 } },
        //                         { { 20, 14 }, { 0, 0 }, { 11, 9 }, { 12, 12 } },
        //                         { { 10, 7 }, { 9, 15 }, { 0, 0 }, { 9, 14 } },
        //                         { { 15, 10 }, { 5, 5 }, { 17, 6 }, { 0, 0 } } };

        double[][][] matrix = { { { 0, 0 }, { 15, 20 }, { 25, 14 }, { 25, 12 } },
                                { { 10, 18 }, { 0, 0 }, { 14, 8 }, { 15, 7 } },
                                { { 11, 15 }, { 18, 15 }, { 0, 0 }, { 17, 14 } },
                                { { 13, 19 }, { 13, 18 }, { 14, 21 }, { 0, 0 } } };

        //Part 1: Best Distance

        System.out.println("\nPart 1: Best Distance");

        TSP_Distance distanceSolver = new TSP_Distance(matrix);

        List<Integer> pathDistance = new ArrayList<>();
        pathDistance = distanceSolver.getPath();

        double timeCost = 0;
        int i = 0;

        //Prints: [0, 1, 3, 2, 0]
        System.out.println("\nPath: " + pathDistance);

        //Prints: 35.0
        System.out.println("Distance cost: " + distanceSolver.getPathCost());

        //Getting the cost for TIME using the Best Distance path
        for (i = 0; i < 3; i++) {
            timeCost += matrix[pathDistance.get(i)][pathDistance.get(i + 1)][1];
        }
        timeCost += matrix[pathDistance.get(i)][0][1];

        //Prints: 43.0
        System.out.println("Time cost: " + timeCost);

        System.out.println("\n------------------------------------------------------------------------\n");

        //Part 2: Best Time

        System.out.println("\nPart 2: Best Time\n");

        TSP_Time timeSolver = new TSP_Time(matrix);

        List<Integer> pathTime = new ArrayList<>();
        pathTime = timeSolver.getPath();

        double distanceCost = 0;
        int j = 0;

        // Prints: [0, 2, 1, 3, 0]
        System.out.println("Path: " + pathTime);

        // Print: 30.0
        System.out.println("Time cost: " + timeSolver.getPathCost());

        for (j = 0; j < 3; j++) {
            distanceCost += matrix[pathTime.get(j)][pathTime.get(j + 1)][0];
        }
        distanceCost += matrix[pathTime.get(j)][0][0];

        //Prints: 46.0
        System.out.println("Disatnce cost: " + distanceCost);

        System.out.println("\n------------------------------------------------------------------------\n");

        //Part 3: Good Distance and Good Time

        System.out.println("\nPart 3: Good Distance and Good Time\n");

        double[][] speed = new double[4][4];

        //Initializing the SPEED matrix 

        System.out.println("Speed Matrix:");
        for (i = 0; i < 4; i++) {
            for (j = 0; j < 4; j++) {

                //We have to do this to avoid division with 0
                if (matrix[i][j][1] == 0) {
                    speed[i][j] = 0;
                    System.out.print(df.format(speed[i][j]) + "\t");
                    continue;
                }

                speed[i][j] = matrix[i][j][0] / matrix[i][j][1];
                System.out.print(df.format(speed[i][j]) + "\t");

            }
            System.out.println("\n");
        }

        //Running TSP for the Speed Matrix
        TSP_DistanceTime speedSolver = new TSP_DistanceTime(speed);

        List<Integer> pathSpeed = new ArrayList<>();
        pathSpeed = speedSolver.getPath();

        // Prints: [0, 3, 2, 1, 0]
        System.out.println("Path: " + pathSpeed);

        double speedDistanceCost = 0;
        double speedTimeCost = 0;

        //Getting Distance Cost for the calculated Path
        for (j = 0; j < 3; j++) {
            speedDistanceCost += matrix[pathSpeed.get(j)][pathSpeed.get(j + 1)][0];
        }
        speedDistanceCost += matrix[pathTime.get(j)][0][0];

        //Prints: 50.0
        System.out.println("Disatnce cost: " + speedDistanceCost);

        //Getting Time Cost for the calculated Path
        for (j = 0; j < 3; j++) {
            speedTimeCost += matrix[pathSpeed.get(j)][pathSpeed.get(j + 1)][1];
        }
        speedTimeCost += matrix[pathTime.get(j)][0][1];

        //Prints: 47.0
        System.out.println("Time cost: " + speedTimeCost);

    }

}
