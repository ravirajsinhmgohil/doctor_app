import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_app/screens/connection_error/bloc/connection_error_bloc.dart';
import 'package:doctor_app/screens/home/model/docto_response.dart';
import 'package:doctor_app/screens/home/model/hospital_response.dart';
import 'package:doctor_app/screens/hospital_view/bloc/hospital_detail_bloc.dart';
import 'package:doctor_app/screens/hospital_view/data/hospital_view_datasource.dart';
import 'package:doctor_app/screens/hospital_view/data/hospital_view_repository.dart';
import 'package:doctor_app/screens/hospital_view/doctors_tab_view.dart';
import 'package:doctor_app/screens/hospital_view/facilities_tab_view.dart';
import 'package:doctor_app/screens/hospital_view/gallary_tab_view.dart';
import 'package:doctor_app/screens/hospital_view/model/facilty_response.dart';
import 'package:doctor_app/screens/hospital_view/model/gallary_response.dart';
import 'package:doctor_app/screens/hospital_view/model/lead_request.dart';
import 'package:doctor_app/screens/hospital_view/model/services_response.dart';
import 'package:doctor_app/screens/hospital_view/model/social_link_response.dart';
import 'package:doctor_app/screens/hospital_view/profile_tab_view.dart';
import 'package:doctor_app/screens/login/login_screen.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/list_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';

class HospitalViewScreen extends StatelessWidget {
  final String hospitalId;
  const HospitalViewScreen({super.key, required this.hospitalId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalDetailBloc(
        repository: HospitalViewRepository(
          datasource: HospitalViewDatasource(),
        ),
      )
        ..add(GetHospitalSocialLinksEvent(hospitalId: hospitalId))
        ..add(GetHospitalProfileEvent(hospitalId: hospitalId))
        ..add(GetHospitalGallaryEvent(hospitalId: hospitalId))
        ..add(GetHospitalDoctorsEvent(hospitalId: hospitalId))
        ..add(GetHospitalFacilitiesEvent(hospitalId: hospitalId))
        ..add(GetHospitalServicesEvent(hospitalId: hospitalId)),
      child: HospitalViewScreenUi(
        hospitalId: hospitalId,
      ),
    );
  }
}

class HospitalViewScreenUi extends StatefulWidget {
  final String hospitalId;
  const HospitalViewScreenUi({super.key, required this.hospitalId});

  @override
  State<HospitalViewScreenUi> createState() => _HospitalViewScreenState();
}

class _HospitalViewScreenState extends State<HospitalViewScreenUi>
    with TickerProviderStateMixin, Methods {
  HospitalResponse? hospitalData;
  List<ImageResponse> imageList = [];
  List<DoctorResponse> doctorList = [];
  List<FacilityResponse> facilityList = [];
  List<ServiceList> services = [];
  List<SocialLinkResponse> socialLinkList = [];

  // HospitalResponse? hospital;
  late TabController tabController;
  String? token;

  @override
  void initState() {
    tabController =
        TabController(length: ListHelper.tabList.length, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.appBackground,
      body: BlocConsumer<ConnectionErrorBloc, ConnectionErrorState>(
        listener: (context, state) {
          if (state is CheckConnectionSuccessState) {
            context.read<HospitalDetailBloc>().add(
                GetHospitalSocialLinksEvent(hospitalId: widget.hospitalId));
            context
                .read<HospitalDetailBloc>()
                .add(GetHospitalGallaryEvent(hospitalId: widget.hospitalId));
            context
                .read<HospitalDetailBloc>()
                .add(GetHospitalProfileEvent(hospitalId: widget.hospitalId));
            context
                .read<HospitalDetailBloc>()
                .add(GetHospitalServicesEvent(hospitalId: widget.hospitalId));
            context
                .read<HospitalDetailBloc>()
                .add(GetHospitalFacilitiesEvent(hospitalId: widget.hospitalId));
            context
                .read<HospitalDetailBloc>()
                .add(GetHospitalDoctorsEvent(hospitalId: widget.hospitalId));
          }
        },
        builder: (context, state) {
          return BlocConsumer<HospitalDetailBloc, HospitalDetailState>(
            listener: (context, state) {
              if (state is GetHospitalProfileSuccessState) {
                hospitalData = state.hospitalResponse;
              }
              if (state is GetHospitalGallarySuccessState) {
                imageList = state.imageList;
              }
              if (state is GetHospitalDoctorSuccessState) {
                doctorList = state.doctoList;
              }
              if (state is GetHospitalFacilitiesSuccessState) {
                facilityList = state.facilityList;
              }
              if (state is GetHospitalServicesSuccessState) {
                services = state.serviceList;
              }
              if (state is GetHospitalSocialLinksSuccessState) {
                socialLinkList = state.socialLinkList;
              }
            },
            builder: (context, state) {
              return SafeArea(
                  bottom: false,
                  child: Column(
                    children: [
                      if (hospitalData?.hospitalLogo?.isNotEmpty ?? false) ...[
                        CachedNetworkImage(
                          imageUrl:
                              '${Api.baseUrl}hospital/${hospitalData!.hospitalLogo}',
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover),
                            ),
                            height: 30.h,
                            child: Stack(
                              children: const [CustomBackButton()],
                            ),
                          ),
                          placeholder: (context, url) => Container(
                            height: 30.h,
                          ),
                          errorWidget: (context, url, error) => SizedBox(
                            height: 30.h,
                            child: const Icon(Icons.error_outline),
                          ),
                        ),
                      ] else ...[
                        Stack(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.grey.shade200,
                              highlightColor: Colors.grey.shade300,
                              child: Container(
                                color: Colors.grey.shade200,
                                height: 30.h,
                              ),
                            ),
                            const CustomBackButton()
                          ],
                        ),
                      ],
                      CustomTabBar(tabController: tabController),
                      //Build for tabBarView
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: [
                            hospitalData?.hospitalLogo?.isNotEmpty ?? false
                                ? ProfileTabView(
                                    hospitalData: hospitalData,
                                    socialLinkList: socialLinkList,
                                    services: services,
                                    isBusy: state
                                            is GetHospitalProfileBusyState ||
                                        state is GetHospitalServicesBusyState ||
                                        state
                                            is GetHospitalSocialLinksBusyState,
                                  )
                                : const Center(
                                    child: CustomLoader(color: AppColor.theme),
                                  ),
                            GallaryTabView(imageList: imageList),
                            DoctorsTabView(
                              doctorList: doctorList,
                            ),
                            FacilitiesTabView(facilityList: facilityList),
                          ],
                        ),
                      ),
                    ],
                  ));
            },
          );
        },
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(left: 1.5.h, right: 1.5.h, bottom: 1.5.h),
          child: Row(
            children: [
              Expanded(
                child: CustomIconButton(
                  title: 'Location',
                  icon: Icons.location_on_outlined,
                  backgroundColor: AppColor.theme,
                  onPressed: () async {
                    await MapsLauncher.launchQuery(
                            '${hospitalData?.hospitalName},${hospitalData?.address}')
                        .then(
                      (value) => getLoginData().then(
                        (value) {
                          print(value.data?.id);
                          LeadRequest leadRequest = LeadRequest(
                              type: 'Location',
                              hospitalId: hospitalData?.id.toString() ?? '',
                              userId: value.data?.id.toString() ?? '');
                          context
                              .read<HospitalDetailBloc>()
                              .add(AddLeadEvent(leadRequest: leadRequest));
                        },
                      ),
                    );
                  },
                ),
              ),
              width(2.h),
              Expanded(
                child: CustomIconButton(
                  title: Strings.callNow,
                  icon: Icons.call,
                  backgroundColor: AppColor.theme,
                  onPressed: () async {
                    //build for navigate to dialer
                    await urlLaunchMethod(
                        scheme: 'tel', path: hospitalData!.contactNo ?? '');
                    getLoginData().then(
                      (value) {
                        print(value.data?.id);
                        LeadRequest leadRequest = LeadRequest(
                            type: 'Call',
                            hospitalId: hospitalData?.id.toString() ?? '',
                            userId: value.data?.id.toString() ?? '');
                        context
                            .read<HospitalDetailBloc>()
                            .add(AddLeadEvent(leadRequest: leadRequest));
                      },
                    );
                  },
                ),
              )
            ],
          )),
    );
  }
}

class CustomIconButton extends StatelessWidget with Methods {
  final void Function() onPressed;
  final String title;
  final IconData icon;
  final Color? IconColor;
  final Color backgroundColor;
  const CustomIconButton(
      {super.key,
      required this.onPressed,
      required this.title,
      required this.icon,
      required this.backgroundColor,
      this.IconColor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2.h),
          ),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: IconColor),
            width(1.h),
            Text(
              title,
              style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
            ),
            width(1.h),
          ],
        ),
      ),
    );
  }
}

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 1.h,
      left: 2.h,
      child: InkWell(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: CircleAvatar(
          radius: 2.h,
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_back,
            size: 18.sp,
            color: AppColor.appbarText,
          ),
        ),
      ),
    );
  }
}

class CustomTabBar extends StatelessWidget {
  const CustomTabBar({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 5.h,
      child: Align(
        child: TabBar(
          labelPadding: EdgeInsets.only(right: 1.h),
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
          indicatorColor: AppColor.theme,
          labelColor: Colors.black,
          tabs: ListHelper.tabList,
          controller: tabController,
        ),
      ),
    );
  }
}
