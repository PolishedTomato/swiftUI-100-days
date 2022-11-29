SwiftUI Day 64(Core Image continue)

PHPickerViewControllerDelegate won't response, because UIKit's design pattern, it use delegator to response events. Therefore, we need a Coordinator class that confrom NSObject, and cooresponding deletegate protocol of specific view controller. Deletegate protocol require picker() method. Notice, swiftUI use Coordinator as name for delegator in UIkit. 

This tutorial used provider(Dont know what it is) to load, and assign result to a binding variable to caller. And that's how SwiftUI retrive photo through UIkit's help.

The simpest form of saving a img:
UIImageWriteToSavedPhotosAlbum(inputImage, nil, nil, nil)

the first parameter is the image to save.

the second parameter is the class that get notify when save complete(need to be a class and comform to NSObject)

the thrid parameter is the completion handler's name. It require special syntax #selector(name), and this method should be have @objc before it. So swift will generate code objective-c can read. This method should also have specific parameter as well.

///////
SwiftUI Day 63(Core Image)

Four types of image in iOS: SwiftUI image, UIImage(UIkit), CGImage, CIImage(Core Image)

To use core Image api:
1, create a UIImage(name:)?
2, convert it to CIImage(image:UIImage)
3, Create CIContext(), and CIFilter._
4, apply changes.
5, convert CIImage to CGImage by context.createCGImage(CIImage, from: CIImage.extent)
6, convert UIImage from CIImage, UIImage(cgImage:)
7, convert SwiftUI image from UIImage, Image(uiImage: )

how to use UIKit functionality in SwiftUI:
we need a struct conform to UIViewControllerRepresentable, that contain two func: updateUIViewController(), and makeUIViewController(). It act as a view in swiftUI and the second func act as the body property of normal swiftUI view.

New concecpt: UIView, UIViewController.
UIView is a class with all the layout of UIKit on its subclass. 
UIViewController is a class with all the code that bring view alive(according to hacking with swift) on its subclass.

To use UIkit's view, we return a subclass of UIViewController in makeUIViewController()

UIKit has special way to initalize new UIcontroller by creating configure then use that configue to create a viewcontroller.

/////
SwiftUI Day 62

when using state property wrapper, setting it will trigger setter(property observer), but chaing it through binding won't, because SwiftUI didn't really set the value its wrapped but changing a projectedValue. the setter of wrappedValue is non mutating set. Therefore, simply set the state variable can trigger setter, through blinding its won't for it bypass the setter into the projectedValue directly.

onChange(of:){} modifier will solve this problem where SwiftUI send new value when of: argument changed.

.confirmationDialog() work similar to .alert() except it display as a smaller slider from button of the screen. It can contain multiple button like alert as well. Message, etc.

///////////////
SwiftUI Day 61(CoreData upon day 60)

use asynchrous call MainActor.run for updating or saving core Data before rendering to prevent data rush, so our view don't display before data ready. MainActor.run{} run one piece of code at a time.

I don't know how to clean up coreData but, to have a new database to play with, changing the name of datamodal and assinged a new container seems to work.

When creating NSManagedObject subclasses and assigned relationship to one class(many to one), coreData doesn't allow save for error illegal attemp to save for object in different context.
Which mean you can't save if you still using the same class.

This project's data modal was using CachedUser to CacheFriend(one to many), CahceUser to Tag(one to many).

This project should be better to use many to many relationship between users, friends, tags. However, I haven't learn it yet. Maybe update in the future. 
////////////////////
SwiftUI Day 60(consolidation)

key point: SwiftUI automatically add attribute @ViewBuilder to var body for each view component, so we can return multiple views in body property, and return different view(s) on conditions.

Other ways to return different view on condition without @ViewBuilder. type erasure method use anyview( your view) to act as a shell to hide the actual type of the view.(least recommend for swiftui may try to recreate views for small changes) or other method is Group{} view to wrappe it around. Some time a new view component is better solution>

Codable key points:
When we encounter JSON using snake case(like first_name) rather than camel case(swift), we dont need to write our own coding conformance like creating enum with case matching the naming of JSON then write it to our own property with those keys. 

solution one: decoder.keyDecodingStrategy = .convertFromSnakeCase, then we can write our struct in camelCase. 

solution two: using enum CodingKeys{} which case name match to our Codable struct new, and its raw value match to JSON's name. Notice, enum conformed to string protocol's default raw value is case name itself. And CodingKeys{} enum is a special one that SwitUI use it by default with that name for coding.
This solution work greate for random name.

Both save alot of work to write coding conformance.

Notice, you can't run asyn function in init() or child view's argument. we can run async code in onApear life cycle method with Task{} to provide concurrcy context.

challenge complete.
////////////////
SwitUI Day 59

Challenge complete!

Things that confused: the sortDescriptor argument of FetchRequest says is of type [NSSortDescriptor], however, using SortDescriptor() struct work fine here. 

/////////////

Continue from last day...

One simple way to dynamically change FetchRequest's predicate dynamically is by isolate the outcome by passing in a filter string into this isolated component. Inside the init() of this component, use datas = _FetchRequest<NSManagedObject>(sortDescritor:[], predicate: NSPredicates(...)). This code assign a new fetchrequest on initialization, rather than changing the outcome of the old fetch.

Further customization in predicate NSPredicate(format: "%K == %@", x,y) where x represent first attribute. Notice, %@ will be wrapped around '' while %K won't. It's captial K btw.

Generic also work fine here.

use @escaping before closure type to allow close to be use later in code

@ViewBuilder often used as parameter attribute before child-views producing closure parameter.This allow the closure to return multiple child view, and cilent can write closure return with multi view statment. Ex: (T in text("child1")
				text("child2")
				text("child3") 

SWiftUI Day 58

Continue from Day 57 project...

We can filter fetchedResult in the predicate parameter of @FetchRequst wrapper. NSPredicate(format: "attribute_name == %@", "some_val") can filter the outcome array with specified predicate(s), this one return objects which attribute equal to some_val. %@ is the place holder for second parameter. <, > operator can also be use, and these expression can be combine with AND, NOT...

_variable = some_val where variable have a property wrapper means to change the struct that wrapper around the variable entirely. while variable = some_val change value of the wrapper struct only.

We can enfore one to many relationship through assign class to dependent class's property, and use constrant to remove duplicate class, then the dependent class will all link to one class.
In addition, we need to change one to one relation to m to m in data modal as well.
///////////////
SwiftUI Day 57(CoreData continue)

The ForEach(id: \.self) parameter use the struct itself as unique identifier. Under the hood, SwiftUI need the data of collection conform to hashtable, and use the hash value for identification. When CoreData create managedObject subclass, it generate other property other than its attribute, like Object id, and the class is conform to hashtable. Therefore, we can use \.self for CoreData fetchResult<entity> in ForEach.

A solution to nil colescing of managedObject subclass property is to avoid Xcode generated managedObject subclass, and generate it manually, and add compute property on property class which do nil colescing there. 
1, go to DataModal -> Xcode View-> inspector-> DataModal-> tap entity -> Codegen change to Manul/None
2, Xocde Editor-> CreateNSManagedObject subclass...->select entity you want to create
3, there will be two swift file for one entity -> go to property class-> add compute property.

ManagedObjectContex has property .hasChange which true if changes happen, use it for save the moc when change happen. 

We can add constrants on entity, go to entity inspector, putting a attribute there will make all object unique. Consequantly, duplicate object will caused error in save() function (write changes to disk) without mergePolicy in DataController.swift.
/////////////////

SWIFTUI DAY 56

view present as sheet doesn't share the same environment with the previous one.

BookWorm Challenge completed
//////////////
SwiftUI Day 55

fetching sorting: sort the data out of coreData using sortDescrptior. 
@FetchRequest(sortDescriptor: []) by adding sortDescriptor class inside the array of the wrapper. class syntax: SortDescriptor(.\name), that name is a attribute of the entity we fetch in fetchResult<entity> type. sorting in reverse order, can be achieve by SortDescriptor(.\name, order: .reverse). Multiple SortDescriptor can be apply.

To have delete functionality, use List then ForEach with onDelete(perform:) modifier.

Alert action argument can be place with two buttons without HStack.

managedObjectContext is the live version of your data. Thus, calling .delete() without .save() won't write the change on disk.

SwiftUI Day 54

CoreData's managed object class conform to identifiable automatically

////////////
SwiftUI Day 53(Core Data intro)

@Binding wrapper bind(connect) and source of truth to its child view, and any modification on binding will reflect on pass in value. Must like @StateObject to @ObservedObject's relationship. 

use TextEditor() for multi line string input(can't be style like text view)

Using CoreData:
1, Create data modal(defintion of your data) in Core Data file
2, create a class that load data with 1, create a container with data model(prepare for load) 2, then load with loadPersistnetStores.
3, inject it into our environment on root view with modifier .environment(\.managedObjectContext, dataController.container.viewContext) 
4, use @FetchRequest to fetch data(read)
5, use environment to get managedObjectContext which contain all data(managedObjects class of our entity), then save it.
6, Save process: 1, @Enviornment(\.managedObjectContext) var moc, 2, let new_class = Class(Context: moc), and directly modify the new class. moc.save()(a throwing call)
 
//////////
SwiftUI Day 52(decode, and encode whole class with codingKey)

Challenges complete, CupCakeCorner porject finished.

URLRequest desecribe how data should be fetched.

//////
SwiftUI Day 51(URLSession for retrieving uploading data online)

Encoder.container().encode(value, forkey:) doesn't care about order

Notice: creating a container from encode is not a throwing call, but creating a container with decoder is a throwing call.

In this tutorial, it use URLRequest to configure the http request we will be making to the serve, three lines of code: URLRequest(url: server_url), requesr.setValue()(barely know, it seem to set the meta data to service for handling the data), request.httpMethod() = "POST" (POST for writing data, GET for reading, the action we want to perform)

New URLSession method: URLSession.shared.upload(for: request, from: Json data) which send Json data with this request, and return the tuple as (json_data, URLResponse). it different from URLSession.shared.data(from:) by it only read URL and return (data, URLResponse)  

//////////
SwiftUI Day 50

string interpolation have second argument format: like Text() view.

///////
SwiftUI Day 49

How to make class which use @Published wrapper to confrom to codable: By using a enum conform to CodingKey which has its case as property we want to achieve or unachieve. Together, with a init() and func encode(). That decode in init() using container in encoder and decoder.(see code in this project).

Advantage over UserDefault API, more complex key name are available, rather than string only.

URLSession.shared.data(from:) use the shared instance of URLSession to read content of URL, and return (data, metadata), then we decode this data, and that is how we retrive data from other Service.

Use AsyncImage(urL:) to remotely load image. Argument scale: tell SWiftUI in advance what scale of this loading image will be. AsyncImage also come with argument AsyncImage(url:scale:content:placeholder:) that allow us modifiy the img view in this AsyncImage through content closure, like .resizable().

we can prevent button been tapped by using .disabled(boolean expression) modifier. 
////////////
SwiftUI Day 47

ActivityTrackerApp complete basic feature.

//////////

SwifTUI Day 46

Challenge Completed.

Notice, only Shape need AnimatableData for animation. View don't.

////////
SwiftUI Day 45

.blendMode() modifier control how SwiftUI render pixels when on top of other views. For example, .blendMode(.Multiple) multiple the target view's pixels with source pixels(The pixels under the modifying view).

Color.red, Color.blue, ..., etc are not pure red or blue, but adpative color of SwiftUI to look good on light or dark mode. To use pure color, we need Color(red: greem:blue:) initializer.

An interesting image modifier .saturation() from 0 - 1. 0 mean no color while 1 mean 100% color.

The shape struct won't animation with onTapGesture() like previous project because SwiftUI have to examine the state of value before and after blinding change. The problem is that once the blinding value got updated, it immediately got pass to the struct with no intermeidate value for animation to happen. 

Solution: var animatableData{get {} set{}}, since animation observe the value's state change, it will send to our shape animatableData that interplolate from old value to new value in animation process. This value's meaning is define by the shape. If state is 50 to 59, and our shape use it as width. We can use setter to control the width change by assigning new interpolated animatableData to width.

To animate shape with two variables, use animatableData: AnimatablePair<type, type> which read, write the new value for animation. Notice, animatableData was read by SwiftUI for animation, so it can't be a integer for it can't change from 0 to 0.1 to 0.2 and such.

For more variable, we can use nest AnimatablePair type. For example with 3 variables, animatableData: AnimatablePair<AnimatablePair<Double, Double>, Double>{}. Same idea for 4 or more. 
///////////
SwiftUI Day 44

use CGAffineTransform to scale, rotate, sheared Path or view. Notice, it use radian for rotation, degree to radian can be translate by pi/180, e.i. every 180 degree for one pi radian.

we can use ImagePaint() for border, stroke, fill, background. ImagePaint() give us a way to control our image when use it as background or fill a border. It use three parameters, a image, sourceRect, scale. The last two got default of a CGRect(x:0,y:0, width:1, height: 1) (that is the whole image, x y specify where does the rect start), and scale: 1. 

SwiftUI use Core Animation for default rendering. However, when thing got complex using .drawingGroup() modifier will use another rendering framework of apple named Meta.Meta is fast, but only recommend when Core Animation caused performance issue.
///////////

SwiftUI Day 43

Introduced Path view, Path() take a closure which accpet one parameter, Path. Ex: Path{ path in dosomething with path}. We can use this with CGPoint to hardcore a graph in our UI but there is a better way.

More advance trick to draw custom view is by using struct conform to Shape. Shape has one requirement func path(in:) ->Path. We can use struct conform to Shape for reusble code, and also dynamically draw our UI because the neat parameter in: which is a CGRect that have the info of the view container. For example, in.minX or in.midX return the left most coordinate and mid coordinate respectably. 

Things to be careful when drawing arc using path.addArc(): SwiftUI's degree 0 begin at the right side like a unit circle. It measure coordinate differenctly, so we have to input false for clockwise when want a clockwise behavior.

Also, 90 degree is at bottom, 270 is at top.

InSettableShape protocol which have method of StrokeBorder() that draw inside the shape, rather in the border such as .Stroke(). InSettableShape basically allow the shape to reduce its size, by insetAmount. Notice, InsettableShape protocol builded upon Sahpe protocol, perhaps through protocol? It need a func inset(by amount: CGFloat) ->some InsettableShape {} that return a size changed instance back.(See SwiftUI Day 43 project)

////////////

SwiftUI Day 42

use buttonStyle() and .tint() modifier for navigationLink to change the way SwiftUI highlight the view. NavigationLink behave like a button here.

GeometryReader read the current view container's size.

Some notible difference on using ScrolView and List to display views. list doesn't have background color. The background color of scrollView will apply to its children if the children didn't specify it. List nagivationLink children will have a arrow on the right, while ScrollView doesn't.

Style List by using .listRowBackground(view:) on children, and listStyle() on List

MoonShot Challenger Completed.
/////////////
SwiftUI Day 41

Image using geometryreader for size suppose to center at top left corner.However, when other children in the same container as this image take the full width of the screen, the Image centered in the center. Interesting behavior.

A custom divider can be create by using rectangle().frame(height:2)

dictionary subsript return optional value, use ! to unwrap it.
////////////////
SwiftUI Day 40

JSONDecoder().dateDecodingStrategy = .formatted(DateFormatter) allow it to decode date in a specify way. Very convience.

NavigationViewTitle can be change its color through .preferredColorScheme()
//////////
SwiftUI Day 39

Until what I have learned, Image have two mode changable by .scaledToFit() or scaledToFill(), the first will scale the img into view's content space, while the latter allow it to go out of the view's space. 

We can hardcode the width of Image, however, a better approache is by using geometryReader() which take a void closure and feed it with a geo instance. We can use the property of geo to sepecify a dynamic size of our img using frame such as .frame(width:geo.size.width * 0.8) which is a width take up of 80 percent of screen. Same goes to height. However, geometryReader likes to place item in the top left corn, if want to center in the middle, add another .frame() with width, height equal to geo.size.width/height. 

ScrollView different to List and Form in that it allow custom view to be inside. 
ScrollView usually will be use with Stacks.

Here introduced LazyVStack/LazyHStack which only load view when needed, such as it won't create all the view in the container but only when needed. Otherwise, it behave the same as it's not lazy counter part.

How to decode hierarchical data such as a data type in side another data type: for each level  create a matching struct in your code and conform to codable. Then use that type for Json decoder.  

How to create grid: Use either LazyHGrid(rows: layout) or LazyVGrid(columns: layout) layout is of type [gridItems], this array specify what layout to use. For example, [GridItem(.fixed(60)), GridItem(.fixed(60)) will define for two cols or rows with 60 space for each item in LazyHGrid/LazyVGrid. HackingWithSwift recommon [GridItem(.adaptive( minimum: 80, maximum: 120))] which creating as many row/col as possible with specify interval of size. 

SwiftUI Day 38

project 7 challenge complete.

/////////

SwiftUI Day 37

One intesting point how hacking with swift to show type of array is by [elementType].self

Project 7 completed

SwiftUI Day 36

since struct is value type, changes in one of its won't reflect other because they all copys. Therefore, to share data among view, we need class. SwiftUI rerender our view for changing on @state variable. If that is a struct, changing property of that will recreate a new struct and @State is able to spot the change, then rerender our view. However, class don't need the mutating keyword for changing its property(so @state didn't know if that class changed or not), thus, @State won't work for class. Today introduced @StateObject @ObservedObject @Publisehd ObservableObject for class instance to share data among views. In the root view, we should create class object which conform to ObservableObject protocol with property wrapper @StateObject to tell SwitiUI to monitor this class, and class object will have the property which it want to be monitor wrapped with @Published. Any changes on these property will notify the view that using the published property, and got reload bt SwiftUI. This is essentially move state property in a class. If we want to share that class to child view, child view's corresponding class instance should wrapped with @observedObject, passed by parent view.

To programmtically dismiss our view, use @Environment(\.dismiss) var some_name, calling some_name() will dismiss the view.

To remove a dynamically created row, we use .onDelete(perform: (indexSet)->void) modifier of ForEach, List dont have it. indexSet is the position of element for each row, if we were using array for this row contruction, we can use array.remove(atOffsets: indexSet) 

EditButton() toggle the environment value of edit mode, we can use it for easy delete on ForEach() views

use UserDafaults to store passive data. UserDefaults.standard.set(some_val, forKey: "Tap"). Key is how we retrive our data. @State var data = UserDefaults.standard.integer(forKey: "Tap"). Another way to do it: @AppStorage ("Key") var some_val = default_val.; 
One line code, easier. 

UserDefault is good for storing small data, and will automatically load we app start.

However, for more complex data structrue like custom class or struct, we can't used the second method. We need to used JSONEncoder.encode and JSONDecoder.decode() to convert our data into JSON object which is a representation of data then save it in UserDefault.
Ex: data = JSONEncoder.encode(some_struct) UserDefault.standard.set(data, forKey: some_keay)
/////
SwiftUI Day 35

loose file in xcode project like text, movie, JSON, XML are builded into a directory called resources in the main bundle no matter where we group it. Therefore, having same file name will casue problem.

edutainment challenger complete
///////// 

SwiftUI Day 34

GuessTheFlag updated with animation.

Some note: when using if to insert view into view hierarchy animation won't show, but the modified view. Ternary expression can be nested like, bool expression ? bool expression ? some_val : some_val : some_val

we can use this nest ternary expression to control animation in different stages. The nest one can be seem as the second stage.  

////////
SwiftUI Day 33

we can apply multiple animation modifier and .animation modifier order matter, every animation modifier control animating modifier before it. Therefore, we can have different animation at one property.

.gesture() modifier take gesture agrument. Today we used DragGesture(). DragGesture() then can take two important modifier .onchanged() .onEnded correspond to dragging action, and leasing action. Both take a one parameter void closure. We can make the effect of dragging a view around by using offset() which specify how far it want to move from original position, and onChange{dragAmount = $0.translatiion} and .offset(dragAmount). onChange pass self into closure and self has translation property that take us how far did it move from result location to original location. offset then use this data to update location of view in UI. Even though I don't know what self is in this context, this is how it make it happen. 

.transition() modifier need to use with animation. transition modifier specify how a view insertion and removal in the view hierachy will behave. One of such case is to use if conditionally show a view. With only animation, swiftUI use default tranition. .tranition(.scale) will scale from nothing to this view  when inserting, and scale to nothing when removing.   
////////////////
SwiftUI Day 32

implicit animation is fairly simple. By placing .animation(animation: value:) modifier, view will transform original view to animting view smoothly without we to care when value argument change. Any animating modifier before it which use value will take effect. Some animating modifier include .scaleEffect(), .blur() 

since animation modifier take animation struct, we can add modifier to animation argument too. repeatCount() .repreatFover() repeat the animation for numbers of time. Notice, the autoreverse argument of them will show animation from alter state to original state. animation.delay(sec) delay sec before animation.

we can also use animation modifier on binding value, SwiftUI will animate view on change of binding value. Behave like animation modifier on view, any view that has animating modifier using that binding value will be animated.

The first case state change have no idea if it will animate some view, the second case view don't know if it will be animated(since the modifier is on binding value now).

while explicit animation say exactly that the change this block of code bring will be animated. Ex withAnimation{ animationSize += 1}. This also accpet animation agrument like withAnimation(.easeInout.repeatForever()){do something}.

SwiftUI Day 31

project5 and its challenge complete.

Notice, when adding toolbar modifier for navigationView, it have to be with the first child in the hierachy.

Multiline string's last """ indentation determine where our string should begin, any further indentation after that will be convert to autual indentation in string.
/////////////
SwiftUI Day 30

onSubmit({}) execute a void closure that take no parameter when value is submit for this view. In the case of textfield, that's when user hit the return. 

///////////////
SwiftUI Day 29(spell checker involved)

List and Form are identical except list are use for data representation while form use for data input.

one difference is that List can dynamatic create row like List(0..<3){someview}
Like ForEach, SwiftUI need a unique way to identify each element been generated. For a collection of unique value use id: \.self argument. Otherwise, confrom to identifiable protocol

introduced a new data type URL, which store address of web, but can also store the location of file.

when xcode build our porject, it create something call bundle where all our code and asset store in this one place.(Like object file to me)

we can use Bundle.main.url() to read the URL for a file in main bundle, it return a optional value.

with the URL, then we can use String(contentsOf: fileURL) to read the content (this can throw)

string.component(seperatedBY:) return an array of string from caller by dividing the caller with seperatedBY.

let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines) remove whitespace, tab, new line in the begin and end of string

Use UITextChecker() to check spelling. Here is a little bit complex. Since UITextChecker() was written in objective-c, it accpet a range of objective-c range, we can generated that range with NSRange(location: 0, length: word.utf16.count) for word's whole range. let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en". This use UITextChecker to find word's misspelling from the begin to the range in English, and it return the range of misspell.
Since objective-c don't have optional, misspelledrange.location will return NSNotFound when not spell error. 
////////////

SwiftUI Day 28

Date.formatted() function should be call for displaying purpose


/////////////
SwiftUI Day 27

you can't assign computed property to store property's default value because self is not available to property initalizer. One way to work around this is use class property to declare that computed property as class computed property with static keyword. class property is available before indidivual struct property initalization.

import CoreML to use macineleaning library. By draging the MLmodel created by creat ML into Xcode naviagtor, Xcode will create a Swift class that represent this model in build, and we can use .prediction() on this class to predict base on existing model. the name of the class follow the name of the model. It can also be check in the preview content.

Date object - seoncd return a new date object, very powerful API 
///////


SwifiUI Day 26

BetterRest project completed

When try to add a ZStack in side form to use RadialGradient for background purpose, setting RadialGradient.frame() with .infinity can't fill out the whole ZStack container. However, I managed to work around it by using padding(-50) modifier on it.

Since Date is hard to manipulate, we should reply on iOS for date calculation. we can create a DateComponents() to specify the hour, minute,etc and use Calendar.current.date(from: components), Ex components = DateComponets(), components.hour = 8, components.minute = 0, then that func will return a date object of today with specified date component. That is 8 am of today.

can also get date component from a date object with Calendar.current.dateComponents(_,from:)

we can access time info using Date object, Date.now return a instance representing current time. DatePicker() display the day of binding date instance. It display month, day, hour, minute, this can then be modifier by displayedComponents: argument. Like Stepper, limit can be set by in: using date range or one side date range like Date.now ... (from now on). label can be turn off with .labelsHidden() modifier.  

double.formatted() return a string in floatingpointformatstyle, such as 2.000000 to 2. 

Stepper provided two buttons for increment and decrement a binding value, limits and step can be specify through in:, step: arguments.


////////////////
SwifUI Day 24

RockPaperScissor project completed

Custom binding allow us to bind multiple value, and set them or get them.
Not to familiar, For example, let agreedToAll = Binding( get: {get the binding value}, set: {set the value we binded})
////////////

SwiftUI Day 23

There are two types of modifiers, environment modifier, regular one. When placing environment modifier on a container, it automatically apply to all of its child. apply same modifier to its child again will override it. However, this behavior is not for regular one(can't override).

avoid using if on conditionally show view, because it its less efficient, if that can be done with ternary operator

use ternary operator for conditional modifier, condition ? true : false

under the hood, swiftui use tupleStack when we using VStack. tuple stack accpet 2-10 view, and thats why we need to limit ourself with view size or use group{} instead.

view protocol also have associated type, and that is why returning view won't make sense, its has to be concrete view type. 

The body property is using opague return type for performance because compiler need to figure out the type instead searthing, and we really don't care what kind of view is returning. Writing ModifiedContent<ModifiedContent<>> will be painful.

modifier in SwiftUI create a new copy of applying struct with new changes. Each modifier create a copy with its new change; therefore, think of modifier as a changes stack on previous one. That impile order of modifier matter. In fact, if look at type of body property of content view with multiple modifiers, it will show the content of body property wrap around by ModifiedContent<our_view, modifier>. If there is more than one modifier, above will also be wrap around by ModifiedContent<> again.

One reason SwiftUI used struct as view rather than class like UIkit was the performence reason. struct allow us to think about our UI component in isolation. Creating a view cost exactly what is inside the struct, but class view cost alot more because inheirtance(view inheirt from UIView which contain many property, methods). 
//////////////////

swiftUI Day 22
GuessTheFlag completed
game cycle, and score feature added.

/////////////////////
SwiftUI Day 21

.font() modifier to change the size of font. However, in the selected font size append modfifier .weight() can also specify the thinness of selected font size.

.clipShape() modifier change the shape of Image. However, unlike most modifier which accpet a var or enum, clipshape() take a struct. Ex .clipShape(Rectangle())


////////////
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
