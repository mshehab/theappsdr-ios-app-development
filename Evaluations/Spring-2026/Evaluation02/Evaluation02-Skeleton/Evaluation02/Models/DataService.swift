//
//  DataService.swift
//  Evaluation02
//
//  Created by Mohamed Shehab on 3/4/26.
//

import Foundation

class Employee {
    let name: String
    let department: String
    let purchases: [Purchase]
    
    init(name: String, department: String, purchases: [Purchase]) {
        self.name = name
        self.department = department
        self.purchases = purchases
    }
}

class Purchase {
    let purchaseDate: Date
    let items : [Item]
    init(purchaseDate: Date, items: [Item]) {
        self.purchaseDate = purchaseDate
        self.items = items
    }
}

class Item {
    let itemName: String
    let price: Double
    let quantity: Int
    init(itemName: String, price: Double, quantity: Int) {
        self.itemName = itemName
        self.price = price
        self.quantity = quantity
    }
}

final class DataService {
    static var instance : DataService?
    var employees = [Employee]()
    
    init() {
        loadData()
    }
    
    public static func getInstance() -> DataService {
        if instance == nil {
            instance = DataService()
        }
        return instance!
    }
    
    private func loadData() {
        // Fixed prices per item for consistency
        let randomSeed: UInt64 = 12345
        let employeeNames: [String] = [
            "Alice Johnson", "Bob Smith", "Charlie Evans", "Diana Lee", "Ethan Davis",
            "Fiona Clark", "George Baker", "Hannah Scott", "Ian Wright", "Jenna Hall",
            "Kyle Adams", "Laura Turner", "Mike Nelson", "Nora Perez", "Oscar Hughes",
            "Paula Ramirez", "Quinn Foster", "Rita Cooper", "Sam Green", "Tina Brooks",
            "Uma Patel", "Victor Ward", "Wendy Cox", "Xander Reed", "Yara Sullivan", "Liam Carter",
            "Olivia Bennett", "Noah Mitchell", "Emma Richardson", "Ethan Parker", "Ava Thompson",
            "Mason Hughes", "Sophia Coleman", "Logan Foster", "Isabella Griffin", "Abigail Long",
            "Lucas Hayes", "Mia Simmons", "Benjamin Ward", "Charlotte Price", "Elijah Brooks", "Amelia Sanders",
            "James Powell", "Harper Bryant", "Alexander Butler", "Evelyn Fisher", "Daniel Henderson",
            "Matthew Patterson", "Emily Coleman", "Henry Russell", "Scarlett Griffin", "Jackson Myers",
            "Victoria Simmons", "Sebastian Cooper", "Madison Barnes", "Jack Jenkins", "Luna Ross",
            "Owen Perry", "Chloe Hayes", "Samuel Butler", "Grace Bennett", "David Hughes", "Lily Patterson",
            "Joseph Carter", "Zoe Richardson", "William Ward", "Hannah Cooper", "Michael Brooks",
            "Natalie Sanders", "Gabriel Foster", "Layla Russell", "Caleb Parker", "Aria Thompson",
            "Nathan Griffin", "Ella Myers"
        ]
        
        let departments: [String] = ["IT", "Finance", "HR", "Marketing", "Sales", "Operations", "Engineering", "Customer Support", "Legal"]
        var rng = SeededGenerator(seed: randomSeed)
        employees.removeAll()
        employees.reserveCapacity(employeeNames.count)
        
        for name in employeeNames {
            let department = departments.randomElement(using: &rng) ?? "IT"
            let purchases = generatePurchases(using: &rng)
            employees.append(Employee(name: name, department: department, purchases: purchases))
        }
    }
    
    private func generatePurchases(using rng: inout SeededGenerator) -> [Purchase] {
        var purchases: [Purchase] = []
        let numberOfPurchases = Int.random(in: 2...4, using: &rng) // 2–4 purchases per employee
        purchases.reserveCapacity(numberOfPurchases)
        
        for _ in 0..<numberOfPurchases {
            let purchaseDate = randomDate(using: &rng)
            let items = generateItems(using: &rng)
            purchases.append(Purchase(purchaseDate: purchaseDate, items: items))
        }
        
        return purchases
    }
    
    private func generateItems(using rng: inout SeededGenerator) -> [Item] {
        let itemCatalog: [String: Double] = [
        "Laptop": 899.99,
        "Monitor": 249.99,
        "Keyboard": 49.99,
        "Mouse": 29.99,
        "Desk Chair": 159.99,
        "Printer": 199.99,
        "USB Drive": 19.99,
        "Headphones": 89.99,
        "Notebook": 7.99,
        "Pen Set": 12.49,
        "Coffee Mug": 14.99,
        "Phone Charger": 24.99,
        "Backpack": 59.99,
        "Tablet": 499.99,
        "Desk Lamp": 39.99,
        "Webcam": 79.99,
        "External Hard Drive": 129.99,
        "Wireless Router": 99.99,
        "Office Desk": 299.99,
        "Graphic Tablet": 219.99,
        "Surge Protector": 22.99,
        "Bluetooth Speaker": 69.99,
        "Smartphone Stand": 15.99,
        "Ethernet Cable": 9.99,
        "Whiteboard": 89.99
    ]
        var items: [Item] = []
        let itemNames = Array(itemCatalog.keys)
        let itemCount = Int.random(in: 1...9, using: &rng) // 1–9 attempts
        
        var selectedItems = Set<String>()
        items.reserveCapacity(itemCount)
        
        for _ in 0..<itemCount {
            guard let itemName = itemNames.randomElement(using: &rng) else { continue }
            if !selectedItems.contains(itemName) {
                selectedItems.insert(itemName)
                let price = itemCatalog[itemName] ?? 0.0
                let quantity = Int.random(in: 1...5, using: &rng)
                items.append(Item(itemName: itemName, price: price, quantity: quantity))
            }
        }
        
        return items
    }
    
    private func randomDate(using rng: inout SeededGenerator) -> Date {
        let daysAgo = Int.random(in: 0..<365, using: &rng) // within last year
        return Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) ?? Date()
    }
   
    struct SeededGenerator: RandomNumberGenerator {
        private var state: UInt64
        init(seed: UInt64) { self.state = seed }
        
        mutating func next() -> UInt64 {
            state = 6364136223846793005 &* state &+ 1
            return state
        }
    }
}
