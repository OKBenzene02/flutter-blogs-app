part of 'blog_bloc.dart';

sealed class BlogState {}

final class BlogInitial extends BlogState {}

final class BlogLoading extends BlogState {}

final class BlogFailure extends BlogState {
  final String error;

  BlogFailure({required this.error});
}

final class BlogUploadSuccess extends BlogState {}

final class BlogDisplaySuccess extends BlogState {
  final List<BlogEntity> blogs;

  BlogDisplaySuccess({required this.blogs});
}
