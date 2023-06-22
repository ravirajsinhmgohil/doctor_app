import 'package:bloc/bloc.dart';
import 'package:doctor_app/screens/home/model/hospital_response.dart';
import 'package:doctor_app/screens/search_hospital/data/search_hospital_repository.dart';
import 'package:meta/meta.dart';

part 'search_hospital_event.dart';
part 'search_hospital_state.dart';

class SearchHospitalBloc
    extends Bloc<SearchHospitalEvent, SearchHospitalState> {
  final SearchedHospitalRepository repository;
  SearchHospitalBloc({required this.repository})
      : super(SearchHospitalInitial()) {
    on<SearchHospitalEvent>((event, emit) {});
    on<SearchedHospitalEvent>(_searchedHospital);
  }
  _searchedHospital(
      SearchedHospitalEvent event, Emitter<SearchHospitalState> emit) async {
    emit(SearchedHospitalBusyState());
    try {
      dynamic data = await repository.searchedHospital(
          hospitalId: event.hospitalId, searchedText: event.seachedText);
      print(data);
      if (data is Map) {
        if (data['status'] == 200) {
          var responseData = data['data'];
          if (responseData is List) {
            List<HospitalResponse> searchedHospitalList =
                responseData.map((e) => HospitalResponse.fromJson(e)).toList();

            emit(SearchedHospitalSuccessState(
                searchedHospitalList: searchedHospitalList));
          } else {
            emit(SearchedHospitalFailureState());
          }
        }
      }
    } catch (e) {
      print('search');
      print(e.toString());
    }
  }
}
