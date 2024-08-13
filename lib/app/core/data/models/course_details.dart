class CourseDetails {
  final String courseId;
  final int? enrolments;
  final String? categoryId;
  final String? categoryName;
  final String? categoryUrl;
  final String? shortName;
  final String? fullName;
  final String? description;
  final String? imageUrl;
  final String? format;
  final String? activitiesCount;
  final int? numberOfSections;
  final String? visible;
  final int? ratings;
  final dynamic courseRate;
  final int? views;
  final String? enrol;
  final OtherFields otherFields;
  List<Section> contents = [];

  List<EnrollStudent> enrolUsers = [];

  CourseDetails({
    required this.courseId,
    required this.enrolments,
    required this.categoryId,
    required this.categoryName,
    required this.categoryUrl,
    required this.shortName,
    required this.fullName,
    required this.description,
    required this.imageUrl,
    required this.format,
    required this.activitiesCount,
    required this.numberOfSections,
    required this.visible,
    required this.ratings,
    this.courseRate,
    required this.views,
    required this.enrol,
    required this.otherFields,
    required this.contents,
    required this.enrolUsers,
  });

  factory CourseDetails.fromJson(Map<String, dynamic> json) {
    List<Section>? sections = (json["contents"] as List)
        .map((e) => Section.fromJson(e))
        .cast<Section>()
        .toList();
    List<EnrollStudent>? students = (json["enrol_users"]??[])
        .map((e) => EnrollStudent.fromJson(e))
        .cast<EnrollStudent>()
        .toList();

    return CourseDetails(
      courseId: json['id'],
      enrolments: json['enrolments'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
      categoryUrl: json['categoryUrl'],
      shortName: json['shortName'],
      fullName: json['fullName'],
      description: json['description'],
      imageUrl: json['image_url'],
      format: json['format'],
      activitiesCount: json['activities_count'],
      numberOfSections: json['numberOfSections'],
      visible: json['visible'],
      ratings: json['Ratings'],
      courseRate: json['courseRate'],
      views: json['views'],
      enrol: json['enrol'],
      otherFields: OtherFields.fromJson(json["other_fields"]??[]),
      contents: sections,
      enrolUsers: students??[],
    );
  }
}

class Section {
  final String id;
  final String name;
  final String? visible;
  final String? summary;
  final String? summaryformat;
  final int? section;
  final int? hiddenbynumsections;
  final bool? uservisible;
  List<Module> modules = [];

  Section(
      {required this.id,
      required this.name,
      required this.visible,
      required this.summary,
      required this.summaryformat,
      required this.section,
      required this.hiddenbynumsections,
      required this.uservisible,
      required this.modules});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
        id: json['id'],
        name: json['name'],
        visible: json['visible'],
        summary: json['summary'],
        summaryformat: json['summaryformat'],
        section: json['section'],
        hiddenbynumsections: json['hiddenbynumsections'],
        uservisible: json['uservisible'],
        modules:
            (json["modules"] as List).map((i) => Module.fromJson(i)).toList());
  }
}

class Module {
  final String id;
  final String name;
  final String? instance;
  final String? modname;
  final String? modplural;
  final String? modicon;
  final int? indent;
  final String? onclick;
  final dynamic afterlink;
  final String? customdata;
  final String? completion;
  final bool? noviewlink;
  final String? paid;
  final bool? avail;
  final String? quizType;
  final String resourceType;
  final String? pageUrl;
  final String? url;
  final String visible;
  final String? visibleoncoursepage;
  final bool? uservisible;
  final FileDetails? fileDetails;

  Module(
      {required this.id,
      required this.name,
      required this.instance,
      required this.modname,
      required this.modplural,
      required this.modicon,
      required this.indent,
      required this.onclick,
      this.afterlink,
      required this.customdata,
      required this.completion,
      required this.noviewlink,
      required this.paid,
      required this.avail,
      required this.quizType,
      required this.resourceType,
      required this.pageUrl,
      required this.url,
      required this.visible,
      required this.visibleoncoursepage,
      required this.uservisible,
      this.fileDetails});

  factory Module.fromJson(Map<String, dynamic> i) {
    return Module(
      id: i["id"],
      name: i["name"],
      instance: i["instance"],
      modname: i["modname"],
      modplural: i["modplural"],
      modicon: i["modicon"],
      indent: i["indent"],
      onclick: i["onclick"],
      afterlink: i["afterlink"],
      customdata: i["customdata"],
      completion: i["completion"].toString(),
      noviewlink: i["noviewlink"],
      paid: i["paid"],
      avail: i["availability"],
      quizType: i["quiz_type"],
      resourceType: i["resource_type"],
      pageUrl: i["page_url"],
      url: i["url"],
      visible: i["visible"],
      visibleoncoursepage: i["visibleoncoursepage"].toString(),
      fileDetails: i['contents'] != null && ((i['contents'] as List).isNotEmpty)
          ? FileDetails.fromJson(
              (i['contents'] as List).isNotEmpty
                  ? (i['contents'] as List).first
                  : null,
            )
          : null,
      uservisible: i["uservisible"],
    );
  }
}

class FileDetails {
  final String? type;
  final String? filename;
  final String? filepath;
  final String? filesize;
  final String? fileurl;
  final String? timecreated;
  final String? timemodified;
  final String? sortorder;
  final String? userid;
  final String? author;
  final String? license;
  final String? mimetype;
  final bool? isexternalfile;

  FileDetails({
    required this.type,
    required this.filename,
    required this.filepath,
    required this.filesize,
    required this.fileurl,
    required this.timecreated,
    required this.timemodified,
    required this.sortorder,
    required this.userid,
    required this.author,
    required this.license,
    required this.mimetype,
    required this.isexternalfile,
  });

  factory FileDetails.fromJson(Map<String, dynamic> json) {
    return FileDetails(
      type: json['type'],
      filename: json['filename'],
      filepath: json['fileurl'],
      filesize: json['filesize'].toString(),
      fileurl: json['fileurl'],
      timecreated: json['timecreated'].toString(),
      timemodified: json['timemodified'],
      sortorder: json['sortorder'].toString(),
      userid: json['userid'].toString(),
      author: json['author'].toString(),
      license: json['license'].toString(),
      mimetype: json['mimetype'].toString(),
      isexternalfile: json['isexternalfile'] ?? false,
    );
  }
}

class OtherFields {
  final String? online;
  final String? online_url;
  final String? online_name;
  final String? online_reminded_date;

  OtherFields({
    required this.online,
    required this.online_name,
    required this.online_reminded_date,
    required this.online_url,
  });

  factory OtherFields.fromJson(Map<String, dynamic> json) {
    return OtherFields(
        online_url: json['secession_url'],
        online_reminded_date: json['reminded'],
        online: json['have_online'],
        online_name: json['secession_name']);
  }
}

class EnrollStudent {
  final String id;
  final String name;
  final String? email;
  final String? imageUrl;
  final String? phone1;
  final String? phone2;
  final String? city;
  final String? lastLogin;

  EnrollStudent({
    required this.id,
    required this.name,
    required this.email,
    required this.imageUrl,
    required this.phone1,
    required this.phone2,
    required this.city,
    required this.lastLogin,
  });

  factory EnrollStudent.fromJson(Map<String, dynamic> json) {
    return EnrollStudent(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      imageUrl: json['image_url'],
      phone1: json['phone1']??'',
      phone2: json['phone2']??'',
      city: json['city']??'',
      lastLogin: json['last_login'],
    );
  }
}
