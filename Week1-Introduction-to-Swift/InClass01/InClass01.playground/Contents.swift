import UIKit

print("Hello, In Class 01")

//Welcome to In Class 01


//Question 1: Printing Variables
// Create a variable that holds your name
// Print the "Hello " concatenated with the variable that you just created.

//Question 2a: Loop over the provided array of names and print them
let names = ["Zoe", "Olive","Petra","Salvatore","Tommie","Nora","Cesar","Madelene","Dillon","Nikia"]


//Question 2b: Loop over the provided array of names and print the names in upper case


//Question 2c: Loop over the provided array of names and print only the names that start with O, M or N

//Question 3: loop over the numbers from 1 to 20 and prints the numbers.
//But for multiples of three print “Fizz” instead of the number and for the multiples of five print “Buzz”.
//For numbers which are multiples of both three and five print “FizzBuzz”

//Question 4: Write a function that accepts a number and returns true if the number is even and false otherwise


//Question 5: Write a function that accepts an array of numbers and returns the mininmum number in the array


//Question 6a: Create a User class that has name, age and gender as attributes.
//Create a simple initializer that receives the name, age, gender, and state values and initializes the attributes in the User object.
//Create a method that prints the User object attributes, you can also take a look at the following Protocol
// https://developer.apple.com/documentation/swift/string/2427941-init
//Create an example user that has name as "Bob Smith", age is 25, gener is Male, and state is NC print this user using the method you created.




//Question 6b: You are provided with the usersData array, that has the user information formatted as a string comma separatated.
//Write a function that receives the userData array as input and returns an array of User objects based on the parsed users data.
//If the age is not a number or invalid then set it to the default of 28
//Print the array returned by your function to show the each user parsed.
let usersData =   ["Lola Grimsdyke,89,Female,NC",
                   "Sybilla Martinetto,84,Female,NC",
                   "Casi Roizn,78,Female,IL",
                   "Wilma Guilaem,84,Female,CA",
                   "Woodman Brooke,test,Male,MI",
                   "Roberta Allkins,46,Female,NY",
                   "Tommi Severs,31,Female,NC",
                   "Clayson Lantiff,77,Male,NC",
                   "Aleta Mirams,94,Female,NC",
                   "Galina Roskelly,28,Female,MI",
                   "Eunice Oldam,92,Female,CA",
                   "Dominica Took,71,Female,CA",
                   "Sashenka Serle,68,Female,CA",
                   "Arvy Jenckes,39,Male,IL"];




//Question 6c: Using the user array generated, in question 6b, write a function that recieves the list of users generated, and the gender string and
//returns the average age for the provided gender.





//Question 6d: Using the user array generated, in question 6b, write a function that recieves the list of users generated and
//returns a dictionary containing the state as the key and the count of users in that state as the value



//Question 6e: Using the user array generated, in question 6b, sort the usersData array in ascending order of ages
// a hint can be found at https://www.hackingwithswift.com/example-code/arrays/how-to-sort-an-array-using-sort




//Question 7: You are provided with two lists of words, namely listA and listB. Write a function that receives both lists as parameters and returns the set of words that overlap in both lists, this is the intersection of both lists. Hint: it is a good idea to use Sets.
let listA = ["bathroom","wealth","failure","tradition","art","soup","message","education","health","thanks","communication","device","imagination","chest","definition","marriage","tea","performance","theory","wood","environment","establishment","measurement","industry","people","moment","recording","opportunity","area","contract","advertising","thing","dirt","college","video","engineering","exam","shopping","emotion","activity"]

let listB = ["passion","gate","relationship","obligation","art","idea","imagination","estate","debt","manager","computer","affair","weakness","college","revolution","quality","thanks","performance","replacement","economics","reception","penalty","passion","sector","currency","goal","effort","insurance","speech","inflation","science","difficulty","football","college","accident","engine","relation","conversation","poet","television"]
