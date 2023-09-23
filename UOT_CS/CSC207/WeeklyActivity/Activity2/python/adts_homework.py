"""
MultiSet ADT

This is a smaller version of what you saw in lab this week, with
a different BinarySearchTree structure used for the underlying implementation.

Note: you can open this project in PyCharm or your favourite IDE if you want
to try running it.

The output should look something like the below (timing will vary of course):

  500        <class '__main__.BSTMultiSet'>  0.001481
 1000        <class '__main__.BSTMultiSet'>  0.003086
 2000        <class '__main__.BSTMultiSet'>  0.007097
 4000        <class '__main__.BSTMultiSet'>  0.013924


You might also find it helpful to 'Split Right' or 'Split Down' in the editor by
right-clicking the tab above with this file's name on it, to allow you to look
at the python code as you write your corresponding Java code.
"""
from __future__ import annotations

import random
import time
from typing import Any, Optional


class MultiSet:
    """
    An abstract class representing the MultiSet ADT, which supports the
    add, remove, is_empty, count, and contains operations.

    This class itself does not handle how the underlying data is stored,
    so it just inherits Object.__init__.

    This will naturally turn into an Interface when we translate it into
    a Java implementation.
    """

    def add(self, item: Any) -> bool:
        raise NotImplementedError

    def remove(self, item: Any) -> None:
        raise NotImplementedError

    def contains(self, item: Any) -> bool:
        raise NotImplementedError

    def is_empty(self) -> bool:
        raise NotImplementedError

    def count(self, item: Any) -> int:
        raise NotImplementedError

    def size(self) -> int:
        raise NotImplementedError


class BST:
    """Binary Search Tree class.

    This class represents a binary tree satisfying the Binary Search Tree
    property: for every item, its value is >= all items stored in its left
    subtree, and <= all items stored in its right subtree.

    Note: items that are equal to the root may appear in either subtree.
    """
    # === Private Attributes ===
    # The item stored at the root of the tree, or None if the tree is empty.
    _root: Optional[Any]
    # The left subtree, or None if the tree is empty.
    _left: Optional[BST]
    # The right subtree, or None if the tree is empty.
    _right: Optional[BST]

    # === Representation Invariants ===
    #  - If self._root is None, then so are self._left and self._right.
    #    This represents an empty BST.
    #  - If self._root is not None, then self._left and self._right
    #    are BinarySearchTrees.
    #  - (BST Property) If self is not empty, then
    #    all items in self._left are <= self._root, and
    #    all items in self._right are >= self._root.

    def __init__(self, root: Optional[Any]) -> None:
        """Initialize a new BST containing only the given root value.

        If <root> is None, initialize an empty tree.
        """
        if root is None:
            self._root = None
            self._left = None
            self._right = None
        else:
            self._root = root
            self._left = BST(None)
            self._right = BST(None)

    def is_empty(self) -> bool:
        """Return whether this BST is empty.
        """
        return self._root is None

    def __contains__(self, item: Any) -> bool:
        """Return whether <item> is in this BST.
        """
        if self.is_empty():
            return False
        elif item == self._root:
            return True
        elif item < self._root:
            return item in self._left
        else:
            return item in self._right

    def insert(self, item: Any) -> None:
        """Insert <item> into this tree.
        """
        if self.is_empty():
            # Make new leaf.
            # Note that self._left and self._right cannot be None when the
            # tree is non-empty! (This is one of our invariants.)
            self._root = item
            self._left = BST(None)
            self._right = BST(None)
        elif item <= self._root:
            self._left.insert(item)
        else:
            self._right.insert(item)

    def delete(self, item: Any) -> None:
        """Remove *one* occurrence of <item> from this BST.

        Do nothing if <item> is not in the BST.
        """
        if self.is_empty():
            pass
        elif self._root == item:
            self.delete_root()
        elif item < self._root:
            self._left.delete(item)
        else:
            self._right.delete(item)

    def delete_root(self) -> None:
        """Remove the root of this tree.

        Precondition: this tree is *non-empty*.
        """
        if self._left.is_empty() and self._right.is_empty():
            self._root = None
            self._left = None
            self._right = None
        elif self._left.is_empty():
            # "Promote" the right subtree.
            # Note that self = self._right does NOT work!
            self._root, self._left, self._right = \
                self._right._root, self._right._left, self._right._right
        elif self._right.is_empty():
            # "Promote" the left subtree.
            self._root, self._left, self._right = \
                self._left._root, self._left._left, self._left._right
        else:
            # Both subtrees are non-empty. Can shooe to replace the root
            # from either the max value of the left subtree, or the min value
            # of the right subtree. (Implementations are very similar.)
            self._root = self._left._extract_max()

    def _extract_max(self) -> Any:
        """Remove and return the maximum item stored in this tree.

        Precondition: this tree is *non-empty*.
        """
        if self._right.is_empty():
            max_item = self._root
            # "Promote" the left subtree.
            # Alternate approach: call self.delete_root()!
            self._root, self._left, self._right = \
                self._left._root, self._left._left, self._left._right
            return max_item
        else:
            return self._right._extract_max()

    def height(self) -> int:
        """Return the height of this BST.
        """
        if self.is_empty():
            return 0
        else:
            return max(self._left.height(), self._right.height()) + 1

    def count(self, item: Any) -> int:
        """Return the number of occurrences of <item> in this BST.
        """
        if self.is_empty():
            return 0
        elif self._root > item:
            return self._left.count(item)
        elif self._root == item:
            return 1 + self._left.count(item) + self._right.count(item)
        else:
            return self._right.count(item)

    def __len__(self) -> int:
        """Return the number of items in this BST.
        """
        if self.is_empty():
            return 0
        return 1 + len(self._left) + len(self._right)


class BSTMultiSet(MultiSet):
    """
    This class uses an underlying Tree to implement our MultiSet ADT.
    """

    _tree: BST

    def __init__(self):
        self._tree = BST(None)

    def add(self, item: Any) -> bool:
        self._tree.insert(item)
        return True  # always returns True!

    def remove(self, item: Any) -> None:
        self._tree.delete(item)

    def contains(self, item: Any) -> bool:
        return item in self._tree

    def is_empty(self) -> bool:
        return self._tree.is_empty()

    def count(self, item: Any) -> int:
        return self._tree.count(item)

    def size(self) -> int:
        return len(self._tree)


def profileMultiSet(my_input: MultiSet, n: int) -> None:
    """
    Run the timing experiment for the given <my_input> MultiSet implementation,
    for a problem size of <n>.
    """
    # add n random items, then remove them all; we will only time the removal
    # step.
    items_added = []
    for i in range(n):
        x = random.randint(0, 100)
        my_input.add(x)
        items_added.append(x)

    # sanity check that we added n items
    assert my_input.size() == n

    start = time.time()

    for x in items_added:
        my_input.remove(x)

    end = time.time()

    # sanity check that we successfully removed all the items we had added!
    assert my_input.is_empty()

    # just print a quick summary of what we just ran
    print(f'{n}'.rjust(5), f'{my_input.__class__}'.rjust(37),
          f'{end - start : .6f}')



if __name__ == '__main__':
    # perform a little timing experiment
    multisets = [BSTMultiSet()]
    for multiset in multisets:
        for n in [500, 1000, 2000, 4000]:
            profileMultiSet(multiset, n)
