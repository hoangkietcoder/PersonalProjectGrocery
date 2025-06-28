import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../Models/DanhMuc/danhmuc_data.dart';
import '../../../Repository/DanhMuc/danhmuc_repository.dart';

part 'danhmuc_event.dart';
part 'danhmuc_state.dart';

class DanhmucBloc extends Bloc<DanhmucEvent, DanhmucState> {
  final DanhMucRepository _danhMucRepository;

  DanhmucBloc({required DanhMucRepository danhmucRepository})
      : _danhMucRepository = danhmucRepository,
        super(DanhmucState()) {
    // Register the event
    on<FetchDanhMucEvent>(_fetchDataDanhMuc);
  }

  Future<void> _fetchDataDanhMuc(FetchDanhMucEvent event, Emitter<DanhmucState> emit) async {
    emit(state.copyWith(danhmucStatus: DanhMucStatus.loading));

    try {
      await _danhMucRepository.fetchDanhMucData((danhMucList) {
          if (!isClosed) {
            emit(state.copyWith(
              danhmucStatus: DanhMucStatus.successful,
              lstDanhMuc: danhMucList,
            ));
          }
        },
            (error) {
          if (!isClosed) {
            emit(state.copyWith(
              danhmucStatus: DanhMucStatus.failure,
              error: error,
            ));
          }
        },
      );
    } catch (error) {
      log("Error fetching data: $error");
      if (!isClosed) {
        emit(state.copyWith(
          danhmucStatus: DanhMucStatus.failure,
          error: error.toString(),
        ));
      }
    }
  }
}
