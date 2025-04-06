// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'models.dart';

class MasterDataModel {
  final String id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String enrollmentNumber;
  final String batchId;
  final String gender;
  final String phoneNumber;
  final String emailAddress;
  final String collegeLocation;
  final String preferredLocation;
  final String graduationDegree;
  final String graduationSpecialization;
  final String graduationYearOfPassing;
  final String graduationPercentage;
  final String mastersDegree;
  final String mastersSpecialization;
  final String mastersYearOfPassing;
  final String mastersPercentage;
  final String priorExperience;
  final String experienceInMonths;
  final String resumeLink;
  final String technicalWorkLink;
  final String department;
  final DateTime dob;
  final String linkedinProfileLink;
  final String githubProfileLink;
  final String std10thBoard;
  final String std10thPercentage;
  final String std12thBoard;
  final String std12thPercentage;
  final String currentLocation;
  final String permanentLocation;
  final String std10thPassingYear;
  final String std12thPassingYear;
  final String alternatePhoneNumber;
  final String amityEmail;
  final String fathersName;
  final String mothersName;
  final String fathersPhoneNumber;
  final String mothersPhoneNumber;
  final String fathersEmail;
  final String mothersEmail;
  final String activeBackLogs;
  MasterDataModel({
    required this.id,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.enrollmentNumber,
    required this.batchId,
    required this.gender,
    required this.phoneNumber,
    required this.emailAddress,
    required this.collegeLocation,
    required this.preferredLocation,
    required this.graduationDegree,
    required this.graduationSpecialization,
    required this.graduationYearOfPassing,
    required this.graduationPercentage,
    required this.mastersDegree,
    required this.mastersSpecialization,
    required this.mastersYearOfPassing,
    required this.mastersPercentage,
    required this.priorExperience,
    required this.experienceInMonths,
    required this.resumeLink,
    required this.technicalWorkLink,
    required this.department,
    required this.dob,
    required this.linkedinProfileLink,
    required this.githubProfileLink,
    required this.std10thBoard,
    required this.std10thPercentage,
    required this.std12thBoard,
    required this.std12thPercentage,
    required this.currentLocation,
    required this.permanentLocation,
    required this.std10thPassingYear,
    required this.std12thPassingYear,
    required this.alternatePhoneNumber,
    required this.amityEmail,
    required this.fathersName,
    required this.mothersName,
    required this.fathersPhoneNumber,
    required this.mothersPhoneNumber,
    required this.fathersEmail,
    required this.mothersEmail,
    required this.activeBackLogs,
  });

  MasterDataModel copyWith({
    String? id,
    String? firstName,
    String? middleName,
    String? lastName,
    String? enrollmentNumber,
    String? batchId,
    String? gender,
    String? phoneNumber,
    String? emailAddress,
    String? collegeLocation,
    String? preferredLocation,
    String? graduationDegree,
    String? graduationSpecialization,
    String? graduationYearOfPassing,
    String? graduationPercentage,
    String? mastersDegree,
    String? mastersSpecialization,
    String? mastersYearOfPassing,
    String? mastersPercentage,
    String? priorExperience,
    String? experienceInMonths,
    String? resumeLink,
    String? technicalWorkLink,
    String? department,
    DateTime? dob,
    String? linkedinProfileLink,
    String? githubProfileLink,
    String? std10thBoard,
    String? std10thPercentage,
    String? std12thBoard,
    String? std12thPercentage,
    String? currentLocation,
    String? permanentLocation,
    String? std10thPassingYear,
    String? std12thPassingYear,
    String? alternatePhoneNumber,
    String? amityEmail,
    String? fathersName,
    String? mothersName,
    String? fathersPhoneNumber,
    String? mothersPhoneNumber,
    String? fathersEmail,
    String? mothersEmail,
    String? activeBackLogs,
  }) {
    return MasterDataModel(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      enrollmentNumber: enrollmentNumber ?? this.enrollmentNumber,
      batchId: batchId ?? this.batchId,
      gender: gender ?? this.gender,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      emailAddress: emailAddress ?? this.emailAddress,
      collegeLocation: collegeLocation ?? this.collegeLocation,
      preferredLocation: preferredLocation ?? this.preferredLocation,
      graduationDegree: graduationDegree ?? this.graduationDegree,
      graduationSpecialization:
          graduationSpecialization ?? this.graduationSpecialization,
      graduationYearOfPassing:
          graduationYearOfPassing ?? this.graduationYearOfPassing,
      graduationPercentage: graduationPercentage ?? this.graduationPercentage,
      mastersDegree: mastersDegree ?? this.mastersDegree,
      mastersSpecialization:
          mastersSpecialization ?? this.mastersSpecialization,
      mastersYearOfPassing: mastersYearOfPassing ?? this.mastersYearOfPassing,
      mastersPercentage: mastersPercentage ?? this.mastersPercentage,
      priorExperience: priorExperience ?? this.priorExperience,
      experienceInMonths: experienceInMonths ?? this.experienceInMonths,
      resumeLink: resumeLink ?? this.resumeLink,
      technicalWorkLink: technicalWorkLink ?? this.technicalWorkLink,
      department: department ?? this.department,
      dob: dob ?? this.dob,
      linkedinProfileLink: linkedinProfileLink ?? this.linkedinProfileLink,
      githubProfileLink: githubProfileLink ?? this.githubProfileLink,
      std10thBoard: std10thBoard ?? this.std10thBoard,
      std10thPercentage: std10thPercentage ?? this.std10thPercentage,
      std12thBoard: std12thBoard ?? this.std12thBoard,
      std12thPercentage: std12thPercentage ?? this.std12thPercentage,
      currentLocation: currentLocation ?? this.currentLocation,
      permanentLocation: permanentLocation ?? this.permanentLocation,
      std10thPassingYear: std10thPassingYear ?? this.std10thPassingYear,
      std12thPassingYear: std12thPassingYear ?? this.std12thPassingYear,
      alternatePhoneNumber: alternatePhoneNumber ?? this.alternatePhoneNumber,
      amityEmail: amityEmail ?? this.amityEmail,
      fathersName: fathersName ?? this.fathersName,
      mothersName: mothersName ?? this.mothersName,
      fathersPhoneNumber: fathersPhoneNumber ?? this.fathersPhoneNumber,
      mothersPhoneNumber: mothersPhoneNumber ?? this.mothersPhoneNumber,
      fathersEmail: fathersEmail ?? this.fathersEmail,
      mothersEmail: mothersEmail ?? this.mothersEmail,
      activeBackLogs: activeBackLogs ?? this.activeBackLogs,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'enrollmentNumber': enrollmentNumber,
      'batchId': batchId,
      'gender': gender,
      'phoneNumber': phoneNumber,
      'emailAddress': emailAddress,
      'collegeLocation': collegeLocation,
      'preferredLocation': preferredLocation,
      'graduationDegree': graduationDegree,
      'graduationSpecialization': graduationSpecialization,
      'graduationYearOfPassing': graduationYearOfPassing,
      'graduationPercentage': graduationPercentage,
      'mastersDegree': mastersDegree,
      'mastersSpecialization': mastersSpecialization,
      'mastersYearOfPassing': mastersYearOfPassing,
      'mastersPercentage': mastersPercentage,
      'priorExperience': priorExperience,
      'experienceInMonths': experienceInMonths,
      'resumeLink': resumeLink,
      'technicalWorkLink': technicalWorkLink,
      'department': department,
      'dob': dob.millisecondsSinceEpoch,
      'linkedinProfileLink': linkedinProfileLink,
      'githubProfileLink': githubProfileLink,
      'std10thBoard': std10thBoard,
      'std10thPercentage': std10thPercentage,
      'std12thBoard': std12thBoard,
      'std12thPercentage': std12thPercentage,
      'currentLocation': currentLocation,
      'permanentLocation': permanentLocation,
      'std10thPassingYear': std10thPassingYear,
      'std12thPassingYear': std12thPassingYear,
      'alternatePhoneNumber': alternatePhoneNumber,
      'amityEmail': amityEmail,
      'fathersName': fathersName,
      'mothersName': mothersName,
      'fathersPhoneNumber': fathersPhoneNumber,
      'mothersPhoneNumber': mothersPhoneNumber,
      'fathersEmail': fathersEmail,
      'mothersEmail': mothersEmail,
      'activeBackLogs': activeBackLogs,
    };
  }

  factory MasterDataModel.fromMap(Map<String, dynamic> map) {
    return MasterDataModel(
      id: map['id'] as String,
      firstName: map['firstName'] as String,
      middleName: map['middleName'] as String,
      lastName: map['lastName'] as String,
      enrollmentNumber: map['enrollmentNumber'] as String,
      batchId: map['batchId'] as String,
      gender: map['gender'] as String,
      phoneNumber: map['phoneNumber'] as String,
      emailAddress: map['emailAddress'] as String,
      collegeLocation: map['collegeLocation'] as String,
      preferredLocation: map['preferredLocation'] as String,
      graduationDegree: map['graduationDegree'] as String,
      graduationSpecialization: map['graduationSpecialization'] as String,
      graduationYearOfPassing: map['graduationYearOfPassing'] as String,
      graduationPercentage: map['graduationPercentage'] as String,
      mastersDegree: map['mastersDegree'] as String,
      mastersSpecialization: map['mastersSpecialization'] as String,
      mastersYearOfPassing: map['mastersYearOfPassing'] as String,
      mastersPercentage: map['mastersPercentage'] as String,
      priorExperience: map['priorExperience'] as String,
      experienceInMonths: map['experienceInMonths'] as String,
      resumeLink: map['resumeLink'] as String,
      technicalWorkLink: map['technicalWorkLink'] as String,
      department: map['department'] as String,
      dob: DateTime.fromMillisecondsSinceEpoch(map['dob'] as int),
      linkedinProfileLink: map['linkedinProfileLink'] as String,
      githubProfileLink: map['githubProfileLink'] as String,
      std10thBoard: map['std10thBoard'] as String,
      std10thPercentage: map['std10thPercentage'] as String,
      std12thBoard: map['std12thBoard'] as String,
      std12thPercentage: map['std12thPercentage'] as String,
      currentLocation: map['currentLocation'] as String,
      permanentLocation: map['permanentLocation'] as String,
      std10thPassingYear: map['std10thPassingYear'] as String,
      std12thPassingYear: map['std12thPassingYear'] as String,
      alternatePhoneNumber: map['alternatePhoneNumber'] as String,
      amityEmail: map['amityEmail'] as String,
      fathersName: map['fathersName'] as String,
      mothersName: map['mothersName'] as String,
      fathersPhoneNumber: map['fathersPhoneNumber'] as String,
      mothersPhoneNumber: map['mothersPhoneNumber'] as String,
      fathersEmail: map['fathersEmail'] as String,
      mothersEmail: map['mothersEmail'] as String,
      activeBackLogs: map['activeBackLogs'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory MasterDataModel.fromJson(String source) =>
      MasterDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MasterDataModel(id: $id, firstName: $firstName, middleName: $middleName, lastName: $lastName, enrollmentNumber: $enrollmentNumber, batchId: $batchId, gender: $gender, phoneNumber: $phoneNumber, emailAddress: $emailAddress, collegeLocation: $collegeLocation, preferredLocation: $preferredLocation, graduationDegree: $graduationDegree, graduationSpecialization: $graduationSpecialization, graduationYearOfPassing: $graduationYearOfPassing, graduationPercentage: $graduationPercentage, mastersDegree: $mastersDegree, mastersSpecialization: $mastersSpecialization, mastersYearOfPassing: $mastersYearOfPassing, mastersPercentage: $mastersPercentage, priorExperience: $priorExperience, experienceInMonths: $experienceInMonths, resumeLink: $resumeLink, technicalWorkLink: $technicalWorkLink, department: $department, dob: $dob, linkedinProfileLink: $linkedinProfileLink, githubProfileLink: $githubProfileLink, std10thBoard: $std10thBoard, std10thPercentage: $std10thPercentage, std12thBoard: $std12thBoard, std12thPercentage: $std12thPercentage, currentLocation: $currentLocation, permanentLocation: $permanentLocation, std10thPassingYear: $std10thPassingYear, std12thPassingYear: $std12thPassingYear, alternatePhoneNumber: $alternatePhoneNumber, amityEmail: $amityEmail, fathersName: $fathersName, mothersName: $mothersName, fathersPhoneNumber: $fathersPhoneNumber, mothersPhoneNumber: $mothersPhoneNumber, fathersEmail: $fathersEmail, mothersEmail: $mothersEmail, activeBackLogs: $activeBackLogs)';
  }

  @override
  bool operator ==(covariant MasterDataModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.firstName == firstName &&
        other.middleName == middleName &&
        other.lastName == lastName &&
        other.enrollmentNumber == enrollmentNumber &&
        other.batchId == batchId &&
        other.gender == gender &&
        other.phoneNumber == phoneNumber &&
        other.emailAddress == emailAddress &&
        other.collegeLocation == collegeLocation &&
        other.preferredLocation == preferredLocation &&
        other.graduationDegree == graduationDegree &&
        other.graduationSpecialization == graduationSpecialization &&
        other.graduationYearOfPassing == graduationYearOfPassing &&
        other.graduationPercentage == graduationPercentage &&
        other.mastersDegree == mastersDegree &&
        other.mastersSpecialization == mastersSpecialization &&
        other.mastersYearOfPassing == mastersYearOfPassing &&
        other.mastersPercentage == mastersPercentage &&
        other.priorExperience == priorExperience &&
        other.experienceInMonths == experienceInMonths &&
        other.resumeLink == resumeLink &&
        other.technicalWorkLink == technicalWorkLink &&
        other.department == department &&
        other.dob == dob &&
        other.linkedinProfileLink == linkedinProfileLink &&
        other.githubProfileLink == githubProfileLink &&
        other.std10thBoard == std10thBoard &&
        other.std10thPercentage == std10thPercentage &&
        other.std12thBoard == std12thBoard &&
        other.std12thPercentage == std12thPercentage &&
        other.currentLocation == currentLocation &&
        other.permanentLocation == permanentLocation &&
        other.std10thPassingYear == std10thPassingYear &&
        other.std12thPassingYear == std12thPassingYear &&
        other.alternatePhoneNumber == alternatePhoneNumber &&
        other.amityEmail == amityEmail &&
        other.fathersName == fathersName &&
        other.mothersName == mothersName &&
        other.fathersPhoneNumber == fathersPhoneNumber &&
        other.mothersPhoneNumber == mothersPhoneNumber &&
        other.fathersEmail == fathersEmail &&
        other.mothersEmail == mothersEmail &&
        other.activeBackLogs == activeBackLogs;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        middleName.hashCode ^
        lastName.hashCode ^
        enrollmentNumber.hashCode ^
        batchId.hashCode ^
        gender.hashCode ^
        phoneNumber.hashCode ^
        emailAddress.hashCode ^
        collegeLocation.hashCode ^
        preferredLocation.hashCode ^
        graduationDegree.hashCode ^
        graduationSpecialization.hashCode ^
        graduationYearOfPassing.hashCode ^
        graduationPercentage.hashCode ^
        mastersDegree.hashCode ^
        mastersSpecialization.hashCode ^
        mastersYearOfPassing.hashCode ^
        mastersPercentage.hashCode ^
        priorExperience.hashCode ^
        experienceInMonths.hashCode ^
        resumeLink.hashCode ^
        technicalWorkLink.hashCode ^
        department.hashCode ^
        dob.hashCode ^
        linkedinProfileLink.hashCode ^
        githubProfileLink.hashCode ^
        std10thBoard.hashCode ^
        std10thPercentage.hashCode ^
        std12thBoard.hashCode ^
        std12thPercentage.hashCode ^
        currentLocation.hashCode ^
        permanentLocation.hashCode ^
        std10thPassingYear.hashCode ^
        std12thPassingYear.hashCode ^
        alternatePhoneNumber.hashCode ^
        amityEmail.hashCode ^
        fathersName.hashCode ^
        mothersName.hashCode ^
        fathersPhoneNumber.hashCode ^
        mothersPhoneNumber.hashCode ^
        fathersEmail.hashCode ^
        mothersEmail.hashCode ^
        activeBackLogs.hashCode;
  }
}
