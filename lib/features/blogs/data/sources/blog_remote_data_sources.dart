import 'dart:io';

import 'package:blogs_app/core/error/exceptions.dart';
import 'package:blogs_app/features/blogs/data/models/blog_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSources {
  Future<BlogModel> uploadBlog(BlogModel blog);
  Future<String> uploadBlogImage({
    required File file,
    required BlogModel blog,
  });
  Future<List<BlogModel>> getAllBlogs();
}

class BlogRemoteDataSourceImplementation implements BlogRemoteDataSources {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImplementation({required this.supabaseClient});

  @override
  Future<BlogModel> uploadBlog(BlogModel blog) async {
    try {
      final blogData =
          await supabaseClient.from('blogs').insert(blog.toJson()).select();
      return BlogModel.fromJson(blogData.first);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<String> uploadBlogImage(
      {required File file, required BlogModel blog}) async {
    try {
      await supabaseClient.storage.from('blog_images').upload(blog.id, file);
      return supabaseClient.storage.from('blog_images').getPublicUrl(blog.id);
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<List<BlogModel>> getAllBlogs() async {
    try {
      final all_blogs =
          await supabaseClient.from('blogs').select('*, profiles(name)');
      final blogModel = all_blogs
          .map(
            (blog) => BlogModel.fromJson(blog).copyWith(
              userName: blog['profiles']['name'],
            ),
          )
          .toList();
      return blogModel;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
