part of 'blog_bloc.dart';

@immutable
abstract class BlogState {}

class BlogInitial extends BlogState {}

class GetAllBlogsBusyState extends BlogState {}

class GetAllBlogsSuccessState extends BlogState {
  final List<BlogResponse> blogList;

  GetAllBlogsSuccessState({required this.blogList});
}

class GetAllBlogsFailureState extends BlogState {}

class GetBlogByIdBusyState extends BlogState {}

class GetBlogByIdSuccessState extends BlogState {
  final BlogResponse blogResponse;

  GetBlogByIdSuccessState({required this.blogResponse});
}

class GetBlogByIdFailureState extends BlogState {}

class GetSearchedBlogBusyState extends BlogState {}

class GetSearchedBlogSuccessState extends BlogState {
  final List<BlogResponse> blogList;

  GetSearchedBlogSuccessState({required this.blogList});
}

class GetSearchedBlogFailureState extends BlogState {}
