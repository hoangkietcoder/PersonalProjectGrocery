part of 'chua_thanh_toan_bloc.dart';

 class ChuaThanhToanEvent extends Equatable {
  const ChuaThanhToanEvent();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}


// cho chức năng tạo hóa đơn
final class CreateBillChange extends ChuaThanhToanEvent{
 const CreateBillChange();
}


// cho chức năng search
final class SearchBillChuaThanhToanEventChange extends ChuaThanhToanEvent {
 const SearchBillChuaThanhToanEventChange(this.query);

 final String query;

 @override
 List<Object?> get props => [query];
}
 // cho cái nút thanh toán
 class DaThanhToanBillChange extends ChuaThanhToanEvent{
   const DaThanhToanBillChange();
 }

 // xóa bill chưa thanh toán
final class DeleteBillChuaThanhToan extends ChuaThanhToanEvent{
 const DeleteBillChuaThanhToan(this.deleteBillChuaThanhToanId, this.index);

 // truyền thêm ID vào trang chi tiết ( index dùng để bắt độ dài list )
 final String deleteBillChuaThanhToanId;
 final int index;
 @override
 List<Object> get props => [deleteBillChuaThanhToanId,index];

}


