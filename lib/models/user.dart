import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String firstname;
  String lastname;
  int age;

  User(
      {required this.id,
        required this.firstname,
        required this.lastname,
        required this.age});

  factory User.fromJson(Map<String, dynamic>json)=>User(id: json['id'], firstname: json['firstname'], lastname: json['lastname'], age: json['age']);

  Map<String, dynamic> toJson() => {
    'id': id,
    'firstname': firstname,
    'lastname': lastname,
    'age': age,
  };

  factory User.fromJsons(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJsons() => _$UserToJson(this);
}