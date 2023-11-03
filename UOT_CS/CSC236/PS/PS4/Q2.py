"""
Answer for PS4 Q2
"""

# (a)
# Precondition: x is in R, y is in N
# Postcondition: return x to the power of y(return 1 if x = y = 0)
def Pow1(x, y) -> float:
    """
    Precondition: x is in R, y is in N
    Postcondition: return x to the power of y(return 1 if x = y = 0)

    :param x: x is in R, which is a real number
    :param y: y is in N, which is a natural number
    :return: x to the power of y
    """
    # Precondition: xi is in R, yi is in N, zi is in R
    # Postcondition: return x to the power of y(return 1 if x = y = 0)
    def r(xi, yi, zi) -> float:
        """
        Precondition: xi is in R, yi is in N, zi is in R, zi times xi to the yi equals x to the power of y
        Postcondition: return x to the power of y(return 1 if x = y = 0)
        Initial Arguments: xi = x, yi = y, zi = 1

        :param xi: xi is in R, which is a real number
        :param yi: yi is in N, which is a natural number
        :param zi: xi is in R, which is a real number
        :return: return x to the power of y
        """
        if yi == 0:
            return zi
        if yi % 2 == 1:
            zi *= xi
        return r(xi*xi, yi//2, zi)
    return r(x, y, 1)


# (b)
# Precondition: x is in R, y is in N
# Postcondition: return x to the power of y (return 1 if x = y = 0)
def Pow2(x, y) -> float:
    """
    Precondition: x is in R, y is in N
    Postcondition: return x to the power of y (return 1 if x = y = 0)

    :param x: x is in R, which is a real number
    :param y: y is in N, which is a natural number
    :return: x to the power of y (return 1 if x = y = 0)
    """
    xi, yi, zi = x, y, 1
    return r(xi, yi, zi)

# Precondition: xi is in R, yi is in N, zi is in R
# Postcondition: return zi time xi to the power of yi
def r(xi, yi, zi) -> float:
    """
    Precondition: xi is in R, yi is in N, zi is in R
    Postcondition: return zi time xi to the power of yi

    :param xi: xi is in R, which is a real number
    :param yi: yi is in N, which is a natural number
    :param zi: zi is in R, which is a real number
    :return: zi times xi to the power of yi
    """
    if yi == 0:
        return zi
    if yi % 2 == 1:
        zi *= xi
    return r(xi * xi, yi // 2, zi)


# (c)
# Precondition: x is in R, y is in N
# Postcondition: return x to the power of y (return 1 if x = y = 0)
def PowR(x, y) -> float:
    """
    Precondition: x is in R, y is in N
    Postcondition: return x to the power of y (return 1 if x = y = 0)

    :param x: x is in R, which is a real number
    :param y: y is in N, which is a natural number
    :return: x to the power of y (return 1 if x = y = 0)
    """
    if y == 0:
        return 1
    if y % 2 == 0:
        return PowR(x*x, y//2)
    else:
        return x * PowR(x*x, y//2)
