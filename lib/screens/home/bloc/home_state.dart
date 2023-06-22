part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}
class ChangeCityState extends HomeState {
  final CityResponse selectedCity;

  ChangeCityState({required this.selectedCity});
}
class GetCityListBusyState extends HomeState {}

class GetCityListSuccessState extends HomeState {
  final List<CityResponse> cityList;

  GetCityListSuccessState({required this.cityList});
}

class GetCityListFailureState extends HomeState {}

class GetSliderImagesBusyState extends HomeState {}

class GetSliderImagesSuccessState extends HomeState {
  final List<SliderResponse> sliderImages;

  GetSliderImagesSuccessState({required this.sliderImages});
}

class GetSliderImagesFailureState extends HomeState {}

class GetHospitalTypeListBusyState extends HomeState {}

class GetHospitalTypeListSuccessState extends HomeState {
  final List<HospitalTypeResponse> hospitalTypeList;

  GetHospitalTypeListSuccessState({required this.hospitalTypeList});
}

class GetHospitalTypeListFailureState extends HomeState {}

class GetHospitalListBusyState extends HomeState {}

class GetHospitalListSuccessState extends HomeState {
  final List<HospitalResponse> hospitalList;

  GetHospitalListSuccessState({required this.hospitalList});
}

class GetHospitalListFailureState extends HomeState {}

class GetHospitalListByHospitalTypeBusyState extends HomeState {}

class GetHospitalListByHospitalTypeSuccessState extends HomeState {
  final List<HospitalResponse> hospitalList;

  GetHospitalListByHospitalTypeSuccessState({required this.hospitalList});
}

class GetHospitalListByHospitalTypeFailureState extends HomeState {}
