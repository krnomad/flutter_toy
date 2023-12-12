class Content {
  final int id;
  final String image;
  final int likes;
  final String date;
  final String content;
  final bool liked;
  final String user;

  Content({
    required this.id,
    required this.image,
    required this.likes,
    required this.date,
    required this.content,
    required this.liked,
    required this.user,
  });

  factory Content.fromJson(dynamic json) {
    return Content(
      id: json['id'],
      image: json['image'],
      likes: json['likes'],
      date: json['date'],
      content: json['content'],
      liked: json['liked'],
      user: json['user'],
    );
  }
}