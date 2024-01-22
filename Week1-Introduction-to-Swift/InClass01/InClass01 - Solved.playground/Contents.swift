import UIKit

print("Hello, In Class 01")

//Welcome to In Class 01


//Question 1: Printing Variables
// Create a variable that holds your name
// Print the "Hello " concatenated with the variable that you just created.
let myName = "Mohamed Shehab"
print("Hello " + myName)

print("#################")

//Question 2a: Loop over the provided array of names and print them
let names = ["Zoe", "Olive","Petra","Salvatore","Tommie","Nora","Cesar","Madelene","Dillon","Nikia"]

for name in names {
    print(name)
}

print("#################")

//Question 2b: Loop over the provided array of names and print the names in upper case
for name in names {
    print(name.uppercased())
}

print("#################")

//Question 2c: Loop over the provided array of names and print only the names that start with O, M or N
for name in names {
    let firstCharacter = name.prefix(1)
    if firstCharacter == "O" || firstCharacter == "M" || firstCharacter == "N" {
        print(name)
    }
}

print("#################")
//Question 3: loop over the numbers from 1 to 20 and prints the numbers.
//But for multiples of three print “Fizz” instead of the number and for the multiples of five print “Buzz”.
//For numbers which are multiples of both three and five print “FizzBuzz”
for i in 1...20{
    if i % 3 == 0 && i % 5 == 0 {
        print("\(i) FizzBuzz")
    } else if i % 3 == 0 {
        print("\(i) Fizz")
    } else if i % 5 == 0 {
        print("\(i) Buzz")
    } else {
        print("\(i)")
    }
}

print("#################")
//Question 4: Write a function that accepts a number and returns true if the number is even and false otherwise

func isEven(num: Int) -> Bool {
    return num % 2 == 0
}

print("2 is even : \(isEven(num: 2))")
print("3 is even : \(isEven(num: 3))")



print("#################")
//Question 5: Write a function that accepts an array of numbers and returns the mininmum number in the array

func getMin(array:[Int]) -> Int? {
    if array.isEmpty {
        return nil
    }
    
    var min = array.first!

    for num in array {
        if num < min {
            min = num
        }
    }
    
    return min
}

print("Min is \(getMin(array: [Int]()))")

print("Min is \(getMin(array: [1,2,3,7,4,-1,-100,3,2]))")

print("################# \n\n")

//Question 6a: Create a User class that has name, age and gender as attributes.
//Create a simple initializer that receives the name, age, gender, and state values and initializes the attributes in the User object.
//Create a method that prints the User object attributes, you can also take a look at the following Protocol
// https://developer.apple.com/documentation/swift/string/2427941-init
//Create an example user that has name as "Bob Smith", age is 25, gener is Male, and state is NC print this user using the method you created.

class User : CustomStringConvertible {
    var name: String
    var age: Int
    var gender: String
    var state: String
    
    var description: String {
        return "User(name: \(self.name), age:\(self.age), gender: \(self.gender), state: \(self.state))"
    }
    
    init(name: String, age: Int, gender: String, state: String) {
        self.name = name
        self.age = age
        self.gender = gender
        self.state = state
    }
    
    init(line: String){
        let items = line.split(separator: ",")
        
        self.name = String(items[0])
        
        let num = Int(items[1])
        if num != nil {
            self.age = num!
        } else {
            self.age = 28
            print("Invalid number ")
        }
        
        self.gender = String(items[2])
        self.state = String(items[3])
    }
    
}
let user1 = User(name: "Bob", age: 20, gender: "Male", state: "NC")
print(user1)

print("################# \n\n\n\n\n")


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


func getUsers(data: [String]) -> [User] {
    var users = [User]()
    for line in data {
        let user = User(line: line)
        users.append(user)
    }
    return users
}

let users = getUsers(data: usersData)



//Question 6c: Using the user array generated, in question 6b, write a function that recieves the list of users generated, and the gender string and
//returns the average age for the provided gender.

func getAverageOf(users: [User], byGender: String) -> Double {
    var sum: Double = 0.0
    var count: Double = 0.0
    
    for user in users {
        if user.gender == byGender {
            sum = sum + Double(user.age)
            count = count + 1
        }
    }
    
    if count > 0 {
        return sum / count
        
    } else {
        return 0
    }
}

print(getAverageOf(users: users, byGender: "Male"))
print(getAverageOf(users: users, byGender: "Female"))

print("################# \n\n\n\n\n")



//Question 6d: Using the user array generated, in question 6b, write a function that recieves the list of users generated and
//returns a dictionary containing the state as the key and the count of users in that state as the value

func getStateCountMap(users: [User]) -> [String:Int] {
    var map = [String:Int]()
    
    for user in users {
        let record = map[user.state]
        
        if record == nil {
            map[user.state] = 1
        } else {
            map[user.state] = record! + 1
        }
    }
    return map
}

let stats = getStateCountMap(users: users)




//Question 6e: Using the user array generated, in question 6b, sort the usersData array in ascending order of ages
// a hint can be found at https://www.hackingwithswift.com/example-code/arrays/how-to-sort-an-array-using-sort

var sortedUsers = [User]()
sortedUsers.append(contentsOf: users)


sortedUsers.sort { user1, user2 in
    return user1.age < user2.age
}

print(sortedUsers)




//Question 7: You are provided with two lists of words, namely listA and listB. Write a function that receives both lists as parameters and returns the set of words that overlap in both lists, this is the intersection of both lists. Hint: it is a good idea to use Sets.
let listA = ["bathroom","wealth","failure","tradition","art","soup","message","education","health","thanks","communication","device","imagination","chest","definition","marriage","tea","performance","theory","wood","environment","establishment","measurement","industry","people","moment","recording","opportunity","area","contract","advertising","thing","dirt","college","video","engineering","exam","shopping","emotion","activity"]

let listB = ["passion","gate","relationship","obligation","art","idea","imagination","estate","debt","manager","computer","affair","weakness","college","revolution","quality","thanks","performance","replacement","economics","reception","penalty","passion","sector","currency","goal","effort","insurance","speech","inflation","science","difficulty","football","college","accident","engine","relation","conversation","poet","television"]


func getOverlap(listA: [String], listB: [String]) -> Set<String>  {
    var setA = Set<String>()
    var resultSet = Set<String>()
    
    for item in listA {
        setA.insert(item)
    }
    
    for item in listB {
        if setA.contains(item){
            resultSet.insert(item)
        }
    }
    return resultSet
}

let overlap = getOverlap(listA: listA, listB: listB)

