part of 'search_hospital_bloc.dart';

@immutable
abstract class SearchHospitalEvent {}

class SearchedHospitalEvent extends SearchHospitalEvent {
  final String seachedText;
  final String hospitalId;

  SearchedHospitalEvent({required this.seachedText, required this.hospitalId});
}
