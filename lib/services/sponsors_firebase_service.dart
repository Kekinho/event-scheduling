import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wticifesapp/model/event_schedule.dart';
import 'package:wticifesapp/services/sponsors_service.dart';

class SponsorsFirebaseService implements SponsorsService {
  @override
  Stream<List<Speaker>> sponsorsStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('schedule')
        .withConverter(
      fromFirestore: _fromFirestore,
      toFirestore: _toFirestore,
    )
        .orderBy('hour', descending: false)
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }


  @override
  Stream<List<Speaker>> sponsorsStreamSearch(String place) {
    final store = FirebaseFirestore.instance;

    final snapshots = store
        .collection('schedule')
        .withConverter(
      fromFirestore: _fromFirestore,
      toFirestore: _toFirestore,
    )
        .orderBy('hour')
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        //print(doc.data().nome); aqui consulta no SQLite
        return doc.data();
      })
          .where((element) => element.place.contains(place.toLowerCase()))
          .toList(); // qualquer elemento que contenha as letras digitadas
    });
  }

  @override
  Future<Speaker?> save(int id, String day, String hour, String place,
      String desc, String detail, String sponsorName) async {
    final store = FirebaseFirestore.instance;

    final msg = Speaker(
      id: id,
      day: day,
      hour: hour,
      place: place,
      description: desc,
      detail: detail,
      sponsorName: sponsorName,
    );

    final docRef = await store
        .collection('schedule')
        .withConverter(
      fromFirestore: _fromFirestore,
      toFirestore: _toFirestore,
    )
        .add(msg);

    final doc = await docRef.get();
    return doc.data()!;
  }

  Map<String, dynamic> _toFirestore(Speaker msg,
      SetOptions? options,) {
    return {
      'id': msg.id,
      'day': msg.day,
      'hour': msg.hour,
      'place': msg.place,
      'description': msg.description,
      'detail': msg.detail,
    };
  }

  Speaker _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc,
      SnapshotOptions? options,) {
    return Speaker(
      id: doc["id"],
      day: doc["day"],
      hour: doc["hour"],
      place: doc["place"],
      description: doc["description"],
      detail: doc["detail"],
      sponsorName: doc["sponsorName"]
    );
  }
}
