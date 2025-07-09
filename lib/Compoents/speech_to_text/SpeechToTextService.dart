
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';



class SpeechToTextService {
  SpeechToText _speechToText = SpeechToText();

  bool get isListening => _speechToText.isListening;

  /// Xin quyền micro trước khi khởi tạo
  Future<bool> initSpeech() async {
    final status = await Permission.microphone.request();

    if (!status.isGranted) {
      print("❌ Microphone permission denied");
      return false;
    }

    // khởi tạo dịch vụ speech
    final available = await _speechToText.initialize(
      onStatus: (status) => print("🎤 [Speech status] $status"),
      onError: (error) => print("❌ [Speech error] $error"),
    );

    print("✅ Speech available: $available");
    return available;
  }

  /// Bắt đầu nghe và trả kết quả qua callback
  Future<void> startListening({required Function(String) onResult}) async {
    await _speechToText.listen(
      onResult: (SpeechRecognitionResult result) {
        onResult(result.recognizedWords);
        print("🎤 Nhận được voice: $result"); // <-- kiểm tra có ra không
      },
    );

  }

  /// Dừng nghe
  void stopListening() {
    _speechToText.stop();
  }

}