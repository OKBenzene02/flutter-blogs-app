import 'package:blogs_app/features/blogs/domain/entities/blog_entity.dart';

class BlogModel extends BlogEntity {
  BlogModel(
      {required super.id,
      required super.updatedAt,
      required super.userId,
      required super.title,
      required super.content,
      required super.imageURL,
      required super.topicTags});

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'updated_at': updatedAt.toIso8601String(),
      'user_id': userId,
      'title': title,
      'content': content,
      'image_url': imageURL,
      'topic_tags': topicTags,
    };
  }

  factory BlogModel.fromJson(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      updatedAt: map['updated_at'] ? DateTime.now() : DateTime.parse(map['updatedAt']),
      userId: map['user_id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageURL: map['image_url'] as String,
      topicTags: map['topic_tags'] as List<String>,
    );
  }

  
  BlogModel copyWith({
    String? id,
    DateTime? updatedAt,
    String? userId,
    String? title,
    String? content,
    String? imageURL,
    List<String>? topicTags,
  }) {
    return BlogModel(
        id: id ?? this.id,
        updatedAt: updatedAt ?? this.updatedAt,
        userId: userId ?? this.userId,
        title: title ?? this.title,
        content: content ?? this.content,
        imageURL: imageURL ?? this.imageURL,
        topicTags: topicTags ?? this.topicTags);
  }
}
