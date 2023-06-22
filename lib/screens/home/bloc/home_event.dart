part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class GetCityList extends HomeEvent {}

class GetSliderImages extends HomeEvent {}

class ChangeCityEvent extends HomeEvent {
  final CityResponse selectedCity;

  ChangeCityEvent({required this.selectedCity});
}

class GetCityWiseHospital extends HomeEvent {}

class GetHospitalTypeListEvent extends HomeEvent {}

class GetHospitalListEvent extends HomeEvent {
  final String defaultCityId;
  final List<CityResponse> cityList;

  GetHospitalListEvent({required this.defaultCityId, required this.cityList});
}

class GetHospitalListByHospitalTypeEvent extends HomeEvent {
  final HospitalTypeResponse hospitalTypeResponse;
  final CityResponse selectedCity;

  GetHospitalListByHospitalTypeEvent(
      {required this.selectedCity, required this.hospitalTypeResponse});
}
