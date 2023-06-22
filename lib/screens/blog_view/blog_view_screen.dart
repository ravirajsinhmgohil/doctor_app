import 'package:doctor_app/screens/blog/bloc/blog_bloc.dart';
import 'package:doctor_app/screens/blog/data/blog_datasource.dart';
import 'package:doctor_app/screens/blog/data/blog_repository.dart';
import 'package:doctor_app/screens/blog/model/blog_response.dart';
import 'package:doctor_app/screens/connection_error/bloc/connection_error_bloc.dart';
import 'package:doctor_app/screens/login/login_screen.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class BlogViewScreen extends StatelessWidget {
  final String blogId;
  const BlogViewScreen({super.key, required this.blogId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BlogBloc(
        repository: BlogRepository(
          datasource: BlogDatasource(),
        ),
      )..add(
          GetBlogById(id: blogId),
        ),
      child: BlogViewScreenUi(blogId: blogId),
    );
  }
}

class BlogViewScreenUi extends StatefulWidget {
  final String blogId;
  const BlogViewScreenUi({super.key, required this.blogId});

  @override
  State<BlogViewScreenUi> createState() => _BlogViewScreenUiState();
}

class _BlogViewScreenUiState extends State<BlogViewScreenUi> with Methods {
  BlogResponse? blog;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BlogBloc, BlogState>(
      listener: (context, state) {
        if (state is GetBlogByIdSuccessState) {
          blog = state.blogResponse;
        }
      },
      builder: (context, state) {
        return BlocConsumer<ConnectionErrorBloc, ConnectionErrorState>(
          listener: (context, state) {
            if (state is CheckConnectionSuccessState) {
              context.read<BlogBloc>().add(GetBlogById(id: widget.blogId));
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColor.appBackground,
              body: state is GetBlogByIdBusyState
                  ? const Center(
                      child: CustomLoader(color: AppColor.theme),
                    )
                  : SafeArea(
                      child: Padding(
                        padding: EdgeInsets.all(2.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                if (blog?.photo?.isNotEmpty ?? false) ...[
                                  SizedBox(
                                    height: 45.h,
                                    width: double.infinity,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(1.h),
                                      child: Image.network(
                                          fit: BoxFit.fill,
                                          '${Api.baseUrl}blog/${blog?.photo}'),
                                    ),
                                  ),
                                ] else ...[
                                  Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade400,
                                    child: Container(
                                      height: 45.5.h,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        borderRadius:
                                            BorderRadius.circular(1.h),
                                      ),
                                    ),
                                  )
                                ],
                                Positioned(
                                  top: 1.h,
                                  left: 1.h,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: IconButton(
                                      color: AppColor.appbarText,
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.arrow_back),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0.h,
                                  left: 0.h,
                                  right: 0,
                                  child: Padding(
                                    padding: const EdgeInsets.only(),
                                    child: Container(
                                      color: Colors.black26,
                                      padding: EdgeInsets.all(1.h),
                                      child: Text(
                                        blog?.title ?? '',
                                        textAlign: TextAlign.justify,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyleHelper.blogTitle,
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            height(2.h),
                            Expanded(
                              child: ListView(
                                shrinkWrap: true,
                                children: [
                                  RichText(
                                    textAlign: TextAlign.justify,
                                    text: TextSpan(
                                      children: [
                                        //Build for bolg detail first word
                                        TextSpan(
                                          text: blog?.detail?.substring(0, 1),
                                          spellOut: false,
                                          style:
                                              TextStyleHelper.blogDetailCapital,
                                        ),
                                        //Build for bolg detail
                                        TextSpan(
                                          text: blog?.detail?.substring(
                                            1,
                                            blog?.detail?.length,
                                          ),
                                          style: TextStyle(
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w500,
                                            height: 0.18.h,
                                            fontFamily: 'Merriweather',
                                            color: Colors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //Build for doctor name
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        '-',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          fontWeight: FontWeight.w500,
                                          height: 0.18.h,
                                          fontFamily: 'Merriweather',
                                          color: Colors.black,
                                        ),
                                      ),
                                      Text(
                                        blog?.blogger ??
                                            blog?.doctor?.doctorName ??
                                            '',
                                        style: TextStyle(
                                          fontSize: 11.sp,
                                          fontWeight: FontWeight.w500,
                                          height: 0.18.h,
                                          fontFamily: 'Merriweather',
                                          color: Colors.black,
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
            );
          },
        );
      },
    );
  }
}
