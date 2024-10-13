import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kontak_with_firebase/logic/map_to_list.dart';
import 'package:kontak_with_firebase/ui/screen2tambah.dart';
import 'package:kontak_with_firebase/ui/screen2upgrade.dart';
import 'package:kontak_with_firebase/ux/list_nomer_screen1.dart';

class Kontak extends StatefulWidget {
  const Kontak({super.key});

  @override
  State<Kontak> createState() => _KontakState();
}

class _KontakState extends State<Kontak> {
  final MapToList _mapToList = MapToList();

  final _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => TambahKontak(
                          mapToList: _mapToList,
                        )));
            setState(
                () {}); //setState disini untuk menampilkan input yang diambil dari screen2 Navigator.pop
          },
          backgroundColor: Colors.blue,
          child: const Icon(Icons.add_ic_call_outlined),
        ),
        appBar: AppBar(
          title: const Text('Kontak'),
        ),
        body: StreamBuilder(
            stream: _firestore.collection('kontak').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot documentSnapshot =
                        snapshot.data!.docs[index];
                    return Kartu(
                      nama: documentSnapshot['Nama'],
                      noTelp: documentSnapshot['No_telp'],
                      tekanTengah: () async {
                        bool? result = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => UpgradeKontak(
                              mapToList: _mapToList,
                              id: documentSnapshot.id,
                              initialNama: documentSnapshot['Nama'],
                              initialNomer: documentSnapshot['No_telp'],
                            ),
                          ),
                        );

                        if (result == true) {
                          setState(() {
                            // Memuat ulang UI setelah update
                            print(index);
                          });
                        }
                      },
                      tekan: () {
                        setState(() {
                          //setState disini agar ui-nya bisa terhapus
                          _mapToList.hapusKontak(documentSnapshot.id);
                          print(index);
                        });
                      },
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }
            // child: ListView.builder(
            //     itemCount: _mapToList.getKontakList().length,
            //     itemBuilder: (context, index) {
            //       final kontak = _mapToList.getKontakList()[index];
            //       return Kartu(
            //         nama: kontak['Nama'],
            //         noTelp: kontak['No_telp'],
            //         tekan: () {
            //           setState(() {
            //             //setState disini agar ui-nya bisa terhapus
            //             _mapToList.hapusKontak(index);
            //             print(index);
            //           });
            //         },
            //       );
            //     }),
            ));
  }
}
