import 'package:wticifesapp/model/event_schedule.dart';
import 'package:wticifesapp/services/sponsors_firebase_service.dart';

abstract class SponsorsService {
  Stream<List<Speaker>> sponsorsStream();
  Stream<List<Speaker>> sponsorsStreamSearch(String place);
  Future<Speaker?> save(int id, String day, String hour, String place, String desc, String detail, String sponsorName);

  factory SponsorsService() {
    return SponsorsFirebaseService();
  }
}