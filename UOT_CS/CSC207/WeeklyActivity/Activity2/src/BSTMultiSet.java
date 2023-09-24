public class BSTMultiSet<T extends Comparable<T>> implements MultiSet<T>{
    // TODO Task 1: hover the red squiggly on the first line and select 'Implement methods'.
    //              All listed methods should be selected. Press okay and then implement each
    //              method. As with the python version, this shouldn't require a lot of code to write.
    //              Hint: autocomplete will help as you look for the right bst methods to call.

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
