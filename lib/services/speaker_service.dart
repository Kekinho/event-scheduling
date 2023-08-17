import 'package:wticifesapp/model/speaker.dart';
import 'speaker_firebase_service.dart';


abstract class SpeakerService {
  Stream<List<Speaker>> speakerStream();
  Stream<List<Speaker>> speakerStreamSearch(String day);
  Future<Speaker?> save(int id, String name, String charge, String topic, String description, String photo);

  factory SpeakerService() {
    return SpeakersFirebaseService();
  }
}