
SwiftUI Day 16 (skip from Day 1)

Every layout we will see on screen by using swiftUI are views. And view are protocl that has only require the struct have a compute property body which return opague value some view.

Group{ } SwiftUI's view hierarchy doesn't allow parent to have 10 or more child view

NavigationBar prevent overlap with system info when creating a form and scrolling up, however, this is prevented in iOS 14 automatically.

Using @State property wrapper to get around immutability of struct property. we can use it to store value and change it latter

binding a state var will allow the view which bind it to use the variable's value, and also update the view when state var change on run time.

ForEach are using to create views in loop and can ignore the limitation of 10 child view. ForEach(collection){ x  in some view} where x is the alias of element in the collection, some view is the return view for each element. However, each element has to be unique identify. This could be complished by conforming to identifible protocol for each x.
///////////////////////
swiftUI Day 1 
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
