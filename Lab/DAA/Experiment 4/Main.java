package Experiment_4;

import java.util.*;
class Main{
   public static void main(String[] args)
   {
       char[] charArray = { 'a', 'b', 'c', 'd', 'e' };
       int[] freqArray = { 3,5,6,4,2 };
       PriorityQueue<node> pq = new PriorityQueue<node>(charArray.length, new compareFreq());
       for (int i = 0; i < charArray.length; i++){
           pq.add(new node(charArray[i],freqArray[i]));
       }
 
       node root = null;
       while (pq.size() > 1) {
           node x = pq.peek();
           pq.poll();
           node y = pq.peek();
           pq.poll();
           node n1 = new node();
           n1.freq = x.freq + y.freq;
           n1.left = x;
           n1.right = y;
           root = n1;
           pq.add(n1);
       }
       huffmanPrint.printCode(root, "");
   }
}

