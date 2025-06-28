import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import '../../../../Models/Bill/create_bill.dart';
import '../../../../Repository/Bill/bill_repository.dart';

part 'themhoadon_event.dart';
part 'themhoadon_state.dart';

class ThemhoadonBloc extends Bloc<ThemhoadonEvent, ThemhoadonState> {
  ThemhoadonBloc({required String date, required BillRepository billRepo})  : _billRepository= billRepo,super(ThemhoadonState(date: date)) {

    // đăng kí sự kiện
  on<CreateNameBill>(_onCreateNameBill);
  on<CreateNameSellerBill>(_onCreateNameSellerBill);

  on<CreateNameBuyerBill>(_onCreateNameBuyerBill);
  on<CreateDateBill>(_onCreateDateBill);
  on<CreateTotalPriceBill>(_onCreateTotalPriceBill);
  on<CreateNoteBill>(_onCreateNoteBill);
  on<CreateBillRequested>(_onCreateBill);





  }



  //=====================================================================

  // truyền repo
  final BillRepository _billRepository;

  // truyền vào state
  void _onCreateNameBill(CreateNameBill event,
      Emitter<ThemhoadonState> emit) {
    emit(
        state.copyWith(nameBill: event.nameBill,)
    );
  }

  void _onCreateNameSellerBill(CreateNameSellerBill event,
      Emitter<ThemhoadonState> emit) {
    emit(
        state.copyWith(nameSeller: event.nameSeller,)
    );
  }

  void _onCreateNameBuyerBill(CreateNameBuyerBill event,
      Emitter<ThemhoadonState> emit) {
    emit(
        state.copyWith(nameBuyer: event.nameBuyer,)
    );
  }

  void _onCreateDateBill(CreateDateBill event,
      Emitter<ThemhoadonState> emit) {
    emit(
        state.copyWith(date: event.dateBill,)
    );
  }

  void _onCreateTotalPriceBill(CreateTotalPriceBill event,
      Emitter<ThemhoadonState> emit) {
    emit(
        state.copyWith(totalPriceBill: event.totalPriceBill,)
    );
  }

  void _onCreateNoteBill(CreateNoteBill event,
      Emitter<ThemhoadonState> emit) {
    emit(
        state.copyWith(noteBill: event.noteBill,)
    );
  }

  // xử lý nút tạo hóa đơn
  Future<void> _onCreateBill(CreateBillRequested event, Emitter<ThemhoadonState> emit) async {
    try {
      emit(
          state.copyWith(billStatus: BillStatus.loading)
      );
      final uuid = Uuid();
      await _billRepository.createBillToFirebase(createBill: CreateBill(
          idBill: uuid.v4(), // Mã bill tự động,
          nameBill: state.nameBill,
          nameSeller: state.nameSeller,
          nameBuyer: state.nameBuyer,
          date: state.date,
          totalPriceBill: state.totalPriceBill,
          noteBill: state.noteBill
      ));
      if(isClosed) return;
      emit(state.copyWith(billStatus: BillStatus.successful)
      );
    } catch (error) {
      log("feefes$error");
      if(isClosed) return;
      emit(
          state.copyWith(
              billStatus: BillStatus.failure,
              error: error.toString()
          )
      );
    }

  }


}


