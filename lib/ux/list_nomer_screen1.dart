import 'package:flutter/material.dart';

class Kartu extends StatelessWidget {
  const Kartu(
      {super.key, 
        required this.nama, 
        required this.noTelp,
        this.tekan, 
        this.tekanTengah,});

  final VoidCallback? tekanTengah;
  final String nama;
  final String noTelp;
  final VoidCallback? tekan;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: tekanTengah,
        title: Text(nama),
        subtitle: Text(noTelp),
        trailing: IconButton(
          onPressed: tekan,
          icon: const Icon(Icons.delete),
        ),
      ),
    );
  }
}
