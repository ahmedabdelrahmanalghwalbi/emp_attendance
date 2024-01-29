/*
1. `ChangeNotifier`:
   - Example:
     
dart
     import 'package:flutter/foundation.dart';

     class CounterModel extends ChangeNotifier {
       int _count = 0;

       int get count => _count;

       void increment() {
         _count++;
         notifyListeners();
       }
     }
     
   - In this example, we create a `CounterModel` class that extends `ChangeNotifier` and manages a count value.
   - The `increment` method updates the count value and notifies the listeners using `notifyListeners()`.

2. `Provider`:
   - Example:
     
dart
     Provider(
       create: (context) => CounterModel(),
       child: MyApp(),
     );
     
   - In this example, we use the `Provider` widget to provide an instance of `CounterModel` to the `MyApp` widget and its descendants.
   - The `create` parameter is a callback function that creates the instance of `CounterModel`.

3. `Consumer`:
   - Example:
     
dart
     Consumer<CounterModel>(
       builder: (context, counterModel, _) {
         return Text('Count: ${counterModel.count}');
       },
     );
     
   - In this example, we use the `Consumer` widget to consume and react to changes in the `CounterModel` state.
   - The `builder` function is called whenever the state changes, and it receives the context and the current instance of `CounterModel` as arguments.

4. `Selector`:
   - Example:
     
dart
     Selector<CounterModel, int>(
       selector: (context, counterModel) => counterModel.count,
       builder: (context, count, _) {
         return Text('Count: $count');
       },
     );
     
   - In this example, we use the `Selector` widget to select a specific part of the `CounterModel` state (the count value) that our widget depends on.
   - The `selector` function is responsible for extracting the desired part of the state.
   - When the count value changes, only the widget subtree defined inside the `builder` function is rebuilt.

5. `Consumer2`, `Consumer3`, ...:
   - Example:
     
dart
     Consumer2<CounterModel, UserModel>(
       builder: (context, counterModel, userModel, _) {
         return Text('Count: ${counterModel.count}, User: ${userModel.name}');
       },
     );
     
   - In this example, we use the `Consumer2` widget to consume two different state models (`CounterModel` and `UserModel`) at once.
   - The `builder` function receives the context and the current instances of both state models as arguments.

6. `Provider.value`:
   - Example:
     
dart
     CounterModel counterModel = CounterModel();

     Provider.value(
       value: counterModel,
       child: MyApp(),
     );
     
   - In this example, we use the `Provider.value` widget to provide an existing instance of `CounterModel` to the `MyApp` widget and its descendants.
   - The `value` parameter is set to the existing instance of `CounterModel`.

These examples demonstrate how to use the `provider` package for state management in Flutter. Remember, `ChangeNotifier` is used to create state models, `Provider` is used to provide and access the state models, and `Consumer` and `Selector` are used to consume and react to changes in the state
*/