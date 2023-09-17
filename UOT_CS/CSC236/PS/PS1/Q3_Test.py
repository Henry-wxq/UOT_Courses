import math


def q3_a_func(n: int) -> int:
    """Implement a Python function that takes a positive natural number n and returns a_n.

    Precondition: n is a positive natural number
    """
    if n == 1:
        # From the definition of a_n, when n is 1, return a_n equals to 1.
        return 1
    else:
        """ This is the recursion. Aim at returning the recursive value of a_n after reaching the base case when 
        a_n equals to 1.
        """
        return q3_a_func(math.floor(math.sqrt(n))) * q3_a_func(math.floor(math.sqrt(n))) \
            + 2 * q3_a_func(math.floor(math.sqrt(n)))


def q3_b_func(n: int) -> int:
    """Implement a Python function that takes a positive natural number n and raises an exception if n is 1, otherwise
    it returns a_n.

    Precondition: n is a positive natural number
    """
    if n == 1:
        # By question requirement, when n is 1, raises an Exception.
        raise Exception("Sorry, n must be greater than 1")
    elif n == 2 or n == 3:
        """Since when n equals to 2 or n equals to 3, the floor of square root of n is 1, and, in this function, we 
        don't have the value of a_n when n equals 1. Thus, we need to manually add the value of a_n when n equals to 2
        and n equals to 3 to prevent the error when calling the recursive.
        """
        return 3
    else:
        """This is the recursion. Aim at returning the recursive value of a_n after reaching the case when a_n equals
        to 2 or a_n equals to 3.
        """
        return q3_b_func(math.floor(math.sqrt(n))) * q3_b_func(math.floor(math.sqrt(n))) \
            + 2 * q3_b_func(math.floor(math.sqrt(n)))
