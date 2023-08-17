import 'package:wticifesapp/model/event_schedule.dart';
import 'package:wticifesapp/services/schedule_firebase_service.dart';

abstract class ScheduleService {
  Stream<List<Speaker>> scheduleStream();
  Stream<List<Speaker>> scheduleStreamSearch(String day);
  Future<Speaker?> save(int id, String day, String hour, String place, String desc, String detail, String sponsorName);

  factory ScheduleService() {
    return ScheduleFirebaseService();
  }
}