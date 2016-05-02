//: Playground - noun: a place where people can play

import UIKit

// Example data structure

enum Majors : Int {
    case Science = 1, Engineering, Art
}

struct People : CustomStringConvertible {
    var name:String
    var age:Int
    var major:Majors
    
    init(newName:String, newAge:Int, newMajor:Majors)
    {
        name = newName
        age = newAge
        major = newMajor
    }
    
    init(inputArray:[String])
    {
        name = inputArray[0]
        age = Int(inputArray[1])!
        
        switch inputArray[2] {
        case "Science":
            major = .Science
        case "Engineering":
            major = .Engineering
        default:
            major = .Art
        }
    }
    
    func toArray() -> [String]
    {
        return [name, "\(age)", "\(major)"]
    }
    
    // Implement to support 'CustomStringConvertible'. Basically toString()
    var description: String {
        return "\(name) is \(age) years old and is in the school of \(major)"
    }
}


// Example code:

var me = People(newName: "Warren", newAge: 20, newMajor: .Engineering)

var storeMe = me.toArray()

var meAgain = People(inputArray: storeMe)
