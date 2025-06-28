import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../Models/FeedBack/feedback_data.dart';
import '../../../../Repository/FeedBack/feedback_repository.dart';
import '../../../../Repository/Login/Model/User.dart';





part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  FeedbackBloc({required FeedBackRepository feedbackRepository, required UserAccount user})
      : _feedbackRepository = feedbackRepository,
                            // email: user.email ?? "" : để check rỗng
        super(FeedbackState(email: user.email ?? "")) {
    // đăng kí sự kiện
    on<FeedBackRequested>(_onCreateFeedBack);
    on<FeedBack_Email>(_onCreateEmailFeedBack);
    on<FeedBack_ChuDe>(_onCreateChuDeFeedBack);
    on<FeedBack_NoiDung>(_onCreateNoiDungFeedBack);

  }

  // truyền FeedbackRepository
  final FeedBackRepository _feedbackRepository;

  //=====================================================================
  // Tất cả phương thức để xử lí

  void _onCreateEmailFeedBack(FeedBack_Email event,
      Emitter<FeedbackState> emit) {
    emit(
        state.copyWith(email: event.email,)
    );
  }

  void _onCreateChuDeFeedBack(FeedBack_ChuDe event,
      Emitter<FeedbackState> emit) {
    emit(
        state.copyWith(chude: event.chude,)
    );
  }

  void _onCreateNoiDungFeedBack(FeedBack_NoiDung event,
      Emitter<FeedbackState> emit) {
    emit(
        state.copyWith(noidung: event.noidung,)
    );
  }

  // xử lí tạo 1 feedback
  Future<void> _onCreateFeedBack(FeedBackRequested event, Emitter<FeedbackState> emit) async {
    try {
      emit(
          state.copyWith(statusFeedBack: StatusFeedBack.loading)
      );
      await _feedbackRepository.createFeedBackToFirebase(feedbackData: FeedBackData(
          email: state.email,
          chude: state.chude,
          noidung: state.noidung
      ));
      if(isClosed) return;
      emit(
          state.copyWith(statusFeedBack: StatusFeedBack.success)
      );
    } catch (error) {

      if(isClosed) return;
      emit(
          state.copyWith(
              statusFeedBack: StatusFeedBack.failure,
              error: error.toString()
          )
      );
    }

  }
}
