public interface MultiSet<T> {

    /**
     * Add the given item to this multiset.
     * @param item
     */
    void add(T item);

    /**
     * Remove the given item from this multiset.
     * If the item isn't in the multiset, do nothing.
     * @param item
     */
    void remove(T item);

    /**
     * Check whether item is in this multiset.
     * @param item
     * @return True if item is in this multiset and False otherwise.
     */
    boolean contains(T item);

    /**
     * @return True if this multiset is empty.
     */
    boolean isEmpty();

    /**
     * Count how many times the given item appears in this multiset.
     * @param item
     * @return How many times item appears in this multiset.
     */
    int count(T item);


    /**
     * @return How many items are in this multiset.
     */
    int size();

}
