# methods and functions


#define a variable
y=3.14
print(type(y))

#uppercase method
print(txt.title())
print(txt.capitalize())

#boolean
if y == int:
    print("y is an integer")
else:
    print ("y is a float")

# format string
txt = f"aws restart daily limit price is {y} dollars"
print(txt)

# input function 
name = input("Enter your name: ")
print("Hello " + name) 

# input function is like a receptionist, asking you information to put in on a visitors tag, similar to the format
name = input("What is your name? ")
age = int(input("How old are you? "))

print("Hi " + name)
print("Next year you will be " + str(age + 1))

#range (needs number not character)
for i in range (5):
    print(i)

