class EmployeeSkill {
  String? empId;
  String? employeeName;
  String? skill;

  EmployeeSkill(this.empId, this.employeeName, this.skill);

  Map<String, dynamic> toJson() =>
      {'empId': empId, 'employeeName': employeeName, 'skill': skill};

  EmployeeSkill.fromJson(final Map<String, dynamic> data) {
    empId = data['empId'] as String;
    employeeName = data['employeeName'] as String;
    skill = data['skill'] as String;
  }
}
