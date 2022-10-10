SwiftUI Day 20

Color are views too. For example, Color.red, Color.blue, etc. When used as a view color automatically take the whole area except safe zone. Safe zone is where apple display system info, and can be turn off by .ignoreSafeArea().

Color can use to specify Text background color by using .background(.color) but only text can have background color.

Since Color view can take up the whole space, .frame() can specify desired size

.background() not only can accpet color, but also materials, such as ultthinmaterial which add glasses effect on text above it.

.foregroundColor()  Change the color of the text

.foregroundStyle() seems to do similar thing, but has something called effect vibrancy. Too subtle to me.

Gradients is the visual representation of color transition to other color.
Today I learned three new ways to initalize it for layout use(with ZStack).
LinearGradient(), Radialgradient(), Angulargradient().

Each can be initalize through proving gradient(or color or gradient.stop), and other direction parameter. 

Notice, we using stop for gradient, only the interval between stops show the tranition of the color.
  
Button can be modifiy through .buttonStyle() for border style, and .tint() for color of the border.

Button's initalizer have role, and label augment, and latter and use to customize the appearance of button completely. role is to tell user what purpose that button can be through styling.

use .renderingMode(.original) for Image view when SwiftUI colored version of image.

.alert() modifier trigger whenever, the binding variable become false, and it present flexible way to present alert message through message: agrument. Notice, any button, in the content of alert will dismiss the alert and set the binding variable to false.


//////////////////
SwiftUI Day 19

Volume Convertion project completed

we can use String(format: "%.3f", value_double) to format a double to 3 decimal place
////////////

SwiftUI Day 18

WeSplit project completed

///////////////////
SwiftUI Day 17

Continue in Day 16 we try to build a app that split the bill for user

In formating a textfield, swift have Locale struct builed in which contain user info. To access current user's region currency code which use to format the textfield, we can do Locale.current.currency.identifier(iOS 16)

SwiftUI allow textfiled to prompt different keyboard, using modifier .keyboardType() of TextField

Picker and ForEach work well, but if you pass a int binding as value of picker, and write ForEach to return a views with RangInt. the value of binding int doesn't determine what value we pick but the ith element from RangInt. To fix this, use .tag modifier for ForEach return views. If each view is tag with unique value, then picker will show the view which has its tag matching with the binding value

When using ForEach, if element didn't conform to identifiable, use id: \.self argument. This mean to identify element uniquely using its own value. Make sure their value are unique.

New property wrapper: @FocusState which can be use to bind a view and see if the view focus or not, receving user attention or not. And we can turn that off in some action such as button to turn that to false

in the content of toolbar, we can use ToolBarItemGroup or ToolBarItem to specify whether we want to place many toolbaritem or just one. The location can be specify through placement: augment

New learned modifier: 
Picker.pickerStyle(.segmented)
TextField.keyboardType()
TextField.isFocus()
.toolbar
**//////////////////////**

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
