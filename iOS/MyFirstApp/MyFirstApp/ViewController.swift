//
//  ViewController.swift
//  MyFirstApp
//
//  Created by Kim Tae-Hwan on 2017. 12. 17..
//  Copyright © 2017년 Kim Tae-Hwan. All rights reserved.
//

import UIKit

protocol Messagable {
    var msg: String? { get }
    func send()
}

protocol Sendable: Messagable {
    var from: String? { get }
    var to: String { get }
}

extension String {
    var length: Int {
        return self.count
    }
    
    func reversed() -> String {
        var ret : String = ""
        self.forEach { word in ret = "\(word)\(ret)" }
        return ret
        //return self.reversed().map { String($0) } //.joined(separator: "")
    }
    
    // Mutating function
    mutating func reversing() {
        var ret : String = ""
        self.forEach { word in ret = "\(word)\(ret)" }
        self = ret
    }
}

class ViewController: UIViewController {
    func OptionalTest() {
        let variable: String = "variable@test.com"
        let variable_Opt: String? = "variable_Opt@test.com"   // Optional
        let variable_Opt_nil: String? = nil                   // Optional, nil
        //let variable_IUOpt: String! = nil                // ImplicitlyUnwrappedOptional, XXX: Not recommend
        let variable_Opt_empty: String? = ""                    // Optional, empty
        
        print("Optional Test -------------------------")
        // (0)
        print("(0) variable is " + variable)
        print("(0) variable_Opt is " + variable_Opt!) // Unwrapping not nil, Not recommend, use optional binding
        // print(variableOpt2!)                        // XXX: Runtime Error: Unwrapping nil
        // print("(0) variable_IUOpt is " + variable_IUOpt) // XXX: Runtime Error: nil (Unwrapped already)
        
        // (1) if let
        // Check if optional is nil (Without Optional Binding)
        if (variable_Opt != nil) {
            print("(1-1) variable_Opt is " + variable_Opt!)
        } else {
            print("(1-1) variable_Opt is nil")
        }
        // Optional Binding (1)
        if let temp = variable_Opt {
            print("(1-2) variable_Opt is " + temp)
        } else {
            print("(1-2) variable_Opt is nil")
        }
        if let temp = variable_Opt_nil {
            print("(1-2) variable_Opt_nil is " + temp)
        } else {
            print("(1-2) variable_Opt_nil is nil")
        }
        
        // (2) if let, isEmpty
        // Check if optional is nil and empty (Without Optional Binding)
        if (variable_Opt_empty != nil && (variable_Opt_empty!.isEmpty == false)) {
            print("(2-1) variable_Opt_empty is " + variable_Opt_empty!)
        } else {
            print("(2-1) variable_Opt_empty is nil or emptry")
        }
        // Optional Bindng
        if let temp = variable_Opt_empty, (variable_Opt_empty!.isEmpty == false) {
            print("(2-2) variable_Opt_empty is " + temp)
        } else {
            print("(2-2) variable_Opt_empty is nil or emptry")
        }
        // Optional Chaining
        if variable_Opt_empty?.isEmpty == false {
            print("(2-3) variable_Opt_empty is " + variable_Opt_empty!)
        } else {
            print("(2-3) variable_Opt_empty is nil or emptry")
        }
        
        // Optional is actually enum, so can use switch or patter matching
        let variable_Opt_enum: Int? = 10
        // (1) Switch
        switch variable_Opt_enum {  // Warning, because it's constant
        case .none:
            print("(3-1) variable_Opt_enum is nil")
        case .some(let val) where val > 5:
            print("(3-1) variable_Opt_enum \(val) is > 5")
        case .some(let val) where val <= 5:
            print("(3-1) variable_Opt_enum \(val) is <= 5")
        default:
            print("(3-1) variable_Opt_enum is none")
        }
        /*
         // XXX: Xcode has bug..., cannot build (??) build halted infinitely
         // (2) Pattern Matching
        if case .some(let val): Optional = variable_Opt_enum {
            print("(3-1) variable_Opt_enum is \(val)")
        }
        */
    }
    
    func ClassTest() {
        class Klass {
            // Stored Property
            var str: String
            var storedStr: String?
            init(str: String) {
                self.str = str
            }
            // Computed Property
            var computedStr: String? {
                get {
                    if let str = self.storedStr {
                        return "Computed \(str)"
                    } else {
                        return "Nothing"
                    }
                }
                set {
                    if let newValue = newValue {
                        self.storedStr = "Stored \(newValue)"
                    } else {
                        self.storedStr = "Nothing"
                    }
                }
                
            }
        }
        class Klass2 {
            var str: String? {
                willSet {
                    if let str = self.str {
                        print("Klass2: String (\(str)) will be set as \(newValue!)")
                    } else {
                        print("Klass2: String (nil) will be set as \(newValue!)")
                    }
                }
                didSet {
                    if let str = oldValue {
                        print("Klass2: String (\(str)) did be set as \(self.str!)")
                    } else {
                        print("Klass2: String (nil) did be set as \(self.str!)")
                    }
                }
            }
        }
        
        // Class inference
        let klass_org = Klass(str: "class")
        let klass_ref = klass_org  // klass2 refer klass
        print("klass_ref is \(klass_ref.str)")
        klass_org.str = "class modified"
        print("klass_ref is \(klass_ref.str)")
        
        // Set/Get property
        let klass = Klass(str: "class")
        print("Klass: Computed string is \(klass.computedStr!)")
        klass.storedStr = "string"
        print("Klass: Computed string is \(klass.computedStr!)")
        klass.computedStr = "string"
        print("Klass: Stored string is \(klass.storedStr!)")
        
        // willSet/didSet
        let klass2 = Klass2()
        klass2.str = "String"
        
        print("Optional Class Test -------------------------")
        // (1) Class
        let test_Opt: Klass? = Klass(str: "Class Optional") // Optional
        // let test_IUOpt: Klass! = nil     // ImplicitlyUnwrappedOptional, XXX: Not recommed
        
        print("(1) test_Opt!.str is " + test_Opt!.str)      // ImplicitlyUnwrappedOptional, XXX: Not recommend
        print("(1) test_Opt?.str is " + (test_Opt?.str)!)   // Unwrapping optional
        // print("(1) test_IUOpt.str is " + test_IUOpt.str) // Runtime Error: it's nil
        
        // (2) Class Members
        let temp = (test_Opt?.str)!
        let temp_Opt = test_Opt?.str     // Optional
        let temp_IUOpt = test_Opt!.str   // ImplicitlyUnwrappedOptional, XXX: Not recommed
        
        print("(2) (test_Opt?.str)! is " + temp)
        print("(2) (test_Opt?.str)! is " + temp_Opt!) // Unwrapping
        print("(2) test_Opt!.str is " + temp_IUOpt)   // Unwrapped already
    }
    
    func FuncClosureTest() {
        func function(str: String, str2: String) -> String {
            return "Hello, " + str + " " + str2
        }
        func function_NoParam(_ str: String, _ str2: String) -> String {
            return "Hello, " + str + " " + str2
        }
        func function_DefParam(_ str: String = "function", _ str2: String = "test Default Param") -> String {
            return "Hello, " + str + " " + str2
        }
        func function_VarParam(_ strs: String...) -> String {
            var temp = ""
            for str in strs {
                temp += str + " "
            }
            return "Hello, " + temp
        }
        func function_RetFunc(_ str: String, _ str2: String) -> (String) -> String {
            func _function(_ _str: String) -> String {
                return "Hello, " + str + " " + str2 + _str
            }
            return _function
        }
        func function_RetClosure(_ str: String, _ str2: String) -> (String) -> String {
            return { (_ _str: String) -> String in
                return "Hello, " + str + " " + str2 + str
            }
        }
        // Type inference
        func function_RetClosure2(_ str: String, _ str2: String) -> (String) -> String {
            return { _str in
                return "Hello, " + str + " " + str2 + _str
            }
        }
        // $0: first parameters
        func function_RetClosure3(_ str: String, _ str2: String) -> (String) -> String {
            return { return "Hello, " + str + " " + str2 + $0 }
        }
        // Implicit return
        func function_RetClosure4(_ str: String, _ str2: String) -> (String) -> String {
            return { "Hello, " + str + " " + str2 + $0 }
        }
        func function_FuncParam(_ str: String, _function: (String) -> String) -> String {
            return _function(str)
        }
        
        print(function(str: "function", str2: "test"))
        print(function_NoParam("function", "test No Param"))
        print(function_DefParam())
        print(function_VarParam("function", "test", "Var", "Param"))
        print(function_RetFunc("function", "test Return")("Function"))
        print(function_RetClosure("function", "test Return")("Closure"))
        print(function_RetClosure2("function", "test Return")("Closure"))
        print(function_RetClosure3("function", "test Return")("Closure"))
        print(function_RetClosure4("function", "test Return")("Closure"))

        // Closure as variable
        let function_ClosureVar: (String, String) -> String = { "Hello, " + $0 + " " + $1}
        print(function_ClosureVar("function", "test closure as variable"))
        
        // Closure variable as optional chaing
        let function_ClosureChain: ((String, String) -> String )? = nil
        if let temp = function_ClosureChain?("function", "test closure as variable") {
            print(temp)
        } else {
            print("function_ClosureChain is nil")
        }
        
        // Closure as parameter
        print(function_FuncParam("functino test closure param", _function: { "Hello, " + $0 }))
        print(function_FuncParam("functino test closure param2"){ "Hello, " + $0 })
        
        // Closure Examples
        let numbers = [3, 9, 1, 5, 11, 7]
        print("Numbers sorted is \(numbers.sorted { $0 < $1 })")
        print("Numbers filtered is \(numbers.filter { $0 > 5 })")
        print("Numbers mapped is \(numbers.map { $0 + 1 })")
        print("Numbers reduced(+) is \(numbers.reduce(0) { $0 + $1 })")
        print("Numbers reduced(*) is \(numbers.reduce(1, *))")
    }
    
    func TupleTest() {
        // Declare tuple
        let data: (var0: String, var1: String) = ("Variable 0", "Variable 1")
        print(data.0)
        
        // Assign variables at once
        let (data0, data1) = ("Data 0", "Data1")
        print("Assigned tuple is \(data0) \(data1)")
        
        func TupleFunc(_ name: String) -> (name: String, value: Int)? {
            let datas: [(name: String, value: Int)] = [
                ("data0", 12345),
                ("data1", 54321)
            ]
            for data in datas {
                if data.0 == name {
                    return data
                }
            }
            return nil
        }
        
        // Optional chaining
        if let val = TupleFunc("data2") {
            print("data2's value is \(val.value)")
        } else {
            print("data2 is nil")
        }
        
        if let val = TupleFunc("data0") {
            let (_, value) = val
            print("data0's value is \(value)")
        } else {
            print("data0 is nil")
        }
    }
    
    func EnumTest() {
        enum Week: Int {
            case Sunday = 0
            case Monday
            case Tuesday
            case Wednesday
            case Thursday
            case Friday
            case Saturday
            
            func toString() -> String {
                switch self {
                case .Sunday:
                    return "Sunday"
                case .Monday:
                    return "Monday"
                case .Tuesday:
                    return "Tuesday"
                case .Wednesday:
                    return "Wednesday"
                case .Thursday:
                    return "Thursday"
                case .Friday:
                    return "Friday"
                case .Saturday:
                    return "Saturday"
                }
            }
        }
        
        let monday = Week(rawValue: 1)
        if let val = monday {
            print("Monday is \(val.toString())(\(val.rawValue))")
        } else {
            print("monday is nil")
        }
        
        let sunday: Week = .Sunday
        // No need to check nil !
        print("Sunday is \(sunday.toString())(\(sunday.rawValue))")
        
        // Associated Values Enum
        enum Media {
            case Movie(name: String, year: Int)
            case Book(name: String, author: Int)
        }
        
        let movie: Media = .Movie(name: "Avengers", year: 2015)
        // Getting enum value
        // (1) Switch
        switch movie {
        case .Movie (let name, let year):
            print("Case: Movie is name: \(name), year: \(year)")
        default:
            break;
        }
        
        // (2) Patter Matching
        if case .Movie (let name, let year) = movie {
            print("Patter Matching: Movie is name: \(name), year: \(year)")
        }
    }

    func protocolTest() {
        struct Mail: Sendable {
            var msg: String?
            var from: String?
            var to: String
            func send() {
                if let from = self.from {
                    print("Send mail from \(from) to \(self.to)")
                }
            }
        }
        struct Feedback: Sendable {
            var msg: String?
            var from: String? {
                return nil
            }
            var to: String
            func send() {
                print("Send feedback to \(self.to)")
            }
        }
        
        func sendAnything(_ sendable: Sendable) {
            sendable.send()
        }
        
        let mail = Mail(msg: "This is from Mail", from: "from@mail.com", to: "to@mail.com")
        sendAnything(mail)
        
        let feedback = Feedback(msg: "This is from Feedback", to: "to@feedback.com")
        sendAnything(feedback)
        
        struct Dog: CustomStringConvertible {
            var name: String
            var description: String {
                return self.name
            }
        }
        
        struct Cat: CustomDebugStringConvertible {
            var debugDescription: String
        }
        
        let dog = Dog(name: "Wolf")
        print(dog)
        let cat = Cat(debugDescription: "Cat")
        print(cat)
        
        struct DollarConverter: ExpressibleByIntegerLiteral {
            let rate: Double = 10.0
            var value: Int
            init(integerLiteral value: Int) {
                self.value = Int(Double(value) * rate)
            }
        }
        
        let dollar: DollarConverter = 100
        print(dollar.value)
        
        struct OddEvenFilter: ExpressibleByArrayLiteral {
            typealias ArrayLiteralElement = Int
            var odd: Array<Int> = []
            var even: Array<Int> = []
            init(arrayLiteral elements: Int...) {
                for element in elements {
                    if element % 2 == 0 {
                        self.even.append(element)
                    } else {
                        self.odd.append(element)
                    }
                }
            }
        }
        
        //let oddeven = OddEvenFilter(arrayLiteral: 1, 2, 3, 4, 5, 6, 7)
        let oddeven: OddEvenFilter = [ 1, 2, 3, 4, 5, 6, 7 ]
        print(oddeven.even)
        print(oddeven.odd)
    }
    
    func AnyTest() {
        let anyNum: Any = 10
        let anyStr: Any = "Hello"
        
        // Check type
        print(anyNum is Int)
        print(anyStr is String)
        
        // Type casting
        let num: Int = anyNum as! Int
        let str: String? = anyStr as? String
        print("\(anyNum) == \(num), \(anyStr) == \(str!)")
        
        // Optional chaining
        if let num = anyNum as? Int {
            print(num + 1)
        }
    }
    
    func ExtensionTest() {
        var str = "Hello"
        print(str.count)
        print(str.reversed())
        str.reversing()
        print(str)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // OptionalTest()
        // ClassTest()
        // FuncClosureTest()
        // TupleTest()
        // EnumTest()
        // protocolTest()
        // AnyTest()
        ExtensionTest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

