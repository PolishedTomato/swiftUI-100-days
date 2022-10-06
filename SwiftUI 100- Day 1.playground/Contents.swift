import Cocoa

var greeting = "Hello, playground"
//Day 1 exercise
// variables and constant
var x = " some variable"
let y = "some constant"

var s = """
    "samdlkmdaslkdmasld
      \"""  adnasndaslndsal \n
    ajsdnasndlad
"""

//# before & after thriple " will ignore special letter

var ss = #"""
      "samdlkmdaslkdmasld
        \"""  adnasndaslndsal \n
      ajsdnasndlad
  """#

print(s)
print(ss)

//has suffix check all the way to the beginning of the string, same goes to hasprefix
if ss.hasSuffix(ss){
    print("has suffix")
}

//loop through string with index
for i in 0..<ss.count{
    print(ss[ss.index(ss.startIndex, offsetBy: i)])
}

var some_number = 1000000
var some_number2 = 1_000_000

if some_number == some_number2{
    print("swift doesn't care about underscore in int")
}

var some_faction = 1000.21
var some_faction2 = 1_000.21

if(some_faction == some_faction2){
    print("swift doesn't care about undersore in double too")
}

//skip to day 8

enum some_error: Error{
    case too_short, too_obvious
    case no_root
}

func some_function(Password:String) throws ->Void{
    if(Password.count < 5){
        throw some_error.too_short
    }
}

let p = "1234"

do{
  try some_function(Password: p)
}
catch{
    print(error)
}

//input range from 0 - 10000
func check_Int_Sqrt(Input: Int) throws ->Int{
    for i in 0...100{
        if i*i == Input{
            return i
        }
    }
    throw some_error.no_root
}

do{
    print(try check_Int_Sqrt(Input: 3))
}
catch some_error.no_root{
    print(some_error.no_root)
}

//day 11 access control

//private, public, fileprivate, private(set)
//These are access controls.
//place these before entity such as class, method, data member will restrict the access to this entity.
//private only avaviable to what it belong
//public for everyone to use
//fileprivate make this entity only available to this file
//private(set) make this variable's set funtionality limit to its own class or struct

//day 14
// nil coalescing
//syntax let x = some_function_which_could_be_nil ?? default value

func could_nil(input: Int)->Int?{
    return input == 5 ? input : nil
}

let possible = could_nil(input: 7) ?? 6
print(possible)
