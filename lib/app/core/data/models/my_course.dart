import 'dart:convert';


class MyCourse {
  final String id;
  final String shortname;
  final String fullname;
  final String? displayname;
  final String? idnumber;
  final String? visible;
  final String summary;
  final String? summaryformat;
  final String? format;
  final String? showgrades;
  final String? lang;
  final String enablecompletion;
  final bool completionhascriteria;
  final bool completionusertracked;
  final String category;
  final double progress;
  final bool? completed;
  final String startdate;
  final String enddate;
  final String marker;
  final String lastaccess;
  final bool isfavourite;
  final bool hidden;
  List<OverviewFiles> overviewfiles = [];
  final String showactivitydates;
  final String showcompletionconditions;
  final String timemodified;
  final int enrolledusercount;
  final String imageUrl;
  final String viewsCount, rating, teacherName;

  MyCourse(
      {required this.id,
      required this.shortname,
      required this.fullname,
      required this.displayname,
      required this.idnumber,
      required this.visible,
      required this.summary,
      required this.summaryformat,
      required this.format,
      required this.showgrades,
      required this.lang,
      required this.enablecompletion,
      required this.completionhascriteria,
      required this.completionusertracked,
      required this.category,
      required this.progress,
      required this.completed,
      required this.startdate,
      required this.enddate,
      required this.marker,
      required this.lastaccess,
      required this.isfavourite,
      required this.hidden,
      required this.overviewfiles,
      required this.showactivitydates,
      required this.showcompletionconditions,
      required this.timemodified,
      required this.enrolledusercount,
      required this.imageUrl,
      required this.rating,
      required this.teacherName,
      required this.viewsCount});

  factory MyCourse.fromJson(Map<String, dynamic> json) {
    return MyCourse(
        id: json['id'],
        shortname: json['shortname']??"",
        fullname: json['fullname'],
        displayname: json['displayname'],
        idnumber: json['idnumber'],
        visible: json['visible'],
        summary: json['summary'] ?? "",
        summaryformat: json['summaryformat'] ?? "",
        format: json['format'],
        showgrades: json['showgrades'],
        lang: json['lang'],
        enablecompletion: json['enablecompletion'] ?? "",
        completionhascriteria: json['completionhascriteria'] ?? false,
        completionusertracked: json['completionusertracked'] ?? false,
        category: json['category'] ?? "",
        progress: double.parse((json['progress'] ?? 0.0).toString()),
        completed: json['completed'] ?? false,
        startdate: json['startdate'] ?? "",
        enddate: json['enddate'] ?? "",
        marker: json['marker'] ?? "",
        lastaccess: json['lastaccess'] ?? "",
        isfavourite: json['isfavourite'] ?? false,
        hidden: json['hidden'] ?? false,
        imageUrl: json['image_url']??json['image_Url']??'',
        overviewfiles: (json["overviewfiles"] ??
                [
                  jsonEncode({
                    'filename': "filename",
                    'fileurl': "https://picsum.photos/200/400",
                    'filesize': "filesize",
                    'filepath': "filepath",
                    'mimetype': "mimetype",
                    'timemodified': "timemodified",
                  })
                ])
            .map((i) => OverviewFiles.fromJson(i))
            .cast<OverviewFiles>()
            .toList(),
        showactivitydates: json["showactivitydates"] ?? "",
        showcompletionconditions: json["showcompletionconditions"] ?? "",
        timemodified: json["timemodified"] ?? "",
        enrolledusercount: json["enrolledusercount"] ?? 0,
        rating: json['rating'] ?? "",
        viewsCount: json['view'] ?? "",
        teacherName: (json['contacts'] as List).first['fullname']);
  }
}

class OverviewFiles {
  final String filename;
  final String fileurl;
  final String filesize;
  final String filepath;
  final String mimetype;
  final String timemodified;

  OverviewFiles(
      {required this.filename,
      required this.fileurl,
      required this.filesize,
      required this.filepath,
      required this.mimetype,
      required this.timemodified});

  factory OverviewFiles.fromJson(Map<String, dynamic> i) {
    return OverviewFiles(
        filename: i["filename"],
        fileurl: i["fileurl"],
        filesize: i["filesize"],
        filepath: i["filepath"],
        mimetype: i["mimetype"],
        timemodified: i["timemodified"]);
  }
}
