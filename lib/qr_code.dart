import 'package:flutter/material.dart';
import "package:qr_flutter/qr_flutter.dart";

class QrImage extends StatelessWidget {
  const QrImage(this.controller, {super.key});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        title: const Text("QR Binder"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,),
        titleSpacing: 1.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 15,
        shadowColor: Colors.orangeAccent,
        backgroundColor: const Color.fromARGB(255, 240, 128, 1),
        ),
        body: Center(
          child: QrImageView(
            data: controller.text,
            size: 280,
          ),
        ),
     );
   }
}