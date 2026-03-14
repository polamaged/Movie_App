import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies_app/features/Auth/domain/enities/user_enitiy.dart';

class UserModels extends UserEntity {
  UserModels({
    required super.id,
    required super.name,
    required super.email,
    required super.phoneNumber,
    required super.avatar,
  });

  factory UserModels.fromFirebase(User user) {
    return UserModels(
      id: user.uid,
      name: user.displayName ?? '',
      email: user.email ?? '',
      phoneNumber: 0,
      avatar: user.photoURL ?? '',
    );
  }

  factory UserModels.fromJson(Map<String, dynamic> json) {
    return UserModels(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      avatar: json['avatar'],
    );
  }

  factory UserModels.fromEntity(UserEntity entity) {
    return UserModels(
      id: entity.id,
      name: entity.name,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      avatar: entity.avatar ?? '',
    );
  }

   Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phoneNumber": phoneNumber,
      "avatar": avatar,
    };
  }
  toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
    };
  }

}
