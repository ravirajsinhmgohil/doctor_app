import 'package:doctor_app/screens/home/model/hospital_response.dart';
import 'package:doctor_app/screens/hospital_view/hospital_view_screen.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/navigate_helper.dart';
import 'package:doctor_app/utils/text_style_helper.dart';
import 'package:doctor_app/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CustomHospitalTile extends StatelessWidget with Methods, NavigateHelper {
  final HospitalResponse? hospitalResponse;
  const CustomHospitalTile({super.key, this.hospitalResponse});

  @override
  Widget build(BuildContext context) {
    final tileRadius = BorderRadius.circular(1.h);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0.5.h, horizontal: 1.h),
      child: InkWell(
        borderRadius: tileRadius,
        onTap: () {
          push(
            context,
            HospitalViewScreen(
              hospitalId: hospitalResponse!.id!.toString(),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: tileRadius,
              border: Border.all(color: AppColor.border)),
          height: 13.h,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.all(0.8.h),
            child: Row(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: 30.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(1.h),
                    child: CustomCachedImage(
                      fit: BoxFit.fill,
                      image:
                          '${Api.baseUrl}hospital/${hospitalResponse!.hospitalLogo}',
                      containerHeight: double.infinity,
                    ),
                  ),
                ),
                width(1.h),
                SizedBox(
                  width: 58.w,
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        hospitalResponse!.hospitalName!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleHelper.hospitalTileTitle,
                        maxLines: 1,
                      ),
                      height(1.h),
                      Text(
                        hospitalResponse!.address!,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyleHelper.hospitalTileSubTitle,
                        maxLines: 2,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
