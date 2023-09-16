from typing import Any


def q_2(n: int, x: Any) -> Any:
    if type(n) != int or n < 1 or x == 0:
        return 'Does not satisfied the pre-condition'
    elif n == 1:
        c_1 = x + 1 / x
        return c_1
    elif n == 2:
        c_2 = x * x + (1 / x) * (1 / x)
        return c_2
    else:
        c_1 = x + 1 / x
        c_minus1 = q_2(n-1, x)
        c_minus2 = q_2(n-2, x)
        c_n = c_1 * c_minus1 - c_minus2
        return c_n


if __name__ == '__main__':
    test_n = 5
    test_x = 5
    print(pow(test_x, test_n) + pow((1 / test_x), test_n))
    print(q_2(test_n, test_x))
