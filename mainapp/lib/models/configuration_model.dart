part of 'models.dart';

class ConfigurationModel {
  final String id; //auto
  final Department department; //enum
  final String course; //input
  final String specialization; //input
  final String courseCode; //input
  final String hoi; //input
  final String facultyCoordinator; //input
  final List<String?> studentList; // auto
  final GraduationStatus status; // enum

  ConfigurationModel({
    required this.id,
    required this.department,
    required this.course,
    required this.specialization,
    required this.courseCode,
    required this.hoi,
    required this.facultyCoordinator,
    required this.studentList,
    required this.status,
  });

  factory ConfigurationModel.fromAppwrite(Document doc) => ConfigurationModel(
        id: doc.$id,
        department:
            Department.values.byName(doc.data['department'].toLowerCase()),
        course: doc.data['course'],
        specialization: doc.data['specialization'],
        courseCode: doc.data['courseCode'],
        hoi: doc.data['hoi'],
        facultyCoordinator: doc.data['facultyCoordinator'],
        studentList: (doc.data['studentList'] as List).cast<String>(),
        status: GraduationStatus.values
            .byName(doc.data['graduateStatus'].toLowerCase()),
      );

  ConfigurationModel copyWith({
    String? id,
    Department? department,
    String? course,
    String? specialization,
    String? courseCode,
    String? hoi,
    String? facultyCoordinator,
    List<String?>? studentList,
    GraduationStatus? status,
  }) {
    return ConfigurationModel(
      id: id ?? this.id,
      department: department ?? this.department,
      course: course ?? this.course,
      specialization: specialization ?? this.specialization,
      courseCode: courseCode ?? this.courseCode,
      hoi: hoi ?? this.hoi,
      facultyCoordinator: facultyCoordinator ?? this.facultyCoordinator,
      studentList: studentList ?? this.studentList,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'department': department.name,
      'course': course,
      'specialization': specialization,
      'courseCode': courseCode,
      'hoi': hoi,
      'facultyCoordinator': facultyCoordinator,
      'studentList': studentList,
      'status': status.name,
    };
  }

  factory ConfigurationModel.fromMap(Map<String, dynamic> map) {
    return ConfigurationModel(
      id: map['id'] ?? '',
      department: Department.values.byName(map['position']),
      course: map['course'] ?? '',
      specialization: map['specialization'] ?? '',
      courseCode: map['courseCode'] ?? '',
      hoi: map['hoi'] ?? '',
      facultyCoordinator: map['facultyCoordinator'] ?? '',
      studentList: List<String?>.from((map['studentList'] as List<String?>)),
      status: GraduationStatus.values.byName(map['status']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ConfigurationModel.fromJson(String source) =>
      ConfigurationModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ConfigurationModel(id: $id, department: ${department.name}, course: $course, specialization: $specialization, courseCode: $courseCode, hoi: $hoi, facultyCoordinator: $facultyCoordinator, studentList: $studentList, status: ${status.name})';
  }

  @override
  bool operator ==(covariant ConfigurationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.department == department &&
        other.course == course &&
        other.specialization == specialization &&
        other.courseCode == courseCode &&
        other.hoi == hoi &&
        other.facultyCoordinator == facultyCoordinator &&
        other.studentList == studentList &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        department.hashCode ^
        course.hashCode ^
        specialization.hashCode ^
        courseCode.hashCode ^
        hoi.hashCode ^
        facultyCoordinator.hashCode ^
        studentList.hashCode ^
        status.hashCode;
  }
}
