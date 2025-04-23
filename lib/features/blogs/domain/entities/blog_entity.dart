class BlogEntity {
  final String id;
  final DateTime updatedAt;
  final String userId;
  final String title;
  final String content;
  final String imageURL;
  final List<String> topicTags;
  final String? userName;

  BlogEntity({
    required this.id,
    required this.updatedAt,
    required this.userId,
    required this.title,
    required this.content,
    required this.imageURL,
    required this.topicTags,
    this.userName,
  });
}
