class Course {
  final String id;
  final int? enrolments;
  final int? numberOfSections;
  final String? format;
  final String? categoryId;
  final String? categoryName;
  final String shortName;
  final String fullName;
  final String imageUrl;
  final String? description;
  final String? isFree;
  final String? price;
  final String? viewsCount;
  final int? rate;
  Course({
    required this.id,
    required this.enrolments,
    required this.numberOfSections,
    required this.format,
    required this.categoryId,
    required this.categoryName,
    required this.shortName,
    required this.fullName,
    required this.imageUrl,
    required this.description,
    required this.isFree,
    this.price,
    this.viewsCount,
    required this.rate,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    /* final teacherNam = json['teachers']['count'] > 0
        ? (json['teachers']['teachers'] as List).first['teacher_firstname'] +
            " " +
            (json['teachers']['teachers'] as List).first['teacher_lastname']
        : null; */
    return Course(
      id: json['id'],
      enrolments: json['enrolments'],
      numberOfSections: json['numberOfSections'],
      format: json['format'],
      categoryId: json['categoryid'],
      categoryName: json['categoryname'],
      shortName: json['shortname']??'',
      fullName: json['fullname'],
      imageUrl: json['image_url']==null?json['imageUrl']:json['image_url'],
      description: json['description'],
      isFree: json['free'],
      price: json['price'],
      rate: json['rate'],
      viewsCount: json['view'],
    );
  }
}
