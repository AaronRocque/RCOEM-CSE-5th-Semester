package Experiment_4;

public class node {

    Character ch;
    int freq;
    node left = null;
    node right = null;

    node() {

    }

    node(Character ch, int freq) {
        this.ch = ch;
        this.freq = freq;
    }

    node(Character ch, int freq, node left, node right) {
        this.ch = ch;
        this.freq = freq;
        this.left = left;
        this.right = right;
    }

}
