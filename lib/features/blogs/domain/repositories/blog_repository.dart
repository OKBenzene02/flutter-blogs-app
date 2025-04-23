import 'dart:io';
import 'package:blogs_app/core/error/failures.dart';
import 'package:blogs_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failures, BlogEntity>> uploadBlog({
    required File image,
    required String title,
    required String content,
    required String userId,
    required List<String> topicTags,
  });

  Future<Either<Failures, List<BlogEntity>>> getAllBlogs();
}
