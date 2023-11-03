"""
Answer for PS4 Q3
"""

# Precondition: v is comparable with the elements of A;
#       A is a 2D array with each row and each column sorted.
# Postcondition: returns True if A contains v; False otherwise
def IsIn(v, A) -> bool:
    """
    Precondition: v is comparable with the elements of A
    Postcondition: returns True if A contains v; False otherwise

    :param v: v is comparable with the elements of A
    :param A: A is a 2D array with each row and each column sorted
    :return: returns True if A contains v; False otherwise
    """
    # Precondition: 0 <= r0 <= r1 <= len(A); 0 <= c0 <= c1 <= len(A[0])
    # Postcondition: returns True if A[r0:r1][c0:c1] contains v; False otherwise
    def helper(r0, r1, c0, c1) -> bool:
        """
        Precondition: 0 <= r0 <= r1 <= len(A); 0 <= c0 <= c1 <= len(A[0])
        Postcondition: returns True if A[r0:r1][c0:c1] contains v; False otherwise

        :param r0: 0 <= r0 <= r1 <= len(A)
        :param r1: 0 <= r0 <= r1 <= len(A)
        :param c0: 0 <= c0 <= c1 <= len(A[0])
        :param c1: 0 <= c0 <= c1 <= len(A[0])
        :return: returns True if A[r0:r1][c0:c1] contains v; False otherwise
        """
        if r0 == r1 or c0 == c1:
            return False

        r_mid, c_mid = (r0 + r1) // 2, (c0 + c1) // 2

        if v == A[r_mid][c_mid]:
            return True
        elif v < A[r_mid][c_mid]:
            value1 = helper(r0, r1, c0, c_mid)
            value2 = helper(r0, r_mid, c_mid, c1)
            return value1 or value2
        elif v > A[r_mid][c_mid]:
            value1 = helper(r0, r1, c_mid + 1, c1)
            value2 = helper(r_mid + 1, r1, c0, c_mid + 1)
            return value1 or value2
        return False

    return helper(0, len(A), 0, len(A[0]))

