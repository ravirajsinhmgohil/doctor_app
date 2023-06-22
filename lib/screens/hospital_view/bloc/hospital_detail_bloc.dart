import 'package:bloc/bloc.dart';
import 'package:doctor_app/screens/home/model/docto_response.dart';
import 'package:doctor_app/screens/home/model/hospital_response.dart';
import 'package:doctor_app/screens/hospital_view/data/hospital_view_repository.dart';
import 'package:doctor_app/screens/hospital_view/model/facilty_response.dart';
import 'package:doctor_app/screens/hospital_view/model/gallary_response.dart';
import 'package:doctor_app/screens/hospital_view/model/lead_request.dart';
import 'package:doctor_app/screens/hospital_view/model/services_response.dart';
import 'package:doctor_app/screens/hospital_view/model/social_link_response.dart';
import 'package:meta/meta.dart';

part 'hospital_detail_event.dart';
part 'hospital_detail_state.dart';

class HospitalDetailBloc
    extends Bloc<HospitalDetailEvent, HospitalDetailState> {
  final HospitalViewRepository repository;

  HospitalDetailBloc({required this.repository})
      : super(HospitalDetailInitial()) {
    on<HospitalDetailEvent>((event, emit) {});
    on<GetHospitalServicesEvent>(_getHospitalService);
    on<GetHospitalProfileEvent>(_getHospitalProfile);
    on<GetHospitalSocialLinksEvent>(_getSocialLink);
    on<GetHospitalGallaryEvent>(_getHospitalGallary);
    on<GetHospitalDoctorsEvent>(_getHospitalDoctors);
    on<GetHospitalFacilitiesEvent>(_getHospitalFacility);
    on<ShowHospitalNumberEvent>(_showHospitalNumber);
    on<AddLeadEvent>(_addLead);
  }
  _getHospitalProfile(
      GetHospitalProfileEvent event, Emitter<HospitalDetailState> emit) async {
    emit(GetHospitalProfileBusyState());
    dynamic data =
        await repository.getHospitalProfile(hospitalId: event.hospitalId);
    if (data is Map) {
      if (data['status'] == 200) {
        var hospitalData = data['data'];
        HospitalResponse hospitalResponse =
            HospitalResponse.fromJson(hospitalData);
        emit(
            GetHospitalProfileSuccessState(hospitalResponse: hospitalResponse));
      } else {
        emit(GetHospitalProfileFailureState());
      }
    }
  }

  _getHospitalGallary(
      GetHospitalGallaryEvent event, Emitter<HospitalDetailState> emit) async {
    emit(GetHospitalGallaryBusyState());
    dynamic data = await repository.getGallary(hospitalId: event.hospitalId);
    if (data is Map) {
      if (data['status'] == 200) {
        var gallaryData = data['data'];
        if (gallaryData is List) {
          List<ImageResponse> specialistList =
              gallaryData.map((e) => ImageResponse.fromJson(e)).toList();
          emit(
            GetHospitalGallarySuccessState(imageList: specialistList),
          );
        }
      } else {
        emit(GetHospitalGallaryFailureState());
      }
    }
  }

  _getHospitalDoctors(
      GetHospitalDoctorsEvent event, Emitter<HospitalDetailState> emit) async {
    emit(GetHospitalDoctorBusyState());
    dynamic data = await repository.getDoctors(hospitalId: event.hospitalId);
    if (data is Map) {
      if (data['status'] == 200) {
        var doctorsData = data['data'];
        if (doctorsData is List) {
          List<DoctorResponse> specialistList =
              doctorsData.map((e) => DoctorResponse.fromJson(e)).toList();
          emit(
            GetHospitalDoctorSuccessState(doctoList: specialistList),
          );
        }
      } else {
        emit(GetHospitalDoctorFailureState());
      }
    }
  }

  _getHospitalFacility(GetHospitalFacilitiesEvent event,
      Emitter<HospitalDetailState> emit) async {
    emit(GetHospitalFacilitiesBusyState());
    dynamic data = await repository.getFacilities(hospitalId: event.hospitalId);
    if (data is Map) {
      if (data['status'] == 200) {
        var hospitalData = data['data'];

        if (hospitalData is List) {
          List<FacilityResponse> hospitalFacilities =
              hospitalData.map((e) => FacilityResponse.fromJson(e)).toList();
          emit(
            GetHospitalFacilitiesSuccessState(facilityList: hospitalFacilities),
          );
        }
      } else {
        emit(GetHospitalProfileFailureState());
      }
    }
  }

  _showHospitalNumber(
      ShowHospitalNumberEvent event, Emitter<HospitalDetailState> emit) {
    emit(ShowHospitalNumberState(isNumberShow: true));
  }

  _addLead(AddLeadEvent event, Emitter<HospitalDetailState> emit) async {
    emit(AddLeadBusyState());
    dynamic data = await repository.addLead(leadRequest: event.leadRequest);

    if (data is Map) {
      print(data['success'] == true);
      if (data['success'] == true) {
        emit(AddLeadSuccessState());
      } else {
        emit(AddLeadFailureState());
      }
    }
    print('lead ----${data}');
  }

  _getHospitalService(
      GetHospitalServicesEvent event, Emitter<HospitalDetailState> emit) async {
    emit(GetHospitalServicesBusyState());
    dynamic data =
        await repository.getHospitalServices(hospitalId: event.hospitalId);
    ServicesResponse servicesResponse = ServicesResponse.fromJson(data);
    if (servicesResponse.status == 200) {
      emit(GetHospitalServicesSuccessState(
          serviceList: servicesResponse.serviceList ?? []));
    } else {
      emit(GetHospitalServicesFailureState());
    }
  }

  _getSocialLink(GetHospitalSocialLinksEvent event,
      Emitter<HospitalDetailState> emit) async {
    emit(GetHospitalSocialLinksBusyState());
    dynamic responseData =
        await repository.getSocialLinks(hospitalId: event.hospitalId);
    if (responseData is Map) {
      if (responseData['status'] == 200) {
        var dataList = responseData['data'];
        if (dataList is List) {
          List<SocialLinkResponse> socialLinkList =
              dataList.map((e) => SocialLinkResponse.fromJson(e)).toList();
          emit(GetHospitalSocialLinksSuccessState(
              socialLinkList: socialLinkList));
        }
      } else {
        emit(GetHospitalSocialLinksFailureState());
      }
    }
  }
}
