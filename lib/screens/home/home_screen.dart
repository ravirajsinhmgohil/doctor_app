import 'package:doctor_app/screens/home/bloc/home_bloc.dart';
import 'package:doctor_app/screens/home/data/home_datasource.dart';
import 'package:doctor_app/screens/home/data/home_repository.dart';
import 'package:doctor_app/screens/home/model/city_response.dart';
import 'package:doctor_app/screens/home/model/hospital_response.dart';
import 'package:doctor_app/screens/home/model/sllider_response.dart';
import 'package:doctor_app/screens/home/model/hospital_type_response.dart';
import 'package:doctor_app/screens/search_hospital/search_hospital_screen.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/image_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/navigate_helper.dart';
import 'package:doctor_app/utils/shared_prefs_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:doctor_app/widgets/custom_category_button.dart';
import 'package:doctor_app/widgets/custom_hospital_sckelton.dart';
import 'package:doctor_app/widgets/custom_hospital_tile.dart';
import 'package:doctor_app/widgets/custom_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatelessWidget {
  final List<CityResponse> cityList;
  final String storedCityId;

  const HomeScreen(
      {super.key, required this.cityList, required this.storedCityId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(
        repository: HomeRepository(
          datasource: HomeDatasource(),
        ),
      )
        ..add(GetSliderImages())
        ..add(GetHospitalTypeListEvent())
        ..add(
          GetHospitalListEvent(
            defaultCityId: storedCityId,
            cityList: cityList,
          ),
        ),
      child: HomeScreenUi(
        cityList: cityList,
        storedCityId: storedCityId,
      ),
    );
  }
}

class HomeScreenUi extends StatefulWidget {
  final List<CityResponse> cityList;
  final String storedCityId;

  const HomeScreenUi(
      {super.key, required this.cityList, required this.storedCityId});

  @override
  State<HomeScreenUi> createState() => _HomeScreenUiState();
}

class _HomeScreenUiState extends State<HomeScreenUi>
    with Methods, NavigateHelper {
  late CityResponse dropDownValue;
  int selectedIndex = 0;
  HospitalTypeResponse? hospitalType;
  List<SliderResponse> sliderList = [];
  List<HospitalTypeResponse> hospitalTypeList = [];
  List<HospitalResponse> hospitalList = [];
  HospitalTypeResponse allTypeHospital = HospitalTypeResponse(typeName: 'All');

  @override
  void initState() {
    if (widget.storedCityId.isEmpty) {
      if (widget.cityList.length == 1) {
        dropDownValue = widget.cityList.first;
      } else {
        CityResponse defualtCity = widget.cityList.firstWhere(
          (e) => e.name?.toLowerCase() == 'surendranagar',
        );
        dropDownValue = defualtCity;
      }
    } else {
      CityResponse existingCity = widget.cityList.firstWhere(
          (element) => element.id.toString() == widget.storedCityId);
      dropDownValue = existingCity;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          if (state is GetSliderImagesSuccessState) {
            sliderList = state.sliderImages;
          }
          if (state is GetHospitalTypeListSuccessState) {
            hospitalTypeList.insert(0, allTypeHospital);
            hospitalTypeList.addAll(state.hospitalTypeList);
          }
          if (state is GetHospitalListByHospitalTypeSuccessState) {
            hospitalList = state.hospitalList;
          }
          if (state is GetHospitalListSuccessState) {
            hospitalList = state.hospitalList;
          }
          if (state is ChangeCityState) {
            dropDownValue = state.selectedCity;
            if (widget.storedCityId.isNotEmpty) {
              SharedPrefs.removeCity();
            } else {
              SharedPrefs.setCity(selectedId: state.selectedCity.id.toString());
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            backgroundColor: AppColor.appBackground,
            appBar: AppBar(
              backgroundColor: AppColor.theme,
              toolbarHeight: 0.h,
              elevation: 0,
            ),
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          color: AppColor.theme,
                          alignment: Alignment.center,
                          height: 7.h,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(Images.appLogo),
                              const Spacer(),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 0.5.h, horizontal: 1.h),
                                decoration: cityContainerDecoration(),
                                child: SizedBox(
                                  height: 2.h,
                                  child: widget.cityList.length == 1
                                      ? Text(
                                          widget.cityList.first.name.toString(),
                                          style: TextStyle(
                                              color: AppColor.homeAppBarText,
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.w600),
                                        )
                                      : DropdownButton(
                                          dropdownColor:
                                              Color.fromRGBO(2, 43, 83, 1),
                                          iconSize: 14.sp,
                                          iconEnabledColor:
                                              AppColor.homeAppBarText,
                                          underline: const SizedBox(),
                                          borderRadius:
                                              BorderRadius.circular(2.h),
                                          style: TextStyle(
                                              color: AppColor.homeAppBarText,
                                              fontSize: 9.sp,
                                              fontWeight: FontWeight.w600),
                                          value: dropDownValue,
                                          items: widget.cityList
                                              .map((e) => DropdownMenuItem(
                                                    value: e,
                                                    child: Text(
                                                      e.name ?? "",
                                                      style: TextStyle(
                                                          fontSize: 9.sp),
                                                    ),
                                                  ))
                                              .toList(),
                                          onChanged: (value) async {
                                            //for change city event
                                            context.read<HomeBloc>().add(
                                                  ChangeCityEvent(
                                                      selectedCity: value!),
                                                );
                                            //for change hospital list by city
                                            context.read<HomeBloc>().add(
                                                  GetHospitalListByHospitalTypeEvent(
                                                    selectedCity: value,
                                                    hospitalTypeResponse:
                                                        hospitalType ??
                                                            allTypeHospital,
                                                  ),
                                                );
                                          },
                                        ),
                                ),
                              ),
                              width(1.h),
                              //Build for search hospital button
                              IconButton(
                                onPressed: () {
                                  push(
                                      context,
                                      SearchHospitalScreen(
                                        hospitalId: dropDownValue.id.toString(),
                                      ));
                                },
                                icon: Icon(
                                  Icons.search,
                                  size: 23.sp,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (state is GetSliderImagesBusyState ||
                            state is GetHospitalTypeListBusyState ||
                            state is GetHospitalListBusyState ||
                            state is GetSliderImagesFailureState) ...[
                          Shimmer.fromColors(
                            baseColor: Colors.grey.shade200,
                            highlightColor: Colors.grey.shade300,
                            child: Container(
                              height: 30.h,
                              color: Colors.grey.shade200,
                            ),
                          ),
                        ] else ...[
                          //Build for slider
                          CustomSlider(imgList: sliderList)
                        ],
                        height(0.5.h),
                      ],
                    ),
                  ),
                  //Build for categoryList
                  SliverAppBar(
                      elevation: 0,
                      pinned: true,
                      automaticallyImplyLeading: false,
                      titleSpacing: 0,
                      backgroundColor: Colors.transparent,
                      titleTextStyle: const TextStyle(
                        color: Colors.black,
                      ),
                      title: Container(
                        height: 6.h,
                        padding: EdgeInsets.symmetric(
                          vertical: 0.5.h,
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: state is GetHospitalTypeListBusyState ||
                                  state is GetHospitalListBusyState ||
                                  state is GetSliderImagesBusyState
                              ? 5
                              : hospitalTypeList.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.only(left: 1.h),
                            child: state is GetHospitalTypeListBusyState ||
                                    state is GetHospitalListBusyState ||
                                    state is GetSliderImagesBusyState
                                ? Shimmer.fromColors(
                                    baseColor: Colors.grey.shade200,
                                    highlightColor: Colors.grey.shade300,
                                    child: Container(
                                      height: 2.h,
                                      width: 10.h,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        border:
                                            Border.all(color: AppColor.border),
                                        borderRadius:
                                            BorderRadius.circular(1.h),
                                      ),
                                    ),
                                  )
                                : CustomCategoryButton(
                                    isAll: hospitalTypeList[index] ==
                                        allTypeHospital,
                                    onTap: () async {
                                      int TypeIndex = hospitalTypeList
                                          .indexWhere((element) =>
                                              element ==
                                              hospitalTypeList[index]);

                                      if (!(state
                                              is GetHospitalListByHospitalTypeBusyState) &&
                                          TypeIndex != selectedIndex) {
                                        context.read<HomeBloc>().add(
                                              GetHospitalListByHospitalTypeEvent(
                                                selectedCity: dropDownValue,
                                                hospitalTypeResponse:
                                                    hospitalTypeList[index],
                                              ),
                                            );
                                        setState(() {
                                          selectedIndex = index;
                                        });
                                      }
                                    },
                                    isSelected: selectedIndex == index,
                                    category:
                                        hospitalTypeList[index].typeName ?? "",
                                  ),
                          ),
                        ),
                      ),
                      centerTitle: false),
                  if (state is GetHospitalListByHospitalTypeBusyState) ...[
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ] else if (hospitalList.isEmpty) ...[
                    if (state is GetHospitalListByHospitalTypeSuccessState) ...[
                      const SliverFillRemaining(
                        child: Center(
                          child: Text(
                            Strings.noHospitalFound,
                          ),
                        ),
                      )
                    ] else ...[
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            return CustomHospitalSkelton();
                          },
                          childCount: 3,
                        ),
                      )
                    ]
                  ] else ...[
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          //Build for hospital List
                          return CustomHospitalTile(
                            hospitalResponse: hospitalList[index],
                          );
                        },
                        childCount:
                            hospitalList.isEmpty ? 1 : hospitalList.length,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  BoxDecoration cityContainerDecoration() {
    return BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(2.5.h),
    );
  }
}
