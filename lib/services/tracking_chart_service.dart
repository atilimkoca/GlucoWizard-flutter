import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class TrackingChartService {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  addTrackingChart(String uid, DateTime date, String value) async {
    var formatter2 = DateFormat('yyyy-MM-dd', 'tr_TR');
    var formatter = DateFormat('hh:mm:ss', 'tr_TR');
    formatter2.format(date);
    formatter.format(date);
    String formattedDate = formatter.format(date);
    String formattedDate2 = formatter2.format(date);
    Map<String, dynamic> _eklenecekUser = <String, dynamic>{};
    _eklenecekUser['alarms'] = 'test';
    _eklenecekUser['trackingChart'] = {
      formattedDate2: {formattedDate: value}
    };

    await _firestore
        .doc('users/$uid')
        .set(_eklenecekUser, SetOptions(merge: true));
  }

  getTrackingChart(String uid, String date) async {
    var formatter = DateFormat('hh:mm:ss', 'tr_TR');
    var formatter2 = DateFormat('yyyy-MM-dd', 'tr_TR');

    var _users =
        await _firestore.collection('users').where('trackingChart.$date').get();
    print(_users.docs[0].data()['trackingChart'][date]);
  }
}
