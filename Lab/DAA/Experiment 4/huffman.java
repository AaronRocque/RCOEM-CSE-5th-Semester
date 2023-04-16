package Experiment_4;

//import java.util.*;

class huffmanPrint {
    public static void printCode(node root, String s) {
        if (root.left == null && root.right == null) {
            System.out.println(root.ch + "-" + s);
            return;
        }
        printCode(root.left, s + "0");
        printCode(root.right, s + "1");
    }
}
