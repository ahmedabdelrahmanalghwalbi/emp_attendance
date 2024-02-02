class EmployeeModel {
  String id;
  String email;
  String name;
  int? department;
  String employeeId;

  EmployeeModel(
      {required this.id,
      required this.email,
      required this.name,
      this.department,
      required this.employeeId});

  factory EmployeeModel.fromJson(Map<String, dynamic> data) {
    return EmployeeModel(
        id: data['id'],
        email: data['email'],
        name: data['name'],
        department: data['department'],
        employeeId: data['employee_id']);
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'name': name,
        'department': department,
        'employee_id': employeeId
      };
}
