part of 'hospital_detail_bloc.dart';

@immutable
abstract class HospitalDetailState {}

class HospitalDetailInitial extends HospitalDetailState {}

class GetHospitalProfileBusyState extends HospitalDetailState {}

class GetHospitalProfileSuccessState extends HospitalDetailState {
  final HospitalResponse hospitalResponse;

  GetHospitalProfileSuccessState({required this.hospitalResponse});
}

class GetHospitalSocialLinksBusyState extends HospitalDetailState {}

class GetHospitalSocialLinksSuccessState extends HospitalDetailState {
  final List<SocialLinkResponse> socialLinkList;

  GetHospitalSocialLinksSuccessState({required this.socialLinkList});
}

class GetHospitalSocialLinksFailureState extends HospitalDetailState {}

class GetHospitalProfileFailureState extends HospitalDetailState {}

class GetHospitalGallaryBusyState extends HospitalDetailState {}

class GetHospitalServicesBusyState extends HospitalDetailState {}

class GetHospitalServicesSuccessState extends HospitalDetailState {
  final List<ServiceList> serviceList;

  GetHospitalServicesSuccessState({required this.serviceList});
}

class GetHospitalServicesFailureState extends HospitalDetailState {}

class GetHospitalGallarySuccessState extends HospitalDetailState {
  final List<ImageResponse> imageList;

  GetHospitalGallarySuccessState({required this.imageList});
}

class GetHospitalGallaryFailureState extends HospitalDetailState {}

class GetHospitalDoctorBusyState extends HospitalDetailState {}

class GetHospitalDoctorSuccessState extends HospitalDetailState {
  final List<DoctorResponse> doctoList;

  GetHospitalDoctorSuccessState({required this.doctoList});
}

class GetHospitalDoctorFailureState extends HospitalDetailState {}

class GetHospitalFacilitiesBusyState extends HospitalDetailState {}

class GetHospitalFacilitiesSuccessState extends HospitalDetailState {
  final List<FacilityResponse> facilityList;

  GetHospitalFacilitiesSuccessState({required this.facilityList});
}

class GetHospitalFacilitiesFailureState extends HospitalDetailState {}

class ShowHospitalNumberState extends HospitalDetailState {
  final bool isNumberShow;

  ShowHospitalNumberState({required this.isNumberShow});
}

class AddLeadBusyState extends HospitalDetailState {}

class AddLeadSuccessState extends HospitalDetailState {}

class AddLeadFailureState extends HospitalDetailState {}
