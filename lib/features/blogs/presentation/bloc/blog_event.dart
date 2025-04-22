part of 'blog_bloc.dart';

sealed class BlogEvent {}

final class BlogUploadEvent extends BlogEvent {
  final String userId;
  final String title;
  final String content;
  final File image;
  final List<String> topicTags;

  BlogUploadEvent(
      {required this.userId,
      required this.title,
      required this.content,
      required this.image,
      required this.topicTags});
}
