import 'dart:async';

import 'package:emp_attendance/screens/login_screen/login_screen.dart';
import 'package:emp_attendance/services/db_services/employee_service.dart';
import 'package:emp_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService extends ChangeNotifier {
  //intializa instance from supabase client
  final SupabaseClient supabaseClient;
  //intialize instance from the Employee Database Service
  //intialize stream subscription on user authentication state changes
  StreamSubscription? authSubscription;
  //loading variable that represent on the status of loading
  bool _loading = false;

  //- `: supabaseClient = Supabase.instance.client` is the initializer list. It allows you to initialize the attributes of the class with a value or an expression before the constructor body is executed.
  //- `MyClass()` is the constructor method. It is executed when a new object of the `MyClass` class is created.
  //- `: supabaseClient = Supabase.instance.client` is the initializer list. It initializes the `supabaseClient` attribute of the `MyClass` object with the value of `Supabase.instance.client` before the constructor body is executed. This assumes that there is a static method or attribute `instance` defined in the `Supabase` class, and it returns an instance of `SupabaseClient`.
  //- `{ ... }` is the constructor body, enclosed in curly braces. It contains the code that is executed when the constructor is called.
  AuthService() : supabaseClient = Supabase.instance.client {
    //subscription in Receive a notification every time an auth event happens.
    authSubscription = supabaseClient.auth.onAuthStateChange.listen((data) {
      AuthChangeEvent? event = data.event;
      Session? session = data.session;
      //example of listen on certain event
      if (event == AuthChangeEvent.signedIn) {
        // handle signIn
      }
    });
  }

  //unsubscribe from auth subscription
  get cancelSubscription => authSubscription?.cancel();

  //setter to set new values to loading value
  set setBoolValue(bool val) {
    _loading = val;
    notifyListeners();
  }

  //getter of loading value
  bool get loading => _loading;

  //getter for the current user
  User? get currentUser => supabaseClient.auth.currentUser;

  //register method
  Future<void> register(
      {required String email,
      required String password,
      required BuildContext context}) async {
    if (email == "" || password == "") {
      throw ("All Fields are required");
    }
    try {
      setBoolValue = true;
      AuthResponse? response =
          await supabaseClient.auth.signUp(password: password, email: email);
      setBoolValue = false;
      // if register successfully , then i will create new employee inside employee table
      if (response.user != null) {
        await EmployeeService.insertEmployee(
                email: email, id: response.user!.id)
            .then((_) async {
          Utils.showSnackBar("Successfully registered !", context,
              color: Colors.green);
          await login(email: email, password: password, context: context);
          if (context.mounted) {
            Navigator.pop(context);
          }
        });
      }
    } catch (ex) {
      setBoolValue = false;
      if (context.mounted) {
        Utils.showSnackBar(
            "error while register user with email and password", context);
      }
    }
  }

  //login method
  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    if (email == "" || password == "") {
      throw ("All Fields are required");
    }
    try {
      setBoolValue = true;
      AuthResponse response = await supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      setBoolValue = false;
    } catch (ex) {
      setBoolValue = false;
      if (context.mounted) {
        Utils.showSnackBar(
            "error while register user with email and password", context);
      }
    }
  }

  //sign up
  Future<void> signout({required BuildContext context}) async {
    await supabaseClient.auth.signOut();
    //TODO: clear cache and redirect to login screen
    if (context.mounted) {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }
}
