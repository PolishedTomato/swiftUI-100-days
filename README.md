SwiftUI Day 1 
I have reviewed the basic of Swif content from day 1 to day 14

some key note to review:

access control code:
private before entity make entity available to what it belong, like data member to its own class/struct

fileprivate before entity make entity available to only that file

public before entity make entity accessible from everywhere to everyone

private(set) before entity make entity's set functionality only available to where it belong

Optional Chaining:

optional Chaining allow us to read or set value in many level without being afraid of accessing nil in runtime.
Ex: let x = someclass?.someproperty

The return value of optional chaining is always optional.

This can also work on function return value.

Notice: for void function, optional chaining return Void?
we can use somefunction()? == nil to check if it executed succssfully

for setting value, optional chaining return nil if it fail.
Ex: if (someclass?.someproperty = somevalue) == nil
	print("fail")

optional coalescing:
use to implement default value when setting a value to which could return nil
let x = could_be_nil ?? default value
