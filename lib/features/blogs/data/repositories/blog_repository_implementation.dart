import 'dart:io';
import 'package:blogs_app/core/error/exceptions.dart';
import 'package:blogs_app/core/error/failures.dart';
import 'package:blogs_app/features/blogs/data/models/blog_model.dart';
import 'package:blogs_app/features/blogs/data/sources/blog_remote_data_sources.dart';
import 'package:blogs_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:blogs_app/features/blogs/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImplementation implements BlogRepository {
  final BlogRemoteDataSources blogRemoteDataSources;

  BlogRepositoryImplementation({required this.blogRemoteDataSources});

  @override
  Future<Either<Failures, BlogEntity>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String userId,
      required List<String> topicTags}) async {
    try {
      BlogModel blogModel = BlogModel(
          id: const Uuid().v1(),
          updatedAt: DateTime.now(),
          userId: userId,
          title: title,
          content: content,
          imageURL: '',
          topicTags: topicTags);

      final imageUrl = await blogRemoteDataSources.uploadBlogImage(
          file: image, blog: blogModel);

      blogModel = blogModel.copyWith(
        imageURL: imageUrl,
      );

      final uploadedBlog = await blogRemoteDataSources.uploadBlog(blogModel);
      return right(uploadedBlog);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
