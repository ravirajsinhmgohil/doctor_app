part of 'search_hospital_bloc.dart';

@immutable
abstract class SearchHospitalState {}

class SearchHospitalInitial extends SearchHospitalState {}

class SearchedHospitalBusyState extends SearchHospitalState {}

class SearchedHospitalSuccessState extends SearchHospitalState {
  final List<HospitalResponse> searchedHospitalList;

  SearchedHospitalSuccessState({required this.searchedHospitalList});
}

class SearchedHospitalFailureState extends SearchHospitalState {}
