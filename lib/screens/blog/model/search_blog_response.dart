import 'package:doctor_app/screens/blog/model/blog_response.dart';

class SearchBlogResponse {
  int? status;
  List<BlogResponse>? data;

  SearchBlogResponse({this.status, this.data});

  SearchBlogResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <BlogResponse>[];
      json['data'].forEach(
        (v) {
          data!.add(new BlogResponse.fromJson(v));
        },
      );
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
