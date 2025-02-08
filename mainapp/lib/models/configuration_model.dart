// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:appwrite/models.dart';
import 'package:mainapp/constants/enums.dart';

class ConfigurationModel {
  final String id;
  final Department department;
  final String course;
  final String specializaiton;
  final String courseCode;
  final String hoi;
  final String facultyCoordinator;
  final List<String?> studentList;
  final GraduationStatus status;

  ConfigurationModel({
    required this.id,
    required this.department,
    required this.course,
    required this.specializaiton,
    required this.courseCode,
    required this.hoi,
    required this.facultyCoordinator,
    required this.studentList,
    required this.status,
  });

  factory ConfigurationModel.fromAppwrite(Document doc) => ConfigurationModel(
        id: doc.$id,
        department: Department.values.byName(doc.data['department']),
        course: doc.data['course'],
        specializaiton: doc.data['specializaiton'],
        courseCode: doc.data['courseCode'],
        hoi: doc.data['hoi'],
        facultyCoordinator: doc.data['facultyCoordinator'],
        studentList: doc.data['studentList'],
        status: GraduationStatus.values.byName(doc.data['graduateStatus']),
      );

  ConfigurationModel copyWith({
    String? id,
    Department? department,
    String? course,
    String? specializaiton,
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
      specializaiton: specializaiton ?? this.specializaiton,
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
      'specializaiton': specializaiton,
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
      specializaiton: map['specializaiton'] ?? '',
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
    return 'ConfigurationModel(id: $id, department: ${department.name}, course: $course, specializaiton: $specializaiton, courseCode: $courseCode, hoi: $hoi, facultyCoordinator: $facultyCoordinator, studentList: $studentList, status: ${status.name})';
  }

  @override
  bool operator ==(covariant ConfigurationModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.department == department &&
        other.course == course &&
        other.specializaiton == specializaiton &&
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
        specializaiton.hashCode ^
        courseCode.hashCode ^
        hoi.hashCode ^
        facultyCoordinator.hashCode ^
        studentList.hashCode ^
        status.hashCode;
  }
}
