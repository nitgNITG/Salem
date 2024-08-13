class NewsModel {
  final String id;
  final String user;
  final String news;
  final String description;
  final String image;

  NewsModel({
    required this.id,
    required this.user,
    required this.news,
    required this.description,
    required this.image,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'],
      user: json['user'],
      news: json['news'],
      description: json['description'],
      image: json['image'],
    );
  }
}
