import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';

class AlarmPage extends StatefulWidget {
  const AlarmPage({Key? key}) : super(key: key);

  @override
  _AlarmPageState createState() => _AlarmPageState();
}

class _AlarmPageState extends State<AlarmPage> {
  final _formKey = GlobalKey<FormState>();
  TimeOfDay _time = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: GestureDetector(
              onTap: () async {
                final TimeOfDay? time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (time != null) {
                  setState(() {
                    _time = time;
                  });
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Select time:'),
                  Text('${_time.hour}:${_time.minute}'),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  _scheduleAlarm();
                }
              },
              child: const Text('Set Alarm'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _scheduleAlarm() async {
    final now = DateTime.now();
    final alarmTime =
        DateTime(now.year, now.month, now.day, _time.hour, _time.minute);

    await AndroidAlarmManager.oneShotAt(alarmTime, 0, _onAlarm);
  }
}

void _onAlarm() async {
  //final ringtoneUri = await getRingtoneUri();
  print('alarm');
  FlutterRingtonePlayer.play(
    android: AndroidSounds.notification,
    ios: IosSounds.glass,
    looping: true,
    volume: 50.0,
    fromAsset: 'assets/alarm.wav',
  );
}

// Future<String> getRingtoneUri() async {
//   final ringtoneUri = await RingtonePicker.picker();
//   return ringtoneUri;
// }
