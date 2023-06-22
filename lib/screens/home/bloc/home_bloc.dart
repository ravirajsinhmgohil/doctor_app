import 'package:bloc/bloc.dart';
import 'package:doctor_app/screens/home/data/home_repository.dart';
import 'package:doctor_app/screens/home/model/city_response.dart';
import 'package:doctor_app/screens/home/model/hospital_response.dart';
import 'package:doctor_app/screens/home/model/sllider_response.dart';
import 'package:doctor_app/screens/home/model/hospital_type_response.dart';
import 'package:meta/meta.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeRepository repository;
  HomeBloc({required this.repository}) : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {});
    on<GetCityList>(_getCityList);
    on<ChangeCityEvent>(_changeCity);
    on<GetSliderImages>(_getSliderImages);
    on<GetHospitalTypeListEvent>(_getHospitalTypeList);
    on<GetHospitalListEvent>(_getHospitalList);
    on<GetHospitalListByHospitalTypeEvent>(_getHospitalListByType);
  }
  _getCityList(GetCityList event, Emitter<HomeState> emit) async {
    emit(GetCityListBusyState());
    try {
      dynamic data = await repository.getCityList();
      if (data is Map) {
        if (data['status'] == 200) {
          var cityData = data['data'];
          if (cityData is List) {
            List<CityResponse> cityList =
                cityData.map((e) => CityResponse.fromJson(e)).toList();
            emit(GetCityListSuccessState(cityList: cityList));
          }
        } else {
          emit(GetCityListFailureState());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  _getSliderImages(GetSliderImages event, Emitter<HomeState> emit) async {
    dynamic data = await repository.getSliderImage();
    if (data is Map) {
      if (data['status'] == 200) {
        var cityData = data['data'];
        if (cityData is List) {
          List<SliderResponse> sliderImages =
              cityData.map((e) => SliderResponse.fromJson(e)).toList();
          emit(
            GetSliderImagesSuccessState(sliderImages: sliderImages),
          );
        }
      } else {
        emit(GetSliderImagesFailureState());
      }
    }
  }

  _getHospitalTypeList(
      GetHospitalTypeListEvent event, Emitter<HomeState> emit) async {
    emit(GetHospitalTypeListBusyState());
    dynamic data = await repository.getHospitalTypeList();
    if (data is Map) {
      if (data['status'] == 200) {
        var specialistData = data['data'];
        if (specialistData is List) {
          List<HospitalTypeResponse> hospitalTypeList = specialistData
              .map((e) => HospitalTypeResponse.fromJson(e))
              .toList();
          emit(
            GetHospitalTypeListSuccessState(hospitalTypeList: hospitalTypeList),
          );
        }
      } else {
        emit(GetHospitalTypeListFailureState());
      }
    }
  }

  _getHospitalList(GetHospitalListEvent event, Emitter<HomeState> emit) async {
    emit(GetHospitalListBusyState());
    dynamic data = await repository.getHospitalList();
    if (data is Map) {
      if (data['status'] == 200) {
        var hospitalData = data['data'];
        if (hospitalData is List) {
          List<HospitalResponse> hospitalList =
              hospitalData.map((e) => HospitalResponse.fromJson(e)).toList();
          List<HospitalResponse> finalHospitalList;
          if (event.defaultCityId.isEmpty) {
            CityResponse city = event.cityList.firstWhere(
              (e) => e.name!.toLowerCase() == 'surendranagar',
            );
            finalHospitalList =
                hospitalList.where((e) => e.cityId == city.id).toList();
          } else {
            finalHospitalList = hospitalList
                .where((e) => e.cityId.toString() == event.defaultCityId)
                .toList();
          }
          emit(
            GetHospitalListSuccessState(hospitalList: finalHospitalList),
          );
        }
      } else {
        emit(GetHospitalListFailureState());
      }
    }
  }

  _getHospitalListByType(
      GetHospitalListByHospitalTypeEvent event, Emitter<HomeState> emit) async {
    emit(GetHospitalListByHospitalTypeBusyState());

    if (event.hospitalTypeResponse.typeName == 'All') {
      try {
        dynamic data = await repository.getHospitalList();
        print('code-$data');
        if (data is Map) {
          if (data['status'] == 200) {
            var hospitalData = data['data'];
            if (hospitalData is List) {
              List<HospitalResponse> hospitalList = hospitalData
                  .map((e) => HospitalResponse.fromJson(e))
                  .toList();
              List<HospitalResponse> finalHospitalList = hospitalList
                  .where((e) => e.cityId == event.selectedCity.id)
                  .toList();
              emit(
                GetHospitalListByHospitalTypeSuccessState(
                    hospitalList: finalHospitalList),
              );
            }
          } else {
            emit(GetHospitalListByHospitalTypeFailureState());
          }
        } else {
          print("DATA______");
          print(data);
          emit(GetHospitalListByHospitalTypeFailureState());
        }
      } catch (e) {
        emit(GetHospitalListByHospitalTypeFailureState());

        print('TYPE ERROR---------${e}');
      }
    } else {
      try {
        dynamic data = await repository.getHospitalListById(
            hospitalTypeId: event.hospitalTypeResponse.id.toString());
        if (data is List) {
          var newData = data[0];
          var hospitalData = newData['hospital'];
          if (hospitalData is List) {
            List<HospitalResponse> hospitalList =
                hospitalData.map((e) => HospitalResponse.fromJson(e)).toList();
            List<HospitalResponse> finalHospitalList = hospitalList
                .where((e) => e.cityId == event.selectedCity.id)
                .toList();
            emit(
              GetHospitalListByHospitalTypeSuccessState(
                  hospitalList: finalHospitalList),
            );
          } else {
            emit(GetHospitalListByHospitalTypeFailureState());
          }
        } else {
          emit(GetHospitalListByHospitalTypeFailureState());
          print('fail');

          print(data);
        }
      } catch (e) {
        print('TYPE ERROR---${e}');
        emit(GetHospitalListByHospitalTypeFailureState());
      }
    }
  }

  _changeCity(ChangeCityEvent event, Emitter<HomeState> emit) {
    emit(ChangeCityState(selectedCity: event.selectedCity));
  }
}
