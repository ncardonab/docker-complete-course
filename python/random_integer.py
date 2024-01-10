import random as rnd

upper_bound_integer = int(input("Enter the upper bound number: "))
lower_bound_integer = int(input("Enter the lower bound number: "))

if upper_bound_integer < lower_bound_integer:
    print("Invalid input")
else:
    print(rnd.randint(lower_bound_integer, upper_bound_integer))