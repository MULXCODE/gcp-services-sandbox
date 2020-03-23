import string
import random

def generate_random_char(length):
    """Generates a lower-cased random char of specified length

    Args:
        length of the random char
    Returns:
        lowercased string of specified length
    """
    lst = [random.choice(string.ascii_letters + string.digits)
           for n in range(length)]
    random_char = ''.join(lst)
    return random_char.lower()
