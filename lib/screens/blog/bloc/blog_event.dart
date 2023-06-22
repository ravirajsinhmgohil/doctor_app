part of 'blog_bloc.dart';

@immutable
abstract class BlogEvent {}

class GetAllBlogsEvent extends BlogEvent {}

class GetBlogById extends BlogEvent {
  final String id;

  GetBlogById({required this.id});
}

class GetSearchedBlog extends BlogEvent {
  final String searchedText;
  final List<BlogResponse> blogList;

  GetSearchedBlog( {required this.blogList,required this.searchedText});
}
