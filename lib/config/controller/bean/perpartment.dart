class PerDepartment {
  PerDepartment({
     this.id,
     this.departmentName,
     this.parentDepartmentID,
     this.status,
  });

  factory PerDepartment.fromJson(Map json) {
    return PerDepartment(
      id: json['id'],
      departmentName: json['DepartmentName'],
      parentDepartmentID: json['ParentDepartmentID'],
      status: json['status'],
    );
  }

  final int? id;
  final String? departmentName;
  final int?parentDepartmentID;
  final int?status;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'DepartmentName': departmentName,
      'ParentDepartmentID': parentDepartmentID,
      'status': status,
    };
  }

  PerDepartment copyWith({
    int? id,
    String? departmentName,
    int? parentDepartmentID,
    int? status,
  }) {
    return PerDepartment(
      id: id ?? this.id,
      departmentName: departmentName ?? this.departmentName,
      parentDepartmentID: parentDepartmentID ?? this.parentDepartmentID,
      status: status ?? this.status,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PerDepartment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          departmentName == other.departmentName &&
          parentDepartmentID == other.parentDepartmentID &&
          status == other.status;

  @override
  int get hashCode => Object.hashAll([
        id,
        departmentName,
        parentDepartmentID,
        status,
      ]);
}
