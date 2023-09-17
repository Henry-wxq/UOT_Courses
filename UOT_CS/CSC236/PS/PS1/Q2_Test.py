from typing import Any


def q_2(n: int, x: Any) -> Any:
    """Implement a Python function with parameters x and n that (ignoring floating-point issues) returns c_n.

    Precondition:
    1. x represents a non-zero real number.
    2. n is a natural number
    """
    # Since c_1 is used in both n = 1 and recursion, I will put it at the front.
    c_1 = x + 1 / x

    if n == 1:
        # From the definition of c_n, when n is 1, return the corresponding c_1
        return c_1
    elif n == 2:
        # From the definition of c_n, when n is 2, return the corresponding c_2
        c_2 = x * x + (1 / x) * (1 / x)
        return c_2
    else:
        """This is the recursion part. According to the discovery from hint which will be stated below, I come up with a
        general function for c_n.
        """
        # Aim at returning the recursive value of c for n minus 1 after reaching the case when n equals to 1.
        c_minus1 = q_2(n-1, x)
        # Aim at returning the recursive value of c for n minus 2. Since we don't know whether n is an even number or
        # an odd number, we need to add both n equals to 1 and n equals to 2 to our base case.
        c_minus2 = q_2(n-2, x)
        # Calculate the c_n based on the discovery.
        c_n = c_1 * c_minus1 - c_minus2
        return c_n


if __name__ == '__main__':
    test_n = 5
    test_x = 5
    print(pow(test_x, test_n) + pow((1 / test_x), test_n))
    print(q_2(test_n, test_x))
