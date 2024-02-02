import 'package:emp_attendance/app.dart';
import 'package:emp_attendance/config/managers/string_manager.dart';
import 'package:emp_attendance/services/auth_service.dart';
import 'package:emp_attendance/services/db_services/attendace_service.dart';
import 'package:emp_attendance/services/db_services/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  //WidgetsFlutterBinding. ensureInitialized() is used to ensure that an instance of
  //WidgetsFlutterBinding is initialized before calling runApp().
  //This is a common practice in Flutter applications, especially when you need to call certain methods before running the app
  WidgetsFlutterBinding.ensureInitialized();
  //load .env variables to use it inside applications
  //must import .env file in pubspec.yaml assets to load file successfully
  await dotenv.load();
  //intializing supabase client
  await Supabase.initialize(
    url: dotenv.get(StringManager.projectUrl),
    anonKey: dotenv.get(StringManager.supabaseApiKey),
  );
  //to ensure that all event inside event loop has ended
  await Future.delayed(Duration.zero);

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AuthService()),
      ChangeNotifierProvider(create: (context) => EmployeeService()),
      ChangeNotifierProvider(create: (context) => AttendanceService()),
    ],
    child: const MyApp(),
  ));
}
