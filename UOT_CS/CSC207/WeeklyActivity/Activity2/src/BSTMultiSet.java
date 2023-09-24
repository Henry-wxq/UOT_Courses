public class BSTMultiSet<T extends Comparable<T>> implements MultiSet<T>{
    // a multiset always starts empty, so we can directly instantiate our private attribute
    // here; no need to explicitly write a new constructor.
    private final BST<T> bst = new BST<>();

    @Override
    public void add(T item) {
        bst.insert(item);
    }

    @Override
    public void remove(T item) {
        bst.delete(item);
    }

    @Override
    public boolean contains(T item) {
        return bst.contains(item);
    }

    @Override
    public boolean isEmpty() {
        return bst.isEmpty();
    }

    @Override
    public int count(T item) {
        return bst.count(item);
    }

    @Override
    public int size() {
        return bst.getLength();
    }
}
