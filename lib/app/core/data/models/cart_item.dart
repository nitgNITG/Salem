class CartItemModel {
  final String id;
  final String teacherName;
  final String courseName;
  final String courseId;
  final String teacherId;
  final String price;
  final String overviewFiles;

  CartItemModel({
    required this.id,
    required this.teacherName,
    required this.courseName,
    required this.courseId,
    required this.teacherId,
    required this.price,
    required this.overviewFiles,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      teacherName: json['teachername'],
      courseName: json['coursename'],
      courseId: json['courseid'],
      teacherId: json['teacherid'],
      price: json['price'],
      overviewFiles: json['overviewfiles'],
    );
  }
}
