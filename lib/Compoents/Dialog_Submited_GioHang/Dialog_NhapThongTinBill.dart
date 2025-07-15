import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DialogNhapThongTinBill extends StatefulWidget {
  final Function({
  required String nameBill,
  required String nameSeller,
  required String nameBuyer,
  required String date,
  required String note,
  required String createdTime,
  }) onConfirm;

  const DialogNhapThongTinBill({super.key, required this.onConfirm});

  @override
  State<DialogNhapThongTinBill> createState() => _DialogNhapThongTinBillState();
}

class _DialogNhapThongTinBillState extends State<DialogNhapThongTinBill> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameBillController = TextEditingController();
  final TextEditingController _sellerController = TextEditingController();
  final TextEditingController _buyerController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  // chọn ngày
  Future<void> _selectDate(BuildContext context) async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 5),
      lastDate: DateTime(now.year + 5),
    );
    if (picked != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(picked);
      _dateController.text = formattedDate;
    }
  }

  @override
  void dispose() {
    _nameBillController.dispose();
    _sellerController.dispose();
    _buyerController.dispose();
    _noteController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:  Text(
        "Nhập Thông Tin Hóa Đơn",
        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14.sp),
      ),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [TextFormField(
              controller: _nameBillController,
              decoration:  InputDecoration(
                labelText: "Tên hóa đơn",
                labelStyle: TextStyle(fontSize: 14.sp),
                border: OutlineInputBorder(),
              ),
              validator: (value) => value == null || value.isEmpty ? "Nhập tên hóa đơn" : null,
            ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _sellerController,
                decoration:  InputDecoration(
                  labelText: "Người Bán",
                  labelStyle: TextStyle(fontSize: 14.sp),
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? "Nhập tên người bán" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _buyerController,
                decoration:  InputDecoration(
                  labelText: "Người Mua",
                  labelStyle: TextStyle(fontSize: 14.sp),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Nhập tên người mua" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText: "Ngày Mua",
                  labelStyle: TextStyle(fontSize: 14.sp),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                validator: (value) =>
                value == null || value.isEmpty ? "Chọn ngày mua" : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _noteController,
                decoration:  InputDecoration(
                  labelText: "Ghi chú (không bắt buộc)",
                  labelStyle: TextStyle(fontSize: 12.sp),
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          child: const Text("Hủy",style: TextStyle(color: Colors.red),),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              final now = DateTime.now();
              final String createdTime = DateFormat("HH:mm:ss").format(now);

              widget.onConfirm(
                nameBill: _nameBillController.text.trim(),
                nameSeller: _sellerController.text.trim(),
                nameBuyer: _buyerController.text.trim(),
                date: _dateController.text.trim(),
                note: _noteController.text.trim(),
                createdTime: createdTime,
              );

              Navigator.of(context).pop(); // đóng dialog
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
          ),
          child: const Text("Thanh Toán", style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}