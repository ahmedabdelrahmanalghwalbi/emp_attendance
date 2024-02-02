import 'package:emp_attendance/config/managers/string_manager.dart';
import 'package:emp_attendance/models/employee_model.dart';
import 'package:emp_attendance/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class EmployeeService extends ChangeNotifier {
  //first initialize supabase db instance
  static final SupabaseClient supabaseClient = Supabase.instance.client;
  EmployeeModel? employee;
  //insert new employee inside employees table
  static Future<void> insertEmployee(
      {required String email, required String id}) async {
    EmployeeModel emp = EmployeeModel(
        id: id, email: email, name: "", employeeId: Utils.generateUniqueId());
    await supabaseClient
        .from(StringManager.employessTable)
        .insert(emp.toJson());
  }

  //get current employee data
  Future<EmployeeModel?> getEmployeeData() async {
    Map<String, dynamic> employeeData = await supabaseClient
        .from(StringManager.employessTable)
        .select()
        .eq('id', supabaseClient.auth.currentUser!.id)
        .single();
    employee = EmployeeModel.fromJson(employeeData);
    return employee;
  }
}
