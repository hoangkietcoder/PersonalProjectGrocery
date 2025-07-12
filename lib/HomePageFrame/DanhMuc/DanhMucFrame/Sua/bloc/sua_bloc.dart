import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:personalprojectgrocery/HomePageFrame/DanhMuc/DanhMucFrame/Sua/bloc/sua_bloc.dart';
import 'package:personalprojectgrocery/tranformer.dart';
import '../../../../../Models/DanhMuc/getDataFirebase/ModelDanhMucFireBase.dart';
import '../../../../../Repository/DanhMuc/sua/SuaRepository.dart';
import 'sua_bloc.dart';

part 'sua_event.dart';
part 'sua_state.dart';

class SuaBloc extends Bloc<SuaEvent, SuaState> {
  SuaBloc({required SuaRepository suaRepo}) : _suaRepository = suaRepo  ,super(SuaState(nameProduct: '', noteProduct: '', phoneSupplier: '', priceProduct: '', quantityProduct: '', supplierName: '')) {


    // đăng kí sự kiện
    on<FetchSuaEvent>(_onFetchSua);
    on<SearchProductDanhMuc>(_onSearchProduct, transformer: debounce(Duration(milliseconds: 1000)));
    // Lắng nghe khi có thay đổi từ khóa

  }

  // truyền repo vào
  final SuaRepository _suaRepository;

  // khởi tạo stream truyền vào là 1 lớp Model ( để lúc thêm sản phẩm xong thì trang home tự fetch lại dữ liệu )
  late final StreamSubscription<List<ModelDanhMucFireBase>> _productSubscription;

  Future<void> _onFetchSua(FetchSuaEvent event, Emitter<SuaState> emit) async {
    emit(state.copyWith(statusLoadSua:  StatusLoadSua.loading));
    try {
      final products = await _suaRepository.getDataDanhMucSua(
        typeProduct: event.typeProduct,
        userId: event.userId,
      );
      print("👉 userId truyền vào: ${event.userId}");



      emit(state.copyWith(
          lstDanhMucSua: products,
          statusLoadSua:  StatusLoadSua.successful));

    } catch (e) {
      emit(state.copyWith(
          error:  e.toString(),
          statusLoadSua:  StatusLoadSua.failure));
    }
  }

  // xử lí thanh tìm kiếm
  Future<void> _onSearchProduct(SearchProductDanhMuc event, Emitter<SuaState> emit,) async{
    try{
      emit(state.copyWith(statusSearch: StatusSearch.initial));
      final data = await _suaRepository.searchProductByName(event.keyword,event.type);
      return emit(state.copyWith(
          lstDanhMucSua: data,
          statusSearch: StatusSearch.successful
      ));
    }catch(error){
      if(isClosed) return;
      return emit(state.copyWith(
          lstDanhMucSua: [],
          statusSearch: StatusSearch.failure
      ));
    }

  }
  }

