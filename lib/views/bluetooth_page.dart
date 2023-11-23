import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:permission_handler/permission_handler.dart';

class BluetoothConnectionPage extends StatefulWidget {
  @override
  _BluetoothConnectionPageState createState() =>
      _BluetoothConnectionPageState();
}

class _BluetoothConnectionPageState extends State<BluetoothConnectionPage> {
  final FlutterBlue flutterBlue = FlutterBlue.instance;
  List<BluetoothDevice> devices = [];
  BluetoothDevice? connectedDevice;

  @override
  void initState() {
    super.initState();

    // Start scanning for Bluetooth devices.
    //requestBluetoothScanPermission();
    bool _isScanning = false;

    void scan() {
      if (_isScanning) {
        // Another scan is already in progress.
        return;
      }

      _isScanning = true;

      flutterBlue.scan().listen((scanResult) {
        setState(() {
          devices.add(scanResult.device);
        });
      }).onDone(() {
        _isScanning = false;
      });
    }

    scan();
  }

  // Future<void> requestBluetoothScanPermission() async {
  //   var status = await Permission.bluetoothScan.request();
  //   if (status != PermissionStatus.granted) {
  //     // The user denied the permission.
  //     // You can show a snackbar or dialog to explain why the permission is needed and ask the user to grant it again.
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth Connection'),
      ),
      body: ListView.builder(
        itemCount: devices.length,
        itemBuilder: (context, index) {
          final device = devices[index];
          return ListTile(
            title: Text(device.name),
            subtitle: Text(device.id.toString()),
            onTap: () async {
              // Connect to the selected device.
              await device.connect();

              // Save the connected device.
              connectedDevice = device;

              // Navigate to the next page.
              Navigator.pushNamed(context, '/bluetooth_connected');
            },
          );
        },
      ),
    );
  }
}
