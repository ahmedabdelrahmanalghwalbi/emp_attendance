/*
1. Constructors in Dart:
   - Constructors are special methods that are used to create and initialize objects of a class.
   - They have the same name as the class and do not have a return type, not even `void`.
   - Constructors are called automatically when an object is created using the `new` keyword or using constructor cascading.

2. Default Constructor:
   - If you don't define any constructors in a class, Dart provides a default constructor.
   - The default constructor takes no arguments and initializes the instance variables with their default values (e.g., `null` for object references, `0` for integers, `false` for booleans).
   - Example:
     
dart
     class Person {
       String name;
       int age;

       // Default constructor
       Person() {
         print('Default constructor');
       }
     }
     
3. Parameterized Constructor:
   - Parameterized constructors allow you to define custom constructors with parameters.
   - You can have multiple parameterized constructors in a class by using named constructors.
   - Example:
     
dart
     class Person {
       String name;
       int age;

       // Parameterized constructor
       Person(this.name, this.age);

       // Named constructor
       Person.fromBirthYear(int birthYear) {
         name = 'Unknown';
         age = DateTime.now().year - birthYear;
       }
     }
     
4. Named Constructor:
   - Named constructors are additional constructors with a unique name.
   - They are useful when you want to provide multiple ways to create objects or when you want to initialize objects differently based on different parameters.
   - Example:
     
dart
     class Person {
       String name;
       int age;

       // Named constructor
       Person.fromBirthYear(int birthYear) {
         name = 'Unknown';
         age = DateTime.now().year - birthYear;
       }
     }
     
5. Redirecting Constructor:
   - A redirecting constructor allows you to redirect the initialization process to another constructor in the same class.
   - It is useful when you want to reuse the initialization logic of another constructor.
   - Example:
     
dart
     class Person {
       String name;
       int age;

       // Redirecting constructor
       Person.fromBirthYear(int birthYear) : this('Unknown', DateTime.now().year - birthYear);

       // Parameterized constructor
       Person(this.name, this.age);
     }
     
6. Constant Constructor:
   - A constant constructor is used to create compile-time constants.
   - It is defined using the `const` keyword before the constructor name.
   - Example:
     
dart
     class Circle {
       final double radius;
       static const double pi = 3.14159;

       // Constant constructor
       const Circle(this.radius);

       double get area => pi * radius * radius;
     }
     
7. Initialization:
   - Instance variables can be initialized in the constructor's parameter list using the `this` keyword or in the constructor's body.
   - Example:
     
dart
     class Person {
       String name;
       int age;

       // Parameterized constructor with initialization in parameter list
       Person(this.name, this.age);

       // Named constructor with initialization in constructor body
       Person.fromBirthYear(int birthYear) {
         name = 'Unknown';
         age = DateTime.now().year - birthYear;
       }
     }
     
*/