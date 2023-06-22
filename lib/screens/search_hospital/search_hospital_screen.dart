import 'package:doctor_app/screens/home/model/hospital_response.dart';
import 'package:doctor_app/screens/login/login_screen.dart';
import 'package:doctor_app/screens/search_hospital/bloc/search_hospital_bloc.dart';
import 'package:doctor_app/screens/search_hospital/data/search_hospital_datasource.dart';
import 'package:doctor_app/screens/search_hospital/data/search_hospital_repository.dart';
import 'package:doctor_app/utils/color_helper.dart';
import 'package:doctor_app/utils/method_helper.dart';
import 'package:doctor_app/utils/strings_helper.dart';
import 'package:doctor_app/widgets/custom_hospital_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SearchHospitalScreen extends StatelessWidget {
  final String hospitalId;

  const SearchHospitalScreen({super.key, required this.hospitalId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchHospitalBloc(
        repository: SearchedHospitalRepository(
          datasource: SearchHospitalDatasource(),
        ),
      ),
      child: SearchHospitalScreenUi(
        hospitalId: hospitalId,
      ),
    );
  }
}

class SearchHospitalScreenUi extends StatefulWidget {
  final String hospitalId;
  const SearchHospitalScreenUi({super.key, required this.hospitalId});

  @override
  State<SearchHospitalScreenUi> createState() => _SearchHospitalScreenState();
}

class _SearchHospitalScreenState extends State<SearchHospitalScreenUi>
    with Methods {
  List<HospitalResponse> hospitalList = [];
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchHospitalBloc, SearchHospitalState>(
      listener: (context, state) {
        if (state is SearchedHospitalSuccessState) {
          hospitalList = state.searchedHospitalList;
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            foregroundColor: Colors.white,
            backgroundColor: AppColor.theme,
            elevation: 1,
            leadingWidth: 5.h,
            titleSpacing: 1.h,
            title: TextFormField(
              controller: searchController,
              style: TextStyle(color: Colors.white),
              onChanged: (value) {
                if (value.isNotEmpty) {
                  context.read<SearchHospitalBloc>().add(
                        SearchedHospitalEvent(
                          seachedText: value.trim(),
                          hospitalId: widget.hospitalId,
                        ),
                      );
                } else {
                  setState(() {
                    hospitalList.clear();
                  });
                }
              },
              decoration: InputDecoration(
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 1.h, horizontal: 2.h),
                hintText: Strings.searchHospital,
                focusedBorder: SearchFieldBorder(),
                disabledBorder: SearchFieldBorder(),
                enabledBorder: SearchFieldBorder(),
                border: SearchFieldBorder(),
                hintStyle: TextStyle(color: Colors.white),
              ),
            ),
          ),
          body: state is SearchedHospitalBusyState
              ? Center(
                  child: CustomLoader(color: AppColor.theme),
                )
              : hospitalList.isNotEmpty
                  ? ListView.builder(
                      itemCount: hospitalList.length,
                      itemBuilder: (context, index) => CustomHospitalTile(
                        hospitalResponse: hospitalList[index],
                      ),
                    )
                  : Center(
                      child: Text(
                        Strings.noHospitalFound,
                      ),
                    ),
        );
      },
    );
  }
}
