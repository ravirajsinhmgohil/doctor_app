import 'package:doctor_app/screens/hospital_view/model/facilty_response.dart';
import 'package:doctor_app/utils/api_helper.dart';
import 'package:doctor_app/widgets/custom_square_card.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FacilitiesTabView extends StatefulWidget {
  final List<FacilityResponse> facilityList;
  const FacilitiesTabView({super.key, required this.facilityList});

  @override
  State<FacilitiesTabView> createState() => _FacilitiesTabViewUiState();
}

class _FacilitiesTabViewUiState extends State<FacilitiesTabView> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1 / 1.15,
        crossAxisSpacing: 0.5.h,
        mainAxisSpacing: 0.5.h,
      ),
      itemCount: widget.facilityList.length,
      itemBuilder: (context, index) {
        FacilityResponse facility = widget.facilityList[index];
        //Build for facilities card
        return CustomSquareCard(
          image: '${Api.baseUrl}facility/${facility.photo}',
          title: facility.title!,
        );
      },
    );
  }
}
