import 'package:doctor_app/screens/blog/data/blog_datasource.dart';

class BlogRepository {
  final BlogDatasource datasource;

  BlogRepository({required this.datasource});
  Future<dynamic> getBlogs() async {
    return datasource.getBlogs();
  }

  Future<dynamic> getBlogById({required String blogId}) async {
    return await datasource.getBlogById(blogId: blogId);
  }

  Future<dynamic> getSearchedBlog({required String searchdeText}) async {
    return await datasource.getSearchedBlog(searchedText: searchdeText);
  }
}
