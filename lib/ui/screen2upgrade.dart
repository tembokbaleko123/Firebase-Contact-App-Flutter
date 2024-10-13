import 'package:flutter/material.dart';
import 'package:kontak_with_firebase/logic/map_to_list.dart';
import 'package:kontak_with_firebase/ux/text_field.dart';

class UpgradeKontak extends StatefulWidget {
  const UpgradeKontak({
    super.key,
    required this.mapToList,
    required this.id,
    required this.initialNama,
    required this.initialNomer,
  });

  final MapToList mapToList;
  final String id;
  final String initialNama;
  final String initialNomer;

  @override
  State<UpgradeKontak> createState() => _UpgradeKontakState();
}

class _UpgradeKontakState extends State<UpgradeKontak> {
  late TextEditingController _namaController;
  late TextEditingController _nomerController;

  @override
  void initState() {
    super.initState();
    _namaController = TextEditingController(text: widget.initialNama);
    _nomerController = TextEditingController(text: widget.initialNomer);
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nomerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Kontak'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            KotakText(
              controller: _namaController,
              kotakKata: (value) {
                // value will be updated when the user edits the field
              },
              kataKata: 'Nama',
            ),
            KotakText(
              controller: _nomerController,
              kataKata: 'Nomer',
              keyboard: TextInputType.phone,
              kotakKata: (value) {
                // value will be updated when the user edits the field
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_namaController.text.isNotEmpty &&
                    _nomerController.text.isNotEmpty) {
                  widget.mapToList.upgradeKontak(
                    widget.id,
                    _namaController.text,
                    _nomerController.text,
                  );
                  Navigator.pop(context, true); // kirim true setelah update
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
                    },
                  );
                }
              },
              child: const Text('Update Nomer'),
            ),
          ],
        ),
      ),
    );
  }
}
