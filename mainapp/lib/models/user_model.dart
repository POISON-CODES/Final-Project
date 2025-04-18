part of 'models.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final Role role;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool masterDataFilled;
  final List<String>? companies;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.role,
    required this.createdAt,
    required this.updatedAt,
    this.masterDataFilled = false,
    this.companies,
  });

  // factory UserModel.fromAppwrite(User user) {
  //   return UserModel(
  //     id: user.$id,
  //     name: user.name,
  //     email: user.email,
  //     phoneNumber: '', // Default empty string if not available
  //     role: Role.values.byName(user.role),
  //     createdAt: DateTime.parse(user.$createdAt),
  //     updatedAt: DateTime.parse(user.$updatedAt),
  //   );
  // }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    Role? role,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? masterDataFilled,
    List<String>? companies,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      masterDataFilled: masterDataFilled ?? this.masterDataFilled,
      companies: companies ?? this.companies,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone_number': phoneNumber,
      'role': role.toString().split('.').last,
      'master_data_filled': masterDataFilled,
      'companies': companies,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['\$id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      role: Role.values.byName(map['role']),
      createdAt: DateTime.parse(map['\$createdAt']),
      updatedAt: DateTime.parse(map['\$updatedAt']),
      masterDataFilled: map['masterDataFilled'] ?? false,
      companies:
          map['companies'] != null ? List<String>.from(map['companies']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber, role: $role, createdAt: $createdAt, updatedAt: $updatedAt, masterDataFilled: $masterDataFilled, companies: $companies)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber &&
        other.role == role &&
        other.createdAt == createdAt &&
        other.updatedAt == updatedAt &&
        other.masterDataFilled == masterDataFilled &&
        listEquals(other.companies, companies);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        phoneNumber.hashCode ^
        role.hashCode ^
        createdAt.hashCode ^
        updatedAt.hashCode ^
        masterDataFilled.hashCode ^
        (companies?.hashCode ?? 0);
  }
}
