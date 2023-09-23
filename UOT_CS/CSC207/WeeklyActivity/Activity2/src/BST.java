/**
 * A minimal implementation of a binary search tree. See the python version for
 * additional documentation.
 *
 * You can also see Chapter 6 of <a href="https://www.teach.cs.toronto.edu/~csc148h/winter/notes/">CSC148 Course Notes</a>
 * if you want a refresher on BSTs, but it is required to complete this assignment.
 * @param <T>
 */
public class BST<T extends Comparable<T>> {
    //Note: the extends Comparable<T> above means we require T to implement the Comparable<T> interface,
    //      since a BST requires that we can compare its elements to determine the ordering.
    private T root;

    private BST<T> left;
    private BST<T> right;

    public BST(T root) {
        if (root != null) { // check to ensure we don't accidentally try to store null at the root!
            this.root = root;
            this.left = new BST<>();
            this.right = new BST<>();
        }
        // Note: each of the attributes will default to null
    }

    /**
     * Alternate constructor, so we don't have to explicitly pass in null.
     */
    public BST() {
        this(null);
    }


    // TODO Task 2: Implement the BST methods.

    public boolean isEmpty() {
        // TODO implement me!
        return false;
    }

    public boolean contains(T item) {
        // provided
        if (this.isEmpty()) {
            return false;
        } else if (item.equals(this.root)) { // we need to use .equals and not == to properly compare values
            return true;
        } else if (item.compareTo(this.root) < 0) {
            return this.left.contains(item);
        }
        return this.right.contains(item);

    }


    public void insert(T item) {
        // TODO implement me!
    }


    public void delete(T item) {
        // TODO implement me!
    }

    private void deleteRoot() {
        // TODO implement me!
    }


    private T extractMax() {
        // TODO implement me!
        return this.root; // dummy code; replace with correct code when you implement this.
    }

    public int height() {
        // TODO implement me!
        return 0;
    }

    public int count(T item) {
        // TODO implement me!
        return 0;
    }

    public int getLength() {
        // TODO implement me!
        return 0;
    }

    public static void main(String[] args) {
        // TODO you can write any code you want here and run this file to confirm that
        //      your code is working as it should. We will not run this when testing your code.
    }

}
