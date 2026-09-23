import 'package:flutter/material.dart';

void main() => runApp(BBApp());

class BBApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.keyboard, size: 80, color: Colors.white),
                SizedBox(height: 20),
                Text("BB KEYBOARD DARK", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                SizedBox(height: 30),
                Text("1. Installe l'APK\n2. Va dans Paramètres > Système > Langue et saisie\n3. Active BB Dark\n4. Sélectionne-le comme clavier", textAlign: TextAlign.center),
                SizedBox(height: 40),
                ElevatedButton(
                  onPressed: (){},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.white, foregroundColor: Colors.black),
                  child: Text("Clavier installé ✅")
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}