part of 'feedback_bloc.dart';



enum StatusFeedBack {inittial , loading, success, failure}


 class FeedbackState extends Equatable {
  const FeedbackState({
    this.statusFeedBack = StatusFeedBack.inittial,
    this.error="",
    this.message="",
    required this.email ,
    this.noidung = "",
    this.chude = "",


  });

  final String email;
  final String chude;
  final String noidung;
  final String error;
  final String message;
  final StatusFeedBack statusFeedBack;

  FeedbackState copyWith({

    String? email,
    String? chude,
    String? noidung,
    StatusFeedBack? statusFeedBack,
    String? error,
    String? message,
 }) {
    return FeedbackState(
        email: email ?? this.email,
        chude: chude ?? this.chude,
        noidung: noidung ?? this.noidung,
        statusFeedBack:  statusFeedBack ?? this.statusFeedBack,
        error: error ?? this.error,
        message: message ?? this.message

    );
}


  @override
  List<Object> get props => [email,chude,noidung,statusFeedBack,error,message];
}



