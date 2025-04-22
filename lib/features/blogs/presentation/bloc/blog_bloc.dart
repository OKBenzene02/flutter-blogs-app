import 'dart:io';
import 'package:blogs_app/features/blogs/domain/usecases/blog_upload.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fpdart/fpdart.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogUpload uploadBlog;

  BlogBloc(this.uploadBlog) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) => emit(BlogLoading()));
    on<BlogUploadEvent>(_onBlogUpload);
  }

  Future<void> _onBlogUpload(
      BlogUploadEvent event, Emitter<BlogState> emit) async {
    final res = await uploadBlog(
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
        BlogSuccess(),
      ),
    );
  }
}
