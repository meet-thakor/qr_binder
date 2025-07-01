import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_binder/qr_page.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannedResultScreen extends StatelessWidget {
  final String scannedText;

  const ScannedResultScreen({super.key, required this.scannedText});

  bool _isURL(String text) {
    final Uri? uri = Uri.tryParse(text);
    return uri != null &&
        (uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https'));
  }

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(ClipboardData(text: scannedText));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Copied to clipboard')),
    );
  }

  void _openURL(BuildContext context) async {
    final Uri url = Uri.parse(scannedText);
    if (await canLaunchUrl(url)) {
      await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the URL')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isUrl = _isURL(scannedText);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Scanned Text"),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 30,
        ),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
              ),
              child: Text(
                scannedText,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(
                  onPressed: () => _copyToClipboard(context),
                  icon: const Icon(Icons.copy),
                  label: const Text('Copy'),
                ),
                const SizedBox(width: 16),
                if (isUrl)
                  ElevatedButton.icon(
                    onPressed: () => _openURL(context),
                    icon: const Icon(Icons.open_in_browser),
                    label: const Text('Open Link'),
                  ),
              ],
            ),
            const SizedBox(height: 32),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [

              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const GenerateQRCode()),
                    (Route<dynamic> route) =>
                        false, // removes all previous routes
                  );
                },
                icon: const Icon(Icons.home),
                label: const Text('Generate QR Code'),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
