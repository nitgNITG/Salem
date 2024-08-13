import 'course.dart';

abstract class CourseCategory {
  final String id;
  final String name, image;
  final String? idnumber;
  final String? description;
  final String? descriptionformat;
  final String? parent;
  final String? sortorder;
  final String? coursecount;
  final String? visible;
  final String? visibleold;
  final String? timemodified;
  final String? depth;
  final String? path;
  final String? theme;

  CourseCategory({
    required this.id,
    required this.name,
    required this.idnumber,
    required this.description,
    required this.descriptionformat,
    required this.parent,
    required this.sortorder,
    required this.coursecount,
    required this.visible,
    required this.visibleold,
    required this.timemodified,
    required this.depth,
    required this.path,
    required this.theme,
    required this.image,
  });
}

class CategoryInstance extends CourseCategory {
  CategoryInstance({
    required super.id,
    required super.name,
    required super.idnumber,
    required super.description,
    required super.descriptionformat,
    required super.parent,
    required super.sortorder,
    required super.coursecount,
    required super.visible,
    required super.visibleold,
    required super.timemodified,
    required super.depth,
    required super.path,
    required super.theme,
    required super.image,
  });

  factory CategoryInstance.fromJson(Map<String, dynamic> json) {
    final jsonChild = json;
    return CategoryInstance(
      id: jsonChild['id'],
      name: jsonChild['name'],
      idnumber: json['idnumber'],
      description: jsonChild['description'],
      descriptionformat: jsonChild['descriptionformat'],
      parent: jsonChild['parent'],
      sortorder: jsonChild['sortorder'],
      coursecount: jsonChild['coursecount'],
      visible: jsonChild['visible'],
      visibleold: json['visibleold'],
      timemodified: json['timemodified'],
      depth: jsonChild['depth'],
      path: jsonChild['path'],
      theme: jsonChild['theme'],
      image: jsonChild['image'],
    );
  }
}

class AcademicStage {
  final String title;
  final String image;

  factory AcademicStage.fromJson(Map<String, dynamic> json) {
    final title = json['text1'];
    final image = json['images'][0] ;
    return AcademicStage(
   title: title, image: image,
    );
  }

  AcademicStage({
    required this.title,
    required this.image
  });
}

class AcademicYear {
  AcademicYear({
    required this.categoryInstance,
    required this.courses,
  });
  final CategoryInstance categoryInstance;
  final List<Course> courses;

  factory AcademicYear.fromJson(Map<String, dynamic> json) {
    final categoryInstance = CategoryInstance.fromJson(json['category']);
    final courses =
        (json['courses'] as List).map((e) => Course.fromJson(e)).toList();
    return AcademicYear(
      categoryInstance: categoryInstance,
      courses: courses,
    );
  }
}
