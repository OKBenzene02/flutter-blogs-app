import 'dart:io';

import 'package:blogs_app/core/error/failures.dart';
import 'package:blogs_app/core/usecase/usecase.dart';
import 'package:blogs_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:blogs_app/features/blogs/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class BlogUpload implements UseCase<BlogEntity, BlogUploadParams> {
  final BlogRepository blogRepository;

  BlogUpload({required this.blogRepository});

  @override
  Future<Either<Failures, BlogEntity>> call(BlogUploadParams params) async {
    return await blogRepository.uploadBlog(
        image: params.image,
        title: params.title,
        content: params.content,
        userId: params.userId,
        topicTags: params.topicTags);
  }
}

class BlogUploadParams {
  final String userId;
  final String title;
  final String content;
  final File image;
  final List<String> topicTags;

  BlogUploadParams(
      {required this.userId,
      required this.title,
      required this.content,
      required this.image,
      required this.topicTags});
}
