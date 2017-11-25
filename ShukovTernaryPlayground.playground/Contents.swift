//: Playground - noun: a place where people can play

import UIKit

precedencegroup ShukovTernaryPrecendenceGroup {
    associativity: right
    lowerThan: AssignmentPrecedence
}
infix operator ??? : ShukovTernaryPrecendenceGroup
@discardableResult func ???<T>(left: Any?, right: @autoclosure () throws -> T) rethrows -> T? {
    guard let left = left else { return nil }
    
    switch left {
    case let left as Bool: return left ? try right() : nil
    default: return try right() // Left is not nil, right will be called
    }
}

func testFunction1() {
    print("Function 1")
}

func testFunction2() {
    print("Function 2")
}

let b = Int(arc4random_uniform(100))
let c = 30

b > c ? testFunction1() : testFunction2() // nice but you have to provide a default value that sometimes you dont need which in this case is testFunction2()

if b > c {
    testFunction1()
}
b > c ??? testFunction1() // here is the same 'if' statement from above in one line

// WARNING: in the next statement variable 'd' can be nil
let d: Int? = b > c ??? 10 // you can also use this ternary for assigments, same as let d: Int? = b > c ? 10 : nil
d ??? testFunction2() // same as d != nil ??? testFunction2()

var f: Int = 0
d ??? f = 5
f
