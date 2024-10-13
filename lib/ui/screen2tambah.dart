import 'package:flutter/material.dart';
import 'package:kontak_with_firebase/logic/map_to_list.dart';
import 'package:kontak_with_firebase/ux/text_field.dart';

class TambahKontak extends StatefulWidget {
  const TambahKontak({
    super.key, 
    required this.mapToList,
    });

  final MapToList mapToList;

  @override
  State<TambahKontak> createState() => _TambahKontakState();
}

class _TambahKontakState extends State<TambahKontak> {
  final TextEditingController _namaController =
      TextEditingController(); //taruh variabel disini agar lifecycle benar dan tidak terjadi error
  final TextEditingController _nomerControoller = TextEditingController();
  String? nama;
  String? nomer;

  //Dispose untuk menghapus sisa sisa dari textfield setelah digunakan dan ingin kembali ke layar ini
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _namaController.dispose();
    _nomerControoller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Kontak'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KotakText(
              controller: _namaController,
              kotakKata: (value) {
                nama = value;
              },
              kataKata: 'Nama',
            ),
            KotakText(
                controller: _nomerControoller,
                kataKata: 'Nomer',
                keyboard: TextInputType.phone,
                kotakKata: (value) {
                  nomer = value;
                }),
            ElevatedButton(
                onPressed: () {
                  if (_namaController.text.isNotEmpty  && _nomerControoller.text.isNotEmpty ) {
                    widget.mapToList.tambahKontak(
                      _namaController.text,
                      _nomerControoller.text,
                    );
                    Navigator.pop(context,
                        true); //tambahkan true untuk megirim data nama dan nomer ke halaman sebelumnnya
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Error'),
                            content: const Text('Nama dan Nomor Telepon harus diisi'),
                            actions: [
                              ElevatedButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                        });
                  }
                  // Navigator.pop(context);
                  // print(nama);
                  // print(nomer);
                },
                child: const Text('Tambah Nomer'))
          ],
        ),
      ),
    );
  }
}
