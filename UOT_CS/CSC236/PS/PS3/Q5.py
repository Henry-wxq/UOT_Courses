"""
Solving Question 5(b)
"""


def T(f):
    """
    Writing a recursive Python function to compute T

    :param f:
    :return:
    """
    # Considering for x_i
    if type(f) is str:
        return f

    # Considering for (p, "and", q) or (p, "or", q)
    if len(f) == 3:
        (p, op, q) = f
        # Since we recursively call T on p and q individually, and the number of operators that f has is one more than
        # the number of operators that p and q have together. Thus, I've made each recursive has fewer than before
        return (T(p), op, T(q))

    # Considering ("not", y)
    else:
        (_, y) = f
        # ("not", ("not", p))
        if len(y) == 2:
            (_, p) = y
            # I will recursively call T on p and p has two fewer operators than f now
            return T(p)

        # Considering ("not", (p, "and", q)) or ("not", (p, "or", q))
        if len(y) == 3:
            (p, op, q) = y
            # I will split the cases into "and" or "or"
            if op == "and":
                # I will recursively call T. Since p and q is separate from the "and" and op, p and q have at least two
                # fewer operators than f. Thus, ("not", p) and ("not", q) have at least one less operator than f has.
                return (T(("not", p)), "or", T(("not", q)))
            # op == "or"
            else:
                return (T(("not", p)), "and", T(("not", q)))
        else:
            return f
