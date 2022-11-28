# Dart Complete Language Guide

## Collection

**If Condition in collection**

```dart
final colors = [
    'grey',
    'white',
    if(isPink) 'pink', 
];

final countries = [
    'id': 'Indonesia',
    'my': 'Malaysia',
    'sg': 'Singapore',
    if(true) 'us': 'United State',
];
```

**Iteration in Collection**

```dart
const extraColors = ['yellow', 'green'];

// First Way
final colors = [
    'grey',
    'brown',
    for(final color in extraColors) color,
];

// Or Second Way
final colors2 = [
    'grey',
    'brown',
    ...extraColors,
];
```
## Null Safety

**Nullable Variable**

```dart
int? a = 0;
String? b = null;
Map<String, String?> c = {
    'a': null,
    'b': 'b'
};
```
**Non Nullable Variable**

```dart
int a = 0;
String b = 'a something value';
Map<String, String> c = {
    'a': 'test',
    'b': 'b'
};
```

**If Null Operator**

```dart
// Use tenary operator
int? maybeValue;

int value = maybeValue == null? 0 : maybeValue;

// Use fallback
int value2 = maybeValue ?? 0;

// Use cast away nullable
// Very important, if the variable is not sure and still allows null, don't use this method!.
int value3 = maybeValue!;

// Use `?` make safe operation in object references
final someCollection = ['A', null, 'C'];
someCollection.forEach((element) {
    print(element?.toUpperCase());
});
```

## Function

**Function Named & Positional Argument**

```dart

void main(){
    describePositional('Wisnu', 19);
    describePositional(name: 'Wisnu', age: 19);
}

String describePositional(String name, int age) {
    return 'My name is $name, I\'m $age years old';
}

// Use `{}` to implement named
// You have to add required keyword as this params need to pass
String describeNamed({required String name, required int age}) {
    return 'My name is $name, I\'m $age years old';
}

// When use default, no need to add required keywords
String describeNamedDefaultValue({String name = 'wisnu', int age = 19}) {
    return 'My name is $name, I\'m $age years old';
}

// If params is nullable you can without declaring value
String describeNamedNullable({String? name, int age = 19}) {
    return 'My name is $name, I\'m $age years old';
}

// Use `[]` to set default value on positional function
String describeDefaultPositional([String name = 'Wisnu', int age = 19]) {
    return 'My name is $name, I\'m $age years old';
}

// Function with arrow notation (`=>`)
// In this way, you can only have 1 statement to return a value in function
String describeArrowNotation(String name, int age) => 'My name is $name, I\'m $age years old';
```

**Inner Function**

Function in function

```dart
void main(){
    void foo(int b){
        print(b);
    }

    foo(12);
}
```

**Annonymous Function**

```dart
void main() {
    final sayHi = (String name) => 'Hello, $name';

    print(sayHi('Wisnu'));
}
```

**Function as First Class Object**

```dart
void main(){
    final sayHi = (String name) => 'Hello, $name';
    welcome(sayHi, 'Wisnu');
}

void welcome(String Function(String) great, String name) {
    print(great(name));
    print('Hi, $name');
}
```

**Function Type with typedef**

```dart
typedef Great = String Function(String);

void main(){
    final sayHi = (String name) => 'Hello, $name';
    welcome(sayHi, 'Wisnu');
}

void welcome(Great great, String name) {
    print(great(name));
    print('Hi, $name');
}
```

**Reduce to Combine all Elements**

```dart
void main(){
    const list = [1,2,3,4,5];

    // Will calculate all elements of `list` (1+2+3+4+5)
    final sum = list.reduce((value, element) => value + element);
    print(sum);
}
```

## Class

Is is the function of object oriented programming (OOP).

```dart
// [BankAccount] is class name
class BankAccount {
  // property/field of class
  double balance = 0;

  // Method  
  void depository(double amount){
    balance += amount;
  }

  void withdraw(double amount){
    if(balance > amount){
        balance -= amount;
        return true;
    }

    return false;
  }
}

void main() {
  final account = BankAccount();

  // access property of class use (`.`) operator
  print(account.balance);

  account.deposit(100);
  print(account.balance); // will return 100

  account.withdraw(50);
  print(account.balance); // will return 50
}
```

**Constructor**

Constructor to initialize member/property of class

```dart
class BankAccount {
    const BankAccount(this.balance): this.balance = balance;

    double balance;
}

class BankAccount2 {
    const BankAccount({
        this.balance = 0, 
        required this.accountHolder,
    }): this.balance = balance;

    double balance;
    String accountHolder;
}

....
final account = BankAccount(250);
final account2 = BankAccount2(balance: 100, accountHolder: 'Wisnu');
print(account.balance); // will return 250
```

**Immutable Class**

Immutable data that can't be changed after theyve been initialize/introduce. Usually using final every property class to make immutable class.

```dart
class Person {
    final String name;
    final int age;

    const Person({required this.name, required this.age});
}
```

**Named Constructor**

Named Constructor giving your constructors different names allows your class to ahve many constructors and also to better represent their use caes outside of the class.

```dart
class Complex {
    const Complex(this.re, this.im);
    const Complex.zero() : re = 0, im = 0;
    const Complex.indentity() : re = 1, im = 0;
    const Complex.real(this.re) : im = 0;

    final double re;
    final double im;
}
// ...
Complex(2,4);
Complex.zero();
Complex.real(12);
```

**Static Method**

The static keyword is used for memory management of global data members. The static keyword can be applied to the fields and methods of a class. 

The static variables belong to the class instead of a specific instance. A static variable is common to all instances of a class: this means only a single copy of the static variable is shared among all the instances of a class. The memory allocation for static variables happens only once in the class area at the time of class loading.

```dart
class Strings {
    static String welcome = 'Welcome';

    static void hi() => print('Hi');
}

// ....
print(Strings.welcome);
Strings.hi();
```

**Private Variable/Method**

To make private add prefix underscore (`_`) at variable name/method. When use private variable/method it will only accessible in same file only.

```dart
class BankAccount {
  double _balance = 0;

  void _calculate() {
    // some statement
  }
}
```

**Subclassing**

Subclassing in dart is extend the functionality of an existing class & increase code reuse.

```dart
class Animal {
    void sleep() => print("sleep");
}

class Dog extends Animal {
    void bark() => print('bark');
}

void main(){
    final animal = Animal();
    final dog = Dog();

    animal.sleep();

    dog.bark();
    // The dog class still have `sleep()` function from parent Animal class
    dog.sleep();
}
```

**Overriding Method**

Override method to replace implementation of a method in the super class with a more specialized version.

```dart
class Animal {
  void sleep() => print("sleep");
}

class Dog extends Animal {
  void bark() => print('bark');

  // must use `override` keyword
  @override
  void sleep() {
    print('dog: sleep');
  }
}

Dog().sleep();  // print "dog: sleep"
```

**Abstract Class**

An Abstract class in Dart is defined as those classes which contain one or more than one abstract method (methods without implementation) in them. Whereas, to declare an abstract class we make use of the abstract keyword. So, it must be noted that a class declared abstract may or may not include abstract methods but if it includes an abstract method then it must be an abstract class.

```dart
void main() {
  // Cannot create instance with abstract class
  // final shape = Shape();

  final square = Square(20);
  print(square.area);
}

abstract class Shape {
  double get area;
}

class Square extends Shape {
  final double side;

  Square(this.side);

  @override
  double get area => side * side;
}
```

**toString method**

`toString()` a string representation of object.

```dart
class Square {
  final double side;

  Square(this.side);

  @override
  String toString() => 'Square( side: $side )';
}

//...
print(Square(12)); // print Square( side: 12 )

// when without set toString will return instance of ...
print(Square(12)); // print Instance of 'Square'
```

**Object Equality**

By default Dart doesn't know how to compare instance of object/class. Unless we tell it how to do it with the equality operator.

```dart
void main() {
  print(PointWithoutEquality(12, 12) == PointWithoutEquality(12, 12)); // false
  
  print(PointWithEquality(12, 12) == PointWithEquality(12, 12)); // true
}

class PointWithoutEquality {
  final double x;
  final double y;

  PointWithoutEquality(this.x, this.y);
}

class PointWithEquality {
  final double x;
  final double y;

  PointWithEquality(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (other is PointWithEquality) {
      return x == other.x && y == other.y;
    }
    return false;
  }
}
```

**Generic Class**

Generic class give you more reusable, and this is very common with functional operators like map, where, reduce and many more.

```dart
class Stack<T> {
  final List<T> _items = [];

  void push(T item) => _items.add(item);

  T pop() => _items.removeLast();
}

void main() {
  final stack = Stack<int>();
  stack.push(1);
  stack.push(2);
  print(stack.pop());
  print(stack.pop());
  final names = Stack<String>();
  names.push('Andrea');
  names.push('Alice');
}
```

**CopyWith**

The primary benefit of using `copyWith()` is that you don't mutate the original object, but instead return a new object with the same properties as the original, but with the values you specify. This allows you to create applications that are easier to test and easier to maintain as objects themselves don't harbor mutable state.

```dart
class Credentials {
  const Credentials({this.email = '', this.password = ''});
  final String email;
  final String password;

  Credentials copyWith({
    String? email,
    String? password,
  }) {
    return Credentials(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  String toString() => 'Credentials($email, $password)';
}

void main() {
  const credentials = Credentials();
  //credentials.email = 'me@example.com';
  final updated1 = credentials.copyWith(email: 'me@example.com');
  print(updated1);
  final updated2 = updated1.copyWith(password: 'too-easy');
  print(updated2);
}
```

## Mixin and Extensions

Make extends the functionality of existing types/calsses.

**Mixins**

- Dart classes can extend only one class
- Mixins solve this problem -> add functionality and reuse code in your classes

```dart
mixin Swimming {
  void swim() => print('swimming');
}

class Animal {
  void breathe() => print("breathing");
}

class Fish extends Animal with Swimming {}

void main() {
  final fish = Fish();
  fish.swim();
}
```

Drawback of Mixin:

- Mixin can't have constructors
- Mixin can lead to name collisions

**Extensions**

- Add functionality to existing classes, without modifying them
- Great when extending classes in the Dart/Flutter SDK or 3rd party libraries

## Error Handling

**Errors vs Exceptions**

Error:

- Programmer mistake (we did something wrong)
- Calling a function with invalid arguments, index out of bouds etc
- Program should terminate immediately (not safe to recover)

Exception:

- Failure condition: something unexpected happened
- Unexpected: out of our control
- Handle it (e.g show message to user) and recover

**Assertion**

Assertions make it easier to diagnose and fix programming errors in your code.

How to using assertion: `assert(condition, message)`.

```dart
const value = -1;

// The message is optional to add
assert(value >= 0, 'Value cannot be negative');
```

**Example Try Catch**

```dart
void doSomething(int value) {
  if (value == 0) throw Exception('Invalid Value 0');

  print('Success');
}

void main() {
  try {
    doSomething(0);
  } catch (error) {
    print(error);
  } finally {
    print('Yeay.. all operation is done');
  }
}
```

## References

- [The Complete Dart Language Guide for Beginners and Beyond](https://www.udemy.com/course/complete-dart-guide)
- [Null Safety](https://dart.dev/null-safety)
- [Constructors in Dart](https://www.freecodecamp.org/news/constructors-in-dart/)
- [Dart Static Keyword](https://www.geeksforgeeks.org/dart-static-keyword/)
- [Abstract Class In Dart](https://www.geeksforgeeks.org/abstract-classes-in-dart/)
