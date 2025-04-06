part of 'models.dart';

class UserDetailModel {
  final String id;
  final String enrollmentNumber;
  final String firstName;
  final String middleName;
  final String lastName;
  final String batchId;
  final String gender;
  final String phoneNumber;
  final String emailAddress;
  final String collegeLocation;
  final List<String> preferredLocation;
  final String std10Percentage;
  final String std12Percentage;
  final String graduationDegree;
  final String graduationSpecialization;
  final String graduationYearOfPassing;
  final String graduationPercentage;
  final String mastersDegree;
  final String mastersSpecialization;
  final String mastersYearOfPassout;
  final String mastersPercentage;
  final bool priorExperience;
  final int experienceInMonths;
  final String resumeLink;
  final String technicalWorkLink;
  final List<String> positionApplied;
  final Department department;

  UserDetailModel({
    required this.id,
    required this.enrollmentNumber,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.batchId,
    required this.gender,
    required this.phoneNumber,
    required this.emailAddress,
    required this.collegeLocation,
    required this.preferredLocation,
    required this.std10Percentage,
    required this.std12Percentage,
    required this.graduationDegree,
    required this.graduationSpecialization,
    required this.graduationYearOfPassing,
    required this.graduationPercentage,
    required this.mastersDegree,
    required this.mastersSpecialization,
    required this.mastersYearOfPassout,
    required this.mastersPercentage,
    required this.priorExperience,
    required this.experienceInMonths,
    required this.resumeLink,
    required this.technicalWorkLink,
    required this.positionApplied,
    required this.department,
  });

  UserDetailModel copyWith({
    String? id,
    String? enrollmentNumber,
    String? firstName,
    String? middleName,
    String? lastName,
    String? batchId,
    String? gender,
    String? phoneNumber,
    String? emailAddress,
    String? collegeLocation,
    List<String>? preferredLocation,
    String? std10Percentage,
    String? std12Percentage,
    String? graduationDegree,
    String? graduationSpecialization,
    String? graduationYearOfPassing,
    String? graduationPercentage,
    String? mastersDegree,
    String? mastersSpecialization,
    String? mastersYearOfPassout,
    String? mastersPercentage,
    bool? priorExperience,
    int? experienceInMonths,
    String? resumeLink,
    String? technicalWorkLink,
    List<String>? positionApplied,
    Department? department,
  }) {
    return UserDetailModel(
      id: id ?? this.id,
      enrollmentNumber: enrollmentNumber ?? this.enrollmentNumber,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      batchId: batchId ?? this.batchId,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      collegeLocation: collegeLocation ?? this.collegeLocation,
      preferredLocation: preferredLocation ?? this.preferredLocation,
      std10Percentage: std10Percentage ?? this.std10Percentage,
      std12Percentage: std12Percentage ?? this.std12Percentage,
      graduationDegree: graduationDegree ?? this.graduationDegree,
      graduationSpecialization:
          graduationSpecialization ?? this.graduationSpecialization,
      graduationYearOfPassing:
          graduationYearOfPassing ?? this.graduationYearOfPassing,
      graduationPercentage: graduationPercentage ?? this.graduationPercentage,
      mastersDegree: mastersDegree ?? this.mastersDegree,
      mastersSpecialization:
          mastersSpecialization ?? this.mastersSpecialization,
      mastersYearOfPassout: mastersYearOfPassout ?? this.mastersYearOfPassout,
      mastersPercentage: mastersPercentage ?? this.mastersPercentage,
      priorExperience: priorExperience ?? this.priorExperience,
      experienceInMonths: experienceInMonths ?? this.experienceInMonths,
      resumeLink: resumeLink ?? this.resumeLink,
      technicalWorkLink: technicalWorkLink ?? this.technicalWorkLink,
      positionApplied: positionApplied ?? this.positionApplied,
      department: department ?? this.department,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'enrollmentNumber': enrollmentNumber,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'batchId': batchId,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,
      'collegeLocation': collegeLocation,
      'preferredLocation': preferredLocation,
      'std10Percentage': std10Percentage,
      'std12Percentage': std12Percentage,
      'graduationDegree': graduationDegree,
      'graduationSpecialization': graduationSpecialization,
      'graduationYearOfPassing': graduationYearOfPassing,
      'graduationPercentage': graduationPercentage,
      'mastersDegree': mastersDegree,
      'mastersSpecialization': mastersSpecialization,
      'mastersYearOfPassout': mastersYearOfPassout,
      'mastersPercentage': mastersPercentage,
      'priorExperience': priorExperience,
      'experienceInMonths': experienceInMonths,
      'resumeLink': resumeLink,
      'technicalWorkLink': technicalWorkLink,
      'positionApplied': positionApplied,
      'department': department.name,
    };
  }

  factory UserDetailModel.fromMap(Map<String, dynamic> map) {
    return UserDetailModel(
      id: map['id'] ?? '',
      enrollmentNumber: map['enrollmentNumber'] ?? '',
      firstName: map['firstName'] ?? '',
      middleName: map['middleName'] ?? '',
      lastName: map['lastName'] ?? '',
      batchId: map['batchId'] ?? '',
      gender: map['gender'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      emailAddress: map['emailAddress'] ?? '',
      collegeLocation: map['collegeLocation'] ?? '',
      preferredLocation: List<String>.from(map['preferredLocation'] ?? []),
      std10Percentage: map['std10Percentage'] ?? '',
      std12Percentage: map['std12Percentage'] ?? '',
      graduationDegree: map['graduationDegree'] ?? '',
      graduationSpecialization: map['graduationSpecialization'] ?? '',
      graduationYearOfPassing: map['graduationYearOfPassing'] ?? '',
      graduationPercentage: map['graduationPercentage'] ?? '',
      mastersDegree: map['mastersDegree'] ?? '',
      mastersSpecialization: map['mastersSpecialization'] ?? '',
      mastersYearOfPassout: map['mastersYearOfPassout'] ?? '',
      mastersPercentage: map['mastersPercentage'] ?? '',
      priorExperience: map['priorExperience'] ?? false,
      experienceInMonths: map['experienceInMonths'] ?? 0,
      resumeLink: map['resumeLink'] ?? '',
      technicalWorkLink: map['technicalWorkLink'] ?? '',
      positionApplied: List<String>.from(map['positionApplied'] ?? []),
      department: Department.values.byName(map['department'] ?? ''),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserDetailModel.fromJson(String source) =>
      UserDetailModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserDetailModel(id: $id, enrollmentNumber: $enrollmentNumber, firstName: $firstName, middleName: $middleName, lastName: $lastName, batchId: $batchId, gender: $gender, phoneNumber: $phoneNumber, emailAddress: $emailAddress, collegeLocation: $collegeLocation, preferredLocation: $preferredLocation, std10Percentage: $std10Percentage, std12Percentage: $std12Percentage, graduationDegree: $graduationDegree, graduationSpecialization: $graduationSpecialization, graduationYearOfPassing: $graduationYearOfPassing, graduationPercentage: $graduationPercentage, mastersDegree: $mastersDegree, mastersSpecialization: $mastersSpecialization, mastersYearOfPassout: $mastersYearOfPassout, mastersPercentage: $mastersPercentage, priorExperience: $priorExperience, experienceInMonths: $experienceInMonths, resumeLink: $resumeLink, technicalWorkLink: $technicalWorkLink, positionApplied: $positionApplied, department: $department)';
  }

  @override
  bool operator ==(covariant UserDetailModel other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;

    return other.id == id &&
        other.enrollmentNumber == enrollmentNumber &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.batchId == batchId &&
        other.gender == gender &&
        other.phoneNumber == phoneNumber &&
        other.emailAddress == emailAddress &&
        other.collegeLocation == collegeLocation &&
        listEquals(other.preferredLocation, preferredLocation) &&
        other.std10Percentage == std10Percentage &&
        other.std12Percentage == std12Percentage &&
        other.graduationDegree == graduationDegree &&
        other.graduationSpecialization == graduationSpecialization &&
        other.graduationYearOfPassing == graduationYearOfPassing &&
        other.graduationPercentage == graduationPercentage &&
        other.mastersDegree == mastersDegree &&
        other.mastersSpecialization == mastersSpecialization &&
        other.mastersYearOfPassout == mastersYearOfPassout &&
        other.mastersPercentage == mastersPercentage &&
        other.priorExperience == priorExperience &&
        other.experienceInMonths == experienceInMonths &&
        other.resumeLink == resumeLink &&
        other.technicalWorkLink == technicalWorkLink &&
        listEquals(other.positionApplied, positionApplied) &&
        other.department == department;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        enrollmentNumber.hashCode ^
        firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        batchId.hashCode ^
        gender.hashCode ^
        phoneNumber.hashCode ^
        emailAddress.hashCode ^
        collegeLocation.hashCode ^
        preferredLocation.hashCode ^
        std10Percentage.hashCode ^
        std12Percentage.hashCode ^
        graduationDegree.hashCode ^
        graduationSpecialization.hashCode ^
        graduationYearOfPassing.hashCode ^
        graduationPercentage.hashCode ^
        mastersDegree.hashCode ^
        mastersSpecialization.hashCode ^
        mastersYearOfPassout.hashCode ^
        mastersPercentage.hashCode ^
        priorExperience.hashCode ^
        experienceInMonths.hashCode ^
        resumeLink.hashCode ^
        technicalWorkLink.hashCode ^
        positionApplied.hashCode ^
        department.hashCode;
  }
}
