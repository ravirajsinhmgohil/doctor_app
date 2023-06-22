import 'package:doctor_app/screens/blog/bloc/blog_bloc.dart';
import 'package:doctor_app/screens/blog/data/blog_datasource.dart';
import 'package:doctor_app/screens/blog/data/blog_repository.dart';
import 'package:doctor_app/screens/blog/model/blog_response.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:doctor_app/widgets/custom_blog_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class BlogScreen extends StatefulWidget {
  const BlogScreen({super.key});

  @override
  State<BlogScreen> createState() => _BlogScreenState();
}

class _BlogScreenState extends State<BlogScreen> with Methods {
  List<BlogResponse> blogList = [];
  final TextEditingController _searchController = TextEditingController();
  final FocusNode blogFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogBloc(
        repository: BlogRepository(
          datasource: BlogDatasource(),
        ),
      )..add(GetAllBlogsEvent()),
      child: BlocConsumer<BlogBloc, BlogState>(
        listener: (context, state) {
          if (state is GetAllBlogsSuccessState) {
            blogList = state.blogList;
          }
          if (state is GetSearchedBlogSuccessState) {
            blogList = state.blogList;
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColor.appBackground,
            appBar: AppBar(
              elevation: 0,
              centerTitle: false,
              title: Text(
                Strings.blog,
                style: TextStyleHelper.appbarTitle,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 1.h,
              ),
              child: ListView(
                children: [
                  height(1.h),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 0.7.h,
                    ),
                    child: TextFormField(
                      controller: _searchController,
                      focusNode: blogFocusNode,
                      onChanged: (value) {
                        if (value.isNotEmpty) {
                          context.read<BlogBloc>().add(
                                GetSearchedBlog(
                                  blogList: blogList,
                                  searchedText: value,
                                ),
                              );
                        } else {
                          context.read<BlogBloc>().add(GetAllBlogsEvent());
                        }
                      },
                      decoration: InputDecoration(
                        hintStyle: TextStyle(
                          fontSize: 11.sp,
                          fontWeight: FontWeight.w500,
                        ),
                        hintText: Strings.searchBlog,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: 1.4.h,
                          horizontal: 2.h,
                        ),
                        suffixIcon: Icon(
                          Icons.search,
                          color: AppColor.theme,
                          size: 17.sp,
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: AppColor.theme),
                          borderRadius: BorderRadius.circular(
                            1.5.h,
                          ),
                        ),
                      ),
                    ),
                  ),
                  height(0.5.h),
                  //Build for blog list
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: blogList.length,
                    itemBuilder: (context, index) {
                      BlogResponse blog = blogList[index];
                      return CustomBlogCard(
                        focusNode: blogFocusNode,
                        blogId: blog.id.toString(),
                        image: '${Api.baseUrl}blog/${blog.photo}',
                        title: blog.title!,
                        detail: blog.detail!,
                        name: blog.doctor?.doctorName ?? blog.blogger ?? '',
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
