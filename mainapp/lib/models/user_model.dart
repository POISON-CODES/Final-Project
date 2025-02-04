// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:appwrite/models.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
  });

  factory UserModel.fromAppwrite(User user) {
    return UserModel(
      id: user.$id,
      name: user.name,
      email: user.email,
      phoneNumber: user.phone,
    );
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? "",
      name: map['name'] ?? "",
      email: map['email'] ?? "",
      phoneNumber: map['phoneNumber'] ?? "",
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, email: $email, phoneNumber: $phoneNumber,)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.email == email &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ email.hashCode ^ phoneNumber.hashCode;
  }
}
