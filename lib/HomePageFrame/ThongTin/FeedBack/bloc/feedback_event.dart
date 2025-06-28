part of 'feedback_bloc.dart';

 class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object?> get props => [];
}


// sự kiện bấm nút
class FeedBackRequested extends FeedbackEvent{
   const FeedBackRequested();
}

// class SubmitFeedbackEvent extends FeedbackEvent {
//
//   SubmitFeedbackEvent({required this.subject, required this.body});
//
//   final String subject;
//   final String body;
// }

class FeedBack_Email extends FeedbackEvent{
  const FeedBack_Email(this.email);

   final String email;
   @override
   List<Object> get props => [email];
}

class FeedBack_ChuDe extends FeedbackEvent{
  const FeedBack_ChuDe(this.chude);

  final String chude;
  @override
  List<Object> get props => [chude];
}

class FeedBack_NoiDung extends FeedbackEvent{
  const FeedBack_NoiDung(this.noidung);

  final String noidung;
  @override
  List<Object> get props => [noidung];
}

