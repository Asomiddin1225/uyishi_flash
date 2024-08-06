// import 'package:flashlight_app/screens/flash_screen.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: FlashScreen(),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlashlightPage(),
    );
  }
}

class FlashlightPage extends StatefulWidget {
  @override
  _FlashlightPageState createState() => _FlashlightPageState();
}

class _FlashlightPageState extends State<FlashlightPage> {
  static const platform = MethodChannel('flashlight');
  bool _isOn = false;

  Future<void> _toggleFlashlight() async {
    try {
      await platform.invokeMethod('toggleFlashlight', {'isOn': !_isOn});
      setState(() {
        _isOn = !_isOn;
      });
    } on PlatformException catch (e) {
      print("Failed to toggle flashlight: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Flash dasturi",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.amber[300],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _isOn ? Icons.flashlight_on : Icons.flashlight_off_sharp,
              size: 50,
            ),
            TextButton(
                onPressed: _toggleFlashlight,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.amber[200]),
                  child: Center(
                    child: Text(
                      _isOn ? 'Off' : 'On',
                      style: TextStyle(color: Colors.amber, fontSize: 30),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
