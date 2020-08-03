"""Does pylint flag function redefinition?"""


def f():
    """Original definition of a function."""
    print('first f')


def f():
    """Redefinition of the function."""
    print('second f')
