import 'package:doctor_app/screens/home/model/hospital_response.dart';
import 'package:doctor_app/screens/hospital_view/bloc/hospital_detail_bloc.dart';
import 'package:doctor_app/screens/hospital_view/data/hospital_view_datasource.dart';
import 'package:doctor_app/screens/hospital_view/data/hospital_view_repository.dart';
import 'package:doctor_app/screens/hospital_view/model/lead_request.dart';
import 'package:doctor_app/screens/hospital_view/model/services_response.dart';
import 'package:doctor_app/screens/hospital_view/model/social_link_response.dart';
import 'package:doctor_app/screens/login/model/login_response.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/image_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:doctor_app/widgets/custom_profile_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class ProfileTabView extends StatelessWidget {
  final HospitalResponse? hospitalData;
  final List<ServiceList> services;
  final List<SocialLinkResponse> socialLinkList;

  final bool isBusy;

  const ProfileTabView(
      {super.key,
      this.hospitalData,
      required this.isBusy,
      required this.services,
      required this.socialLinkList});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalDetailBloc(
          repository:
              HospitalViewRepository(datasource: HospitalViewDatasource())),
      child: ProfileTabViewUi(
        hospitalData: hospitalData,
        socialLinkList: socialLinkList,
        services: services,
        isBusy: isBusy,
      ),
    );
  }
}

class ProfileTabViewUi extends StatefulWidget {
  final List<SocialLinkResponse> socialLinkList;

  final HospitalResponse? hospitalData;
  final List<ServiceList> services;
  final bool isBusy;

  const ProfileTabViewUi({
    super.key,
    this.hospitalData,
    required this.isBusy,
    required this.services,
    required this.socialLinkList,
  });

  @override
  State<ProfileTabViewUi> createState() => _ProfileTabViewState();
}

class _ProfileTabViewState extends State<ProfileTabViewUi> with Methods {
  bool isNumberShow = false;
  LoginResponse? userData;

  @override
  void initState() {
    getLoginData().then((value) {
      userData = value;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HospitalDetailBloc, HospitalDetailState>(
      listener: (context, state) {
        if (state is ShowHospitalNumberState) {
          isNumberShow = state.isNumberShow;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
          child: ListView(
            children: [
              //Build for hospital details
              CustomProfileLabel(
                  label: widget.hospitalData?.hospitalName ?? ''),
              height(1.h),
              //Build for address
              CustomProfileTile(
                icon: Icons.location_pin,
                title: widget.hospitalData?.address ?? '',
                iconSize: 18.sp,
              ),
              height(1.h),
              //Build for hospital time
              CustomProfileTile(
                icon: Icons.watch_later_outlined,
                title: widget.hospitalData?.hospitalTime ?? '',
                iconSize: 18.sp,
              ),
              //Build for hospital contact
              height(1.h),
              CustomProfileTile(
                icon: Icons.call,
                trailingWidget: InkWell(
                  onTap: () async {
                    if (isNumberShow == false) {
                      context
                          .read<HospitalDetailBloc>()
                          .add(ShowHospitalNumberEvent());
                      LeadRequest leadRequest = LeadRequest(
                          type: 'Show number',
                          hospitalId: widget.hospitalData?.id.toString() ?? '',
                          userId: userData?.data?.id.toString());
                      context
                          .read<HospitalDetailBloc>()
                          .add(AddLeadEvent(leadRequest: leadRequest));
                    }
                  },
                  child: Text(
                    'Show',
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColor.theme,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                titleWidget: Text(
                  isNumberShow == false
                      ? '${widget.hospitalData?.contactNo?.substring(0, 2)}******${widget.hospitalData?.contactNo?.substring(8, 10)}'
                      : '${widget.hospitalData?.contactNo}',
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleHelper.hospitalDetail,
                ),
                iconSize: 18.sp,
              ),
              height(2.h),
              //Build for services
              if (widget.services.isNotEmpty) ...[
                if (widget.services[0].services?.isNotEmpty ?? false) ...[
                  const CustomProfileLabel(
                    label: Strings.services,
                  ),
                  height(1.h),
                  Wrap(
                    spacing: 1.h,
                    runSpacing: 1.h,
                    children: [
                      ...widget.services.first.services!.split(',').map(
                            (e) => ServiceContainer(
                              serviceName: e,
                            ),
                          ),
                    ],
                  ),
                ],
                height(2.h),
              ],

              if (widget.socialLinkList.isNotEmpty) ...[
                //Build for social links

                const CustomProfileLabel(label: Strings.socialLinks),
                height(1.h),
                Wrap(
                  children: [
                    // for facebook
                    ...widget.socialLinkList.map((e) => Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 0.5.h, vertical: 1.h),
                          child: CustomCircleImage(
                            borderColor: Colors.white,
                            backgroundColor: Colors.white,
                            imagePath: e.title == 'Facebook'
                                ? Images.facebookLogo
                                : e.title == 'Instagram'
                                    ? Images.instagramLogo
                                    : e.title == 'Twitter'
                                        ? Images.twitterLogo
                                        : e.title == 'LinkedIn'
                                            ? Images.linkedIn
                                            : e.title == 'Website'
                                                ? Images.websiteLogo
                                                : Images.otherLink,
                            onTap: () async {
                              await httpsLauch(
                                link: e.link ?? '',
                              );
                              //for add lead
                              addLead(
                                context: context,
                                type: e.title ?? 'Social Link',
                                hospitalId:
                                    widget.hospitalData?.id.toString() ?? '',
                              );
                            },
                          ),
                        )),
                  ],
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class CustomCircleImage extends StatelessWidget {
  final String? imagePath;
  final Widget? widget;
  final double? radius;
  final double? borderWidth;
  final Color? backgroundColor;
  final Color? borderColor;
  final void Function()? onTap;

  const CustomCircleImage({
    this.imagePath,
    this.widget,
    super.key,
    this.radius,
    this.backgroundColor,
    this.borderColor,
    this.onTap,
    this.borderWidth,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(2.h),
      child: Container(
        alignment: Alignment.center,
        height: radius ?? 6.h,
        width: radius ?? 6.h,
        decoration: BoxDecoration(
          color: backgroundColor ?? Colors.grey.shade300,
          border: Border.all(
            width: borderWidth ?? 1.0,
            color: borderColor ?? AppColor.theme,
          ),
          shape: BoxShape.circle,
        ),
        padding: EdgeInsets.all(0.5.h),
        child: widget ??
            (imagePath != null
                ? Image.asset(
                    imagePath!,
                  )
                : const SizedBox.shrink()),
      ),
    );
  }
}

class ServiceContainer extends StatelessWidget {
  final String serviceName;
  const ServiceContainer({
    super.key,
    required this.serviceName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.h),
          border: Border.all(color: AppColor.theme)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 1.5.h),
        child: Text(
          serviceName,
          style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class CustomProfileTile extends StatelessWidget with Methods {
  final IconData icon;
  final Widget? titleWidget;
  final Widget? trailingWidget;

  final String? title;
  final double? iconSize;
  const CustomProfileTile(
      {super.key,
      required this.icon,
      this.trailingWidget,
      this.title,
      this.iconSize,
      this.titleWidget});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: AppColor.theme,
          size: iconSize,
        ),
        width(1.h),
        Flexible(
          child: Column(
            children: [
              if (title != null) ...[
                Text(
                  title!,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleHelper.hospitalDetail,
                ),
              ],
              if (titleWidget != null) ...[
                Row(
                  children: [
                    Expanded(child: titleWidget!),
                    trailingWidget != null
                        ? trailingWidget!
                        : const SizedBox.shrink()
                  ],
                )
              ]
            ],
          ),
        )
      ],
    );
  }
}
