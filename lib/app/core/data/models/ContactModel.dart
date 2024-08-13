class Contact {
  final String title;
  final String Link;
  final String Icon;


  Contact(
      {required this.title,
        required this.Link,
        required this.Icon
      });

  factory Contact.fromJson(Map<String, dynamic> i) {
    return Contact(
        title: i[i.keys.first]??'',
        Link:i[i.keys.toList()[1]]??'',
        Icon: i[i.keys.last]??''
      );
  }
}

class PrivacyModel {
  final String title;
  final String body;


  PrivacyModel(
      {required this.title,
        required this.body
      });

  factory PrivacyModel.fromJson(Map<String, dynamic> i) {
    return PrivacyModel(
        title: i['title']??'', body: i['body']['text']??''
    );
  }
}
