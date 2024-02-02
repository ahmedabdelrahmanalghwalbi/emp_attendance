import 'package:emp_attendance/models/department_model.dart';
import 'package:emp_attendance/services/auth_service.dart';
import 'package:emp_attendance/services/db_services/employee_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final empService = Provider.of<EmployeeService>(context);
    // Using below conditions because build can be called multiple times
    empService.allDepartments.isEmpty ? empService.getAllDepartments() : null;
    nameController.text.isEmpty
        ? nameController.text = empService.employee?.name ?? ''
        : null;
    return Scaffold(
        body: empService.employee == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        alignment: Alignment.topRight,
                        child: TextButton.icon(
                            onPressed: () {
                              Provider.of<AuthService>(context, listen: false)
                                  .signout(context: context);
                            },
                            icon: const Icon(Icons.logout),
                            label: const Text("Sign Out")),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.redAccent),
                        child: const Center(
                          child: Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text("Employee ID : ${empService.employee?.employeeId}"),
                      const SizedBox(
                        height: 30,
                      ),
                      TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            label: Text("Full name"),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      empService.allDepartments.isEmpty
                          ? const LinearProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: DropdownButtonFormField(
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder()),
                                value: empService.employeeDepartment ??
                                    empService.allDepartments.first.id,
                                items: empService.allDepartments
                                    .map((DepartmentModel item) {
                                  return DropdownMenuItem(
                                      value: item.id,
                                      child: Text(
                                        item.title,
                                        style: const TextStyle(fontSize: 20),
                                      ));
                                }).toList(),
                                onChanged: (selectedValue) {
                                  empService.employeeDepartment = selectedValue;
                                },
                              ),
                            ),
                      const SizedBox(
                        height: 40,
                      ),
                      SizedBox(
                        width: 200,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            empService.updateProfile(
                                nameController.text.trim(), context);
                          },
                          child: const Text(
                            "Update Profile",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ));
  }
}
