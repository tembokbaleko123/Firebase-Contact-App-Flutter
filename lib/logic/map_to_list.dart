import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = FirebaseFirestore.instance;

class MapToList {
  List<DocumentReference<Map<String, dynamic>>> kontakList = [];

  void tambahKontak(String name, dynamic nomer) async {
    // DocumentReference<Map<String, dynamic>> kontakTambah =
    await _firestore.collection('kontak').add({
      'Nama': name,
      'No_telp': nomer,
    });
  }

  void hapusKontak(String id) async {
    await _firestore.collection('kontak').doc(id).delete();
  }

  void upgradeKontak(String id, String name, dynamic nomer) async {
    await _firestore.collection('kontak').doc(id).update({
      'Nama' : name,
      'No_telp' : nomer
    });
  }
}
