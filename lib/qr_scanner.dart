import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'scanned_result_screen.dart';

class QRScannerScreen extends StatefulWidget {
  const QRScannerScreen({super.key});

  @override
  State<QRScannerScreen> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerScreen> {
  final MobileScannerController _controller = MobileScannerController();
  bool _isProcessing = false;

  @override
  void dispose() {
    _controller.dispose(); // ✅ Dispose the controller to release resources
    super.dispose();
  }

  void _onDetect(BarcodeCapture capture) async {
    if (_isProcessing) return;

    final List<Barcode> barcodes = capture.barcodes;
    final String? code = barcodes.firstOrNull?.rawValue;

    if (code != null) {
      _isProcessing = true;

      await _controller.stop(); // ✅ Stop the camera to prevent buffer errors

      // Navigate to result screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScannedResultScreen(scannedText: code),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
        centerTitle: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25)),
        ),
        elevation: 15,
        backgroundColor: Colors.greenAccent[400],
      ),
      body: MobileScanner(
        controller: _controller, // ✅ Attach controller
        onDetect: _onDetect,
      ),
    );
  }
}
