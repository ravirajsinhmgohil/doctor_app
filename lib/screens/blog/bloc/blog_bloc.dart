import 'package:bloc/bloc.dart';
import 'package:doctor_app/screens/blog/data/blog_repository.dart';
import 'package:doctor_app/screens/blog/model/blog_response.dart';
import 'package:doctor_app/screens/blog/model/search_blog_response.dart';
import 'package:meta/meta.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  final BlogRepository repository;
  BlogBloc({required this.repository}) : super(BlogInitial()) {
    on<BlogEvent>((event, emit) {});
    on<GetAllBlogsEvent>(_getAllBlogs);
    on<GetBlogById>(_getBlogById);
    on<GetSearchedBlog>(_getSearchedBlog);
  }

  _getAllBlogs(GetAllBlogsEvent event, Emitter<BlogState> emit) async {
    emit(GetAllBlogsBusyState());
    dynamic data = await repository.getBlogs();
    if (data is Map) {
      if (data['status'] == 200) {
        var blogData = data['data'];
        if (blogData is List) {
          List<BlogResponse> specialistList =
              blogData.map((e) => BlogResponse.fromJson(e)).toList();
          emit(
            GetAllBlogsSuccessState(blogList: specialistList),
          );
        }
      } else {
        emit(GetAllBlogsFailureState());
      }
    }
  }

  _getBlogById(GetBlogById event, Emitter<BlogState> emit) async {
    emit(GetBlogByIdBusyState());
    dynamic data = await repository.getBlogById(blogId: event.id);
    print(data);
    if (data is Map) {
      if (data['status'] == 200) {
        var blogData = data['data'];
        if (blogData is List) {
          BlogResponse blog = BlogResponse.fromJson(blogData[0]);
          emit(GetBlogByIdSuccessState(blogResponse: blog));
        }
      } else {
        emit(GetBlogByIdFailureState());
      }
    }
  }

  _getSearchedBlog(GetSearchedBlog event, Emitter<BlogState> emit) async {
    emit(GetSearchedBlogBusyState());
    dynamic data =
        await repository.getSearchedBlog(searchdeText: event.searchedText);
    print('blog');
    print(data);
    SearchBlogResponse searchBlogResponse = SearchBlogResponse.fromJson(data);
    if (searchBlogResponse.status == 200) {
      emit(
          GetSearchedBlogSuccessState(blogList: searchBlogResponse.data ?? []));
    } else {
      emit(GetSearchedBlogFailureState());
    }

    // List<BlogResponse> searchedBlogList = event.blogList
    //     .where(
    //       (blog) => blog.title!
    //           .toLowerCase()
    //           .startsWith(event.searchedText.trim().toLowerCase()),
    //     )
    //     .toList();
    // emit(GetSearchedBlogSuccessState(blogList: searchedBlogList));
  }
}
