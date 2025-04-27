import 'dart:io';
import 'package:blogs_app/core/constants/constants.dart';
import 'package:blogs_app/core/error/exceptions.dart';
import 'package:blogs_app/core/error/failures.dart';
import 'package:blogs_app/core/network/connection_checker.dart';
import 'package:blogs_app/features/blogs/data/models/blog_model.dart';
import 'package:blogs_app/features/blogs/data/sources/blog_local_data_sources.dart';
import 'package:blogs_app/features/blogs/data/sources/blog_remote_data_sources.dart';
import 'package:blogs_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:blogs_app/features/blogs/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';
import 'package:uuid/uuid.dart';

class BlogRepositoryImplementation implements BlogRepository {
  final BlogRemoteDataSources blogRemoteDataSources;
  final BlogLocalDataSources blogLocalDataSources;
  final ConnectionChecker connectionChecker;

  BlogRepositoryImplementation({
    required this.blogRemoteDataSources,
    required this.blogLocalDataSources,
    required this.connectionChecker,
  });

  @override
  Future<Either<Failures, BlogEntity>> uploadBlog(
      {required File image,
      required String title,
      required String content,
      required String userId,
      required List<String> topicTags}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return left(Failures(Constants.noConnectionFound));
      }

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

  @override
  Future<Either<Failures, List<BlogEntity>>> getAllBlogs() async {
    try {
      if (!await (connectionChecker.isConnected)) {
        final blogs = blogLocalDataSources.loadBlogs();
        return right(blogs);
      }
      final blogs = await blogRemoteDataSources.getAllBlogs();
      blogLocalDataSources.uploadLocalBlogs(blogs: blogs);
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failures(e.message));
    }
  }
}
