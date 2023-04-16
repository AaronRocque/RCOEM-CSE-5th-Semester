package TSP_Test;

import java.util.*;
import java.text.DecimalFormat;

//import java.util.*;

public class Main {

    private static final DecimalFormat df = new DecimalFormat("0.00");

    public static void main(String[] args) throws IllegalAccessException {
        
        //int n = 4{};

        

        // double[][][] matrix = {{{0,0},{9,10},{4,15},{7,20}},
        //                           {{7,10},{0,0},{3,35},{2,25}},
        //                           {{10,15},{6,35},{0,0},{9,30}},
        //                           {{12,20},{15,25},{6,30},{0,0}}}; //makes a 4X4 matrix

        /*double[][][] matrix = {{{0,0},{10,10},{15,15},{20,20}},
                                  {{5,10},{0,0},{9,35},{10,25}},
                                  {{6,15},{13,35},{0,0},{12,30}},
                                  {{8,20},{8,25},{9,30},{0,0}}};*/
        
    //    double[][][] matrix = {{{0,0},{10,9},{15,4},{20,7}},
    //                               {{5,7},{0,0},{9,3},{10,2}},
    //                               {{6,10},{13,5},{0,0},{12,9}},
    //                               {{8,12},{8,15},{9,6},{0,0}}}; 

        // double[][][] matrix = {{{0,0},{9,10},{4,15},{7,20}},
        //                           {{7,5},{0,0},{3,9},{2,10}},
        //                           {{10,6},{6,13},{0,0},{9,12}},
        //                           {{12,8},{15,8},{6,9},{0,0}}};


        // double[][][] matrix = {{{0,0},{10,13},{15,4},{20,7}},
        //                           {{5,11},{0,0},{9,3},{10,2}},
        //                           {{6,10},{13,5},{0,0},{12,9}},
        //                           {{8,12},{8,15},{9,13},{0,0}}}; 

        double[][][] matrix = {{{0,0},{10,15},{15,4},{20,7}},
                                {{5,13},{0,0},{9,3},{10,2}},
                                {{6,10},{13,10},{0,0},{12,9}},
                                {{8,14},{8,15},{9,16},{0,0}}}; 




        TSP_Distance distanceSolver = new TSP_Distance(matrix);

        List<Integer> tourDistance = new ArrayList<>();
        tourDistance = distanceSolver.getTour();

        int timeCost = 0;
        int i = 0;

         // Prints: [0, 2, 1, 3, 0]
        System.out.println("Tour: " + tourDistance);

        // Print: 24
        System.out.println("Distance cost: " + distanceSolver.getTourCost());
    

        for(i = 0; i < 3; i++) {
            timeCost += matrix[tourDistance.get(i)][tourDistance.get(i+1)][1];
        }
        timeCost += matrix[tourDistance.get(i)][0][1];

        System.out.println("Time cost: " + timeCost);

        System.out.println("------------------------------------------------------------------------");

        TSP_Time timeSolver = new TSP_Time(matrix);

        List<Integer> tourTime = new ArrayList<>();
        tourTime = timeSolver.getTour();

        int distanceCost = 0;
        int j = 0;

         // Prints: [0, 1, 3, 2, 0]
        System.out.println("Tour: " + tourTime);

        // Print: 80
        System.out.println("Time cost: " + timeSolver.getTourCost());


        for(j = 0; j < 3; j++) {
            distanceCost += matrix[tourTime.get(j)][tourTime.get(j+1)][0];
        }
        distanceCost += matrix[tourTime.get(j)][0][0];

        System.out.println("Disatnce cost: " + distanceCost);

        System.out.println("---------------------------------------------------------");

        double[][] speed = new double[4][4];

        for (i = 0; i < 4; i++) {
            for (j = 0; j < 4; j++) {

                if( matrix[i][j][1] == 0) {
                    speed[i][j] = 0;
                    System.out.print(df.format(speed[i][j]) + "\t");
                    continue;
                }
                speed[i][j] = matrix[i][j][0] / matrix[i][j][1];
                //System.out.println(speed[i][j] + "\t" +  matrix[i][j][0] + '\t' + matrix[i][j][1] );
                System.out.print(df.format(speed[i][j]) + "\t");
                
            }
            System.out.println();
        }

        TSP_DistanceTime speedSolver = new TSP_DistanceTime(speed);

        List<Integer> tourSpeed = new ArrayList<>();
        tourSpeed = speedSolver.getTour();

         // Prints: [0, 2, 1, 3, 0]
        System.out.println("Tour: " + tourSpeed);

        double speedDistanceCost = 0;
        double speedTimeCost = 0;

        for(j = 0; j < 3; j++) {
            speedDistanceCost += matrix[tourSpeed.get(j)][tourSpeed.get(j+1)][0];
        }
        speedDistanceCost += matrix[tourTime.get(j)][0][0];

        System.out.println("Disatnce cost: " + speedDistanceCost);

        for(j = 0; j < 3; j++) {
            speedTimeCost += matrix[tourSpeed.get(j)][tourSpeed.get(j+1)][1];
        }
        speedTimeCost += matrix[tourTime.get(j)][0][1];

        System.out.println("Time cost: " + speedTimeCost);
    




    }
    
}
