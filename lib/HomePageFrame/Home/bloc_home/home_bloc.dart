import 'dart:async';
import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import '../../../Models/Product/getData_ProductFromFirebase.dart';
import '../../../Repository/Firebase_Database/Product/product_repository.dart';
import '../../../tranformer.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required ProductRepository productRepository}) :_productRepository = productRepository,
        super(HomeState(hasReachedEnd: false ,lsProduct: []
            
      )) {

    // đăng kí sự kiện
    on<_ProductHomeEventChange>(_onProductChanged);
    on<SearchProductHomeEventChange>(_onSearchProductChanged, transformer: debounce(Duration(milliseconds: 500)));
    // on<FetchPage>(_onPageFetched);



    // lắng nghe sự kiện ( khi có sự kiện thì auto cập nhật - cho chức năng thêm sản phẩm)
    _productSubscription = _productRepository.createProduct.listen((data) {
      print("📥 Stream nhận ${data.length} sản phẩm"); // Dòng này chạy mấy lần khi reload?
      add(_ProductHomeEventChange(data));
    }
    );


  }
  final ProductRepository _productRepository;

  // khởi tạo stream truyền vào là 1 lớp Model ( để lúc thêm sản phẩm xong thì trang home tự fetch lại dữ liệu )
  late final StreamSubscription<List<getDataProduct>> _productSubscription;




  @override
  Future<void> close() {
    _productSubscription.cancel();

    return super.close();
  }

  // tự động dùng khi bấm nút thêm sản phẩm ( tự fetch )
  void _onProductChanged(
      _ProductHomeEventChange event,
      Emitter<HomeState> emit,
      ){
    return emit(state.copyWith(
      lsProduct: event.lsProduct,
      statusHome: StatusHome.successful
    ));
  }



  // xử lí thanh tìm kiếm
  Future<void> _onSearchProductChanged(SearchProductHomeEventChange event, Emitter<HomeState> emit,) async{
    try{
      emit(state.copyWith(statusHome: StatusHome.initial));
      final data = await _productRepository.searchItemsByName(event.query);
      return emit(state.copyWith(
          lsProduct: data,
          statusHome: StatusHome.successful
      ));
    }catch(error){
      if(isClosed) return;
      return emit(state.copyWith(
          lsProduct: [],
          statusHome: StatusHome.failure
      ));
    }

  }


  // xử lí phân trang
  // Future<void> _onPageFetched(FetchPage event, Emitter<HomeState> emit) async {
  //   // xử lí nếu hết danh sách sẽ return lại
  //   if (state.hasReachedEnd) return;
  //
  //   try {
  //     emit(state.copyWith(statusLoadPage: StatusLoadPage.loading));
  //     await Future.delayed(const Duration(milliseconds: 800)); //  Thêm delay để load trang chậm hơn
  //
  //     const pageSize = 3;
  //     // gọi hàm lấy sản phẩm
  //     final newProducts = await _productRepository.fetchProducts(limit: pageSize);
  //
  //     // nếu danh sách rỗng => hasReachedEnd: true chặn không cho load thêm nữa
  //     if (newProducts.isEmpty) {
  //       emit(state.copyWith(hasReachedEnd: true));
  //     } else {
  //       // nếu còn dữ liệu thì Gộp danh sách sản phẩm cũ state.lsProduct với danh sách mới newProducts
  //       emit(state.copyWith(
  //         statusLoadPage: StatusLoadPage.success,
  //         lsProduct: List.of(state.lsProduct)..addAll(newProducts),
  //         hasReachedEnd: newProducts.length < pageSize  // Đánh dấu kết thúc nếu ít hơn pageSize
  //       ));
  //     }
  //   } catch (_) {
  //     emit(state.copyWith(statusLoadPage: StatusLoadPage.failure));
  //   }
  // }

}
