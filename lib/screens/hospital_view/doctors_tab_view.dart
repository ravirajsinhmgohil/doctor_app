import 'package:doctor_app/screens/home/model/docto_response.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/widgets/custom_square_card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class DoctorsTabView extends StatefulWidget {
  final List<DoctorResponse> doctorList;

  const DoctorsTabView({super.key, required this.doctorList});

  @override
  State<DoctorsTabView> createState() => _DoctorsTabViewUiState();
}

class _DoctorsTabViewUiState extends State<DoctorsTabView> with Methods {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1 / 1.25,
            crossAxisSpacing: 0.5.h,
            mainAxisSpacing: 0.5.h,
          ),
          itemCount: widget.doctorList.length,
          itemBuilder: (context, index) {
            DoctorResponse doctor = widget.doctorList[index];
            return CustomSquareCard(
              image: '${Api.baseUrl}doctor/${doctor.photo}',
              title: doctor.doctorName!,
              subTitle: doctor.specialist?.specialistName,
              text: doctor.experience,
            );
          }),
    );
  }
}
