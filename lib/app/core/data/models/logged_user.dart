import 'dart:convert';

class LoggedUser {
  int id;
  String firstName;
  String lastName;
  String image;
  String? token;
  String email;

  String role;
  int? year;
  String phone;
  int coursesCount;
  bool isAdmin;

  LoggedUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
    required this.token,
    required this.email,
    required this.role,
    required this.phone,
    required this.coursesCount,
    required this.isAdmin,
  });

  factory LoggedUser.fromJson(Map<String, dynamic> json) => LoggedUser(
        id: int.parse(json['id'].toString()),
       firstName: json['firstName'],
        lastName:json['lastName'],
        image: json['image'],
        token: json['token'],
        email: json['email'],
        role: (json['is_admin'] ?? false) ? "admin" : json['role'],
        phone: json['phone']?? "",
        isAdmin: json['is_admin'] ?? false,
        coursesCount:json['courses_count']==null? 0:json['courses_count'] ,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'image': image,
        'token': token,
        'email': email,
        'role': role,
        'year': year,
        'phone': phone,
        'is_admin': isAdmin,
        'courses_count': coursesCount,
      };

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  static LoggedUser fromString(String jsonString) {
    return LoggedUser.fromJson(
      jsonDecode(jsonString),
    );
  }
}
