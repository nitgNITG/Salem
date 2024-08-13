class CourseMember {
  final String id;

  final String? token;
  final String fullName,userName,lastAccess;


  final String  role;

  final String userImage;

  CourseMember({
    required this.id,
    required this.fullName,
    required this.lastAccess,
    required this.userName,

    required this.role,
    required this.userImage,
    this.token,
  });

  factory CourseMember.fromJson(Map<String, dynamic> json) {
    return CourseMember(
      id: json['id'],
      token: json['token']!=null?json['token']:'',
      lastAccess: json['last_access'],
      userName: json['email'],
      fullName:'${json['firstName']??''} ${json['lastname']??''}',
      role: json['role'],
      userImage: json['user_image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'user_image': userImage,
    };
  }
}
