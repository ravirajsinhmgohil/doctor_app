import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/http_helper.dart';

class BlogDatasource {
  Future<dynamic> getBlogs() async {
    return await HttpHelper.get(uri: Api.blog);
  }

  Future<dynamic> getBlogById({required String blogId}) async {
    return await HttpHelper.get(uri: '${Api.blogWithId}/$blogId');
  }

  Future<dynamic> getSearchedBlog({required String searchedText}) async {
    return await HttpHelper.get(uri: '${Api.searchBlog}/$searchedText');
  }
}
