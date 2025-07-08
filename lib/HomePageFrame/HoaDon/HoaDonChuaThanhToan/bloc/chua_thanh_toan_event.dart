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

// xử lí nút thanh toán ở trang chưa thanh toán
class PayBillChuaThanhToan extends ChuaThanhToanEvent {
 final String billId;
 const PayBillChuaThanhToan(this.billId);

 @override
 List<Object?> get props => [billId];
}


 // cho cái nút thanh toán
 class SubmitDaThanhToanBillChange extends ChuaThanhToanEvent{
   const SubmitDaThanhToanBillChange();
 }

 // xóa bill ở trang chưa thanh toán
 final class DeleteBillChuaThanhToan extends ChuaThanhToanEvent{
 const DeleteBillChuaThanhToan(this.deleteBillChuaThanhToanId,this.index);

 // truyền thêm ID vào trang chi tiết ( index dùng để bắt độ dài list )
 final String deleteBillChuaThanhToanId;
 final int index;
 @override
 List<Object> get props => [deleteBillChuaThanhToanId,index];
 }

 // vì thanh toán hóa đơn thứ 2 không hiển thị thông báo nên phải thêm sự kiện này
 final class resetStatusNotification extends ChuaThanhToanEvent {
  const resetStatusNotification();
 }


