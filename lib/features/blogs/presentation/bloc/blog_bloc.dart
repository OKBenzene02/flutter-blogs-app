import 'dart:io';
import 'package:blogs_app/core/usecase/usecase.dart';
import 'package:blogs_app/features/blogs/domain/entities/blog_entity.dart';
import 'package:blogs_app/features/blogs/domain/usecases/blog_upload.dart';
import 'package:blogs_app/features/blogs/domain/usecases/get_all_blogs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogUpload _uploadBlog;
  final GetAllBlogs _getAllBlogs;

  BlogBloc({required BlogUpload uploadBlog, required GetAllBlogs getAllBlogs})
      : _uploadBlog = uploadBlog,
        _getAllBlogs = getAllBlogs,
        super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_onBlogUpload);
    on<BlogsGetEvent>(_onFetchBlogs);
  }

  Future<void> _onBlogUpload(
      BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await _uploadBlog(
      BlogUploadParams(
          userId: event.userId,
          title: event.title,
          content: event.content,
          image: event.image,
          topicTags: event.topicTags),
    );
    res.fold(
      (failure) => emit(BlogFailure(error: failure.message)),
      (success) => emit(
        BlogUploadSuccess(),
      ),
    );
  }

  Future<void> _onFetchBlogs(
      BlogsGetEvent event, Emitter<BlogState> emit) async {
    final res = await _getAllBlogs(NoParams());

    res.fold((fail) => emit(BlogFailure(error: fail.message)),
        (blog) => emit(BlogDisplaySuccess(blogs: blog)));
  }
}
