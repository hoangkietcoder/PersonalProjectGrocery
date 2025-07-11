 part of 'model_product_local_bloc.dart';


 enum StatusSaveDataLocal {inittial , loading, success, failure}
 enum StatusGetDataLocal {inittial , loading, success, failure}
 enum StatusDeleteDataLocal {inittial , loading, success, failure}


  class ModelProductLocalState extends Equatable {
   const ModelProductLocalState({

    this.lstModelProductLocal = const [],
    this.statusSaveDataLocal = StatusSaveDataLocal.inittial,
    this.statusGetDataLocal = StatusGetDataLocal.inittial,
    this.statusDeleteDataLocal = StatusDeleteDataLocal.inittial,
    this.fireBaseId = "",
    this.img_url = "",
    this.nameProduct = "",
    this.quantityProduct = "",
    this.priceProduct = "",
    this.supplierName = "",
    this.phoneSupplier = "",
    this.noteProduct = "",
    this.error = "",
    this.totalPriceInCart = 0,
    this.quantityProductViewCart = 0,


   });

   final List<ModelProductLocal> lstModelProductLocal;
   final StatusSaveDataLocal statusSaveDataLocal;
   final StatusGetDataLocal statusGetDataLocal;
   final StatusDeleteDataLocal statusDeleteDataLocal;
   final String fireBaseId;
   final String img_url;
   final String nameProduct;
   final String quantityProduct;
   final String priceProduct;
   final String supplierName;
   final String phoneSupplier;
   final String noteProduct;
   final String error;
   final int totalPriceInCart;
   final int quantityProductViewCart; // hiển thị số lượng trên cart giỏ hàng trước khi push vào giỏ hàng

   ModelProductLocalState copyWith({
    List<ModelProductLocal>? lstModelProductLocal,
    StatusSaveDataLocal? statusSaveDataLocal,
    StatusGetDataLocal? statusGetDataLocal,
    StatusDeleteDataLocal? statusDeleteDataLocal,
    String? fireBaseId,
    String? img_url,
    String? nameProduct,
    String? quantityProduct,
    String? priceProduct,
    String? supplierName,
    String? phoneSupplier,
    String? noteProduct,
    String? error,
    int? totalPriceInCart,
    int? quantityProductViewCart,
   }) {
    return ModelProductLocalState(
     lstModelProductLocal: lstModelProductLocal ?? this.lstModelProductLocal,
     statusSaveDataLocal: statusSaveDataLocal ?? this.statusSaveDataLocal,
     statusGetDataLocal: statusGetDataLocal ?? this.statusGetDataLocal,
     statusDeleteDataLocal: statusDeleteDataLocal ?? this.statusDeleteDataLocal,
     fireBaseId: fireBaseId ?? this.fireBaseId,
     img_url: img_url ?? this.img_url,
     nameProduct: nameProduct ?? this.nameProduct,
     quantityProduct: quantityProduct ?? this.quantityProduct,
     priceProduct: priceProduct ?? this.priceProduct,
     supplierName: supplierName ?? this.supplierName,
     phoneSupplier: phoneSupplier ?? this.phoneSupplier,
     noteProduct: noteProduct ?? this.noteProduct,
     error: error ?? this.error,
     totalPriceInCart: totalPriceInCart ?? this.totalPriceInCart,
     quantityProductViewCart : quantityProductViewCart ?? this.quantityProductViewCart,



    );
   }

   @override
   // TODO: implement props
   List<Object?> get props =>
       [
        lstModelProductLocal,
        statusSaveDataLocal,
        statusGetDataLocal,
        statusDeleteDataLocal,
        fireBaseId,
        img_url,
        nameProduct,
        quantityProduct,
        priceProduct,
        supplierName,
        phoneSupplier,
        noteProduct,
        error,
        totalPriceInCart,
        quantityProductViewCart
       ];
  }
