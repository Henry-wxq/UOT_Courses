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


    public boolean isEmpty() {
        return root == null;
    }

    public boolean contains(T item) {
        // provided
        if (isEmpty()) {
            return false;
        } else if (item.equals(root)) { // we need to use .equals and not == to properly compare values
            return true;
        } else if (item.compareTo(root) < 0) {
            return left.contains(item);
        }
        return right.contains(item);

    }


    public void insert(T item) {
        if (isEmpty()) {
            root = item;
            left = new BST<>();
            right = new BST<>();
        } else if (item.compareTo(root) <= 0) {
            left.insert(item);
        } else {
            right.insert(item);
        }
    }


    public void delete(T item) {
        if (this.isEmpty()) {}
        else if (item.equals(root)) {
            deleteRoot();
        } else if (item.compareTo(root) <= 0) {
            left.delete(item);
        } else {
            right.delete(item);
        }
    }

    private void deleteRoot() {
        if (left.isEmpty() && left.isEmpty()) {
            root = null;
            left = null;
            right = null;
        } else if (left.isEmpty()) {
            root = right.root;
            left = right.left;
            right = right.right;
        } else {
            root = left.extractMax();
        }
    }


    private T extractMax() {
        if (right.isEmpty()) {
            T max_item = root;
            root = left.root;
            right = left.right;
            left = left.left;
            return max_item;
        } else {
            return right.extractMax();
        }
    }

    public int height() {
        if (isEmpty()) {
            return 0;
        } else {
            return Math.max(left.height(), right.height()) + 1;
        }
    }

    public int count(T item) {
        if (isEmpty()) {
            return 0;
        } else if (item.compareTo(root) < 0) {
                return left.count(item);
        } else if (item.compareTo(root) == 0) {
            return 1 + left.count(item) + right.count(item);
        }
        return right.count(item);
    }


    public int getLength() {
        if (isEmpty()){
            return 0;
        }
        return 1 + left.getLength() + right.getLength();
    }

    public static void main(String[] args) {
        // Create a new BST with an initial root node
        BST<Integer> bst = new BST<>(5);

        // Insert some elements into the BST
        bst.insert(3);
        bst.insert(7);
        bst.insert(2);
        bst.insert(4);
        bst.insert(6);
        bst.insert(8);

        // Test various BST operations
        System.out.println("Contains 4: " + bst.contains(4)); // Should print true
        System.out.println("Contains 9: " + bst.contains(9)); // Should print false

        System.out.println("BST height: " + bst.height()); // Should print the height of the tree

        System.out.println("Count of 5: " + bst.count(5)); // Should print 1
        System.out.println("Count of 7: " + bst.count(7)); // Should print 1
        System.out.println("Count of 9: " + bst.count(9)); // Should print 0

        System.out.println("BST Length: " + bst.getLength()); // Should print the number of nodes in the tree
    }

}
