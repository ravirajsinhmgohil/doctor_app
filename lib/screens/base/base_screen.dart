import 'package:doctor_app/screens/base/bloc/base_bloc.dart';
import 'package:doctor_app/screens/base/data/base_datasource.dart';
import 'package:doctor_app/screens/base/data/base_repository.dart';
import 'package:doctor_app/screens/blog/blog_screen.dart';
import 'package:doctor_app/screens/connection_error/bloc/connection_error_bloc.dart';
import 'package:doctor_app/screens/home/bloc/home_bloc.dart';
import 'package:doctor_app/screens/home/data/home_datasource.dart';
import 'package:doctor_app/screens/home/data/home_repository.dart';
import 'package:doctor_app/screens/home/home_screen.dart';
import 'package:doctor_app/screens/home/model/city_response.dart';
import 'package:doctor_app/screens/login/login_screen.dart';
import 'package:doctor_app/screens/login/model/login_response.dart';
import 'package:doctor_app/screens/profile/profile_screen.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/shared_prefs_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:doctor_app/utils/widget_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeBloc(
            repository: HomeRepository(
              datasource: HomeDatasource(),
            ),
          )..add(GetCityList()),
        ),
        BlocProvider(
          create: (context) => BaseBloc(
              repository: BaseRepository(datasource: BaseDatasource())),
        )
      ],
      child: BaseScreenUi(),
    );
  }
}

class BaseScreenUi extends StatefulWidget {
  const BaseScreenUi({super.key});

  @override
  State<BaseScreenUi> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreenUi> with Methods {
  int _selectedIndex = 0;
  final GlobalKey<FormState> updateNumberKey = GlobalKey<FormState>();
  LoginResponse? loginUserData;
  List<CityResponse> cityList = [];
  CityResponse? defaultCity;
  HomeBloc block = HomeBloc(
    repository: HomeRepository(
      datasource: HomeDatasource(),
    ),
  );
  String? cityId;
  getCity() async {
    cityId = await SharedPrefs.getCity();
  }

  @override
  void initState() {
    getLoginData().then((value) async {
      print('s');
      print(value.data?.contactNumber);
      if (value.data?.contactNumber?.isEmpty ??
          false || value.data?.contactNumber == null) {
        Future.delayed(Duration(seconds: 2), () {
          updatNumber(
            context: context,
            key: updateNumberKey,
            hintText: value.data?.contactNumber ?? '',
            userId: value.data?.id.toString() ?? '',
          );
        });
      }
    });
    getCity();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ConnectionErrorBloc, ConnectionErrorState>(
      listener: (context, state) {
        if (state is CheckConnectionFailureState) {
          WidgetHelper.customSnackBar(
            context: context,
            title: Strings.connectionLost,
            backgroundColor: Colors.red.shade400,
          );
        }
        if (state is CheckConnectionSuccessState) {
          context.read<HomeBloc>().add(GetCityList());
          WidgetHelper.customSnackBar(
            context: context,
            title: Strings.backToLogin,
            backgroundColor: Colors.green.shade400,
          );
        }
      },
      builder: (context, state) {
        return BlocConsumer<BaseBloc, BaseState>(
          listener: (context, state) {
            if (state is ChangeBottomNavigationState) {
              _selectedIndex = state.selectedIndex;
            }
          },
          builder: (context, state) {
            return BlocConsumer<HomeBloc, HomeState>(
              listener: (context, state) {
                if (state is GetCityListSuccessState) {
                  cityList = state.cityList;
                }
              },
              builder: (context, state) {
                return Scaffold(
                  body: state is GetCityListSuccessState
                      ? IndexedStack(
                          index: _selectedIndex,
                          children: [
                            HomeScreen(
                              cityList: cityList,
                              storedCityId: cityId!,
                            ),
                            const BlogScreen(),
                            ProfileScreen(),
                          ],
                        )
                      //Build for loader
                      : const Center(
                          child: CustomLoader(color: AppColor.theme),
                        ),
                  bottomNavigationBar: BottomNavigationBar(
                    backgroundColor: AppColor.theme,
                    selectedLabelStyle:
                        TextStyleHelper.bottomNavigationBarLabel,
                    iconSize: 18.sp,
                    elevation: 0,
                    selectedItemColor: AppColor.themeGreen,
                    unselectedItemColor: Colors.white,
                    showUnselectedLabels: false,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: Strings.home,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.library_books_outlined),
                        label: Strings.blog,
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: Strings.profile,
                      )
                    ],
                    currentIndex: _selectedIndex,
                    onTap: (value) {
                      //for change bottom navigation item
                      context.read<BaseBloc>().add(
                            ChangeBottomNavigationEvent(
                              selectedIndex: value,
                            ),
                          );
                    },
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
