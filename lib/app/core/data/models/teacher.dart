
class Teacher {
  final String id;
  final String username;
  final String firstname;
  final String lastname;
  final String imgUrl;
  final String job;
  final int studentsCount, rate;
  Teacher({
    required this.id,
    required this.username,
    required this.firstname,
    required this.lastname,
    required this.imgUrl,
    required this.job,
    required this.rate,
    required this.studentsCount,
  });

  factory Teacher.fromJson(Map<String, dynamic> json) {
    return Teacher(
      id: json['id'],
      username: json['username'],
      firstname: json['firstname'],
      lastname: json['lastname'],
      imgUrl: json['img_url'],
      job: json['job'] ?? "",
      studentsCount: json['students'],
      rate: json['rate'],
    );
  }
}

class TeacherDetails {
  final String id;
  final String username;
  final String image;
  final String firstname;
  final String? secondname;
  final String? thirdname;
  final String lastname;
  final String? readandwrite;
  final String? academicqualification;
  final String? scientificdegree;
  final String job;
  final String email;
  final String phone1;
  final String phone2;
  final String? coursetype;
  final String city;
  final String address;
  final String? description;

  TeacherDetails(
      {required this.id,
      required this.username,
      required this.image,
      required this.firstname,
      this.secondname,
      this.thirdname,
      required this.lastname,
      this.readandwrite,
      this.academicqualification,
      this.scientificdegree,
      required this.job,
      required this.email,
      required this.phone1,
      required this.phone2,
      this.coursetype,
      required this.city,
      required this.address,
      required this.description});

  factory TeacherDetails.fromJson(Map<String, dynamic> json) {
    return TeacherDetails(
        id: json['id'],
        username: json['username'],
        image: json['image'],
        firstname: json['firstname'],
        secondname: json['secondname'],
        thirdname: json['thirdname'],
        lastname: json['lastname'],
        readandwrite: json['readandwrite'],
        academicqualification: json['academicqualification'],
        scientificdegree: json['scientificdegree'],
        job: json['job'],
        email: json['email'],
        phone1: json['phone1'],
        phone2: json['phone2'],
        coursetype: json['coursetype'],
        city: json['city'],
        address: json['address'],
        description: json["description"]);
  }
}
