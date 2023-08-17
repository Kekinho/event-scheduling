import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wticifesapp/services/speaker_service.dart';
import 'package:wticifesapp/model/speaker.dart';

class SpeakersFirebaseService implements SpeakerService {
  @override
  Stream<List<Speaker>> speakerStream() {
    final store = FirebaseFirestore.instance;
    final snapshots = store
        .collection('speakers')
        .withConverter(
      fromFirestore: _fromFirestore,
      toFirestore: _toFirestore,
    )
        .orderBy('name', descending: false)
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        return doc.data();
      }).toList();
    });
  }


  @override
  Stream<List<Speaker>> speakerStreamSearch(String name) {
    final store = FirebaseFirestore.instance;

    final snapshots = store
        .collection('speakers')
        .withConverter(
      fromFirestore: _fromFirestore,
      toFirestore: _toFirestore,
    )
        .orderBy('name')
        .snapshots();

    return snapshots.map((snapshot) {
      return snapshot.docs.map((doc) {
        //print(doc.data().nome); aqui consulta no SQLite
        return doc.data();
      })
          .where((element) => element.name.contains(name.toUpperCase()))
          .toList(); // qualquer elemento que contenha as letras digitadas
    });
  }

  @override
  Future<Speaker?> save(int id, String name, String charge, String topic, String description, String photo) async {
    final store = FirebaseFirestore.instance;

    final msg = Speaker(
      id: id,
      name: name,
      charge: charge,
      topic: topic,
      description: description,
      photo: photo,
    );

    final docRef = await store
        .collection('speakers')
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
      'name': msg.name,
      'charge': msg.charge,
      'topic': msg.topic,
      'description': msg.description,
      'photo': msg.photo,
    };
  }

  Speaker _fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc,
      SnapshotOptions? options,) {
    return Speaker(
      id: doc["id"],
      name: doc["name"],
      charge: doc["charge"],
      topic: doc["topic"],
      description: doc["description"],
      photo: doc["photo"],

    );
  }
}
