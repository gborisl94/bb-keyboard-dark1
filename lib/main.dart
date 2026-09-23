import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(const BBApp());

class BBApp extends StatelessWidget {
  const BBApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: const BBHome(),
      ),
    );
  }
}

class BBHome extends StatefulWidget {
  const BBHome({super.key});
  @override
  State<BBHome> createState() => _BBHomeState();
}

class _BBHomeState extends State<BBHome> {
  static const channel = MethodChannel('bb_keyboard');

  @override
  void initState() {
    super.initState();
    // Ouvre auto les paramètres après 800ms
    Future.delayed(const Duration(milliseconds: 800), () {
      openSettings();
    });
  }

  Future<void> openSettings() async {
    try { await channel.invokeMethod('openInputSettings'); } catch (_) {}
  }

  Future<void> pickKeyboard() async {
    try { await channel.invokeMethod('pickKeyboard'); } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.keyboard, size: 80, color: Colors.white),
          const SizedBox(height: 20),
          const Text("BB KEYBOARD DARK", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 40),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
            onPressed: openSettings,
            child: const Text("1. ACTIVER LE CLAVIER"),
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF0A84FF), foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15)),
            onPressed: pickKeyboard,
            child: const Text("2. LE CHOISIR PAR DÉFAUT"),
          ),
          const SizedBox(height: 30),
          const Text("Après activation, glisse sur ESPACE pour déplacer le curseur", style: TextStyle(color: Colors.grey, fontSize: 12), textAlign: TextAlign.center),
        ],
      ),
    );
  }
}