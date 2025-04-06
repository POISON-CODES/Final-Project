part of 'constants.dart';

enum Role { admin, coordinator, student }

enum Priority { low, medium, high }

enum FieldType { text, file, dropDown, multiSelect }

enum RequestType {
  masterData,
  standardData,
  photo,
  company,
  participate,
  other;

  String get displayName {
    switch (this) {
      case RequestType.masterData:
        return 'Master Data';
      case RequestType.standardData:
        return 'Standard Data';
      case RequestType.photo:
        return 'Photo';
      case RequestType.company:
        return 'Company';
      case RequestType.participate:
        return 'Participate';
      case RequestType.other:
        return 'Other';
    }
  }
}

enum Department {
  abs,
  aiit,
  ait,
  aset,
  asco,
  asl,
  als,
  aibas,
  aila,
  afs,
  rics,
  cii,
  asap,
  asfa,
  aitt,
  aib,
  asft,
  asas
}

enum GraduationStatus { ug, pg, phd }
