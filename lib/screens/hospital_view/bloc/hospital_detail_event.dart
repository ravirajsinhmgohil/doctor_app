part of 'hospital_detail_bloc.dart';

@immutable
abstract class HospitalDetailEvent {}

class GetHospitalProfileEvent extends HospitalDetailEvent {
  final String hospitalId;

  GetHospitalProfileEvent({required this.hospitalId});
}

class GetHospitalServicesEvent extends HospitalDetailEvent{
   final String hospitalId;

  GetHospitalServicesEvent({required this.hospitalId});
  
}

class GetHospitalGallaryEvent extends HospitalDetailEvent {
  final String hospitalId;

  GetHospitalGallaryEvent({required this.hospitalId});
}

class GetHospitalDoctorsEvent extends HospitalDetailEvent {
  final String hospitalId;

  GetHospitalDoctorsEvent({required this.hospitalId});
}

class GetHospitalFacilitiesEvent extends HospitalDetailEvent {
  final String hospitalId;

  GetHospitalFacilitiesEvent({required this.hospitalId});
}

class ShowHospitalNumberEvent extends HospitalDetailEvent {}

class GetHospitalSocialLinksEvent extends HospitalDetailEvent {
  final String hospitalId;

  GetHospitalSocialLinksEvent({required this.hospitalId});
}

class AddLeadEvent extends HospitalDetailEvent {
  final LeadRequest leadRequest;

  AddLeadEvent({required this.leadRequest});
}
