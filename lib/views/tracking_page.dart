import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:glucowizard_flutter/providers/login_provider.dart';
import 'package:glucowizard_flutter/providers/tracking_chart_provider.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart' hide CalendarDatePicker;
import 'package:provider/provider.dart';

class TrackingPage extends StatelessWidget {
  TrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    //

    var date = DateTime.now();
    var initialDatee = DateTime(date.year, date.month - 2, date.day);
    var now = DateTime.now();
    DateTime startDate = now.subtract(Duration(days: 14));
    DateTime endDate = now.add(Duration(days: 7));
    print('startDate = $startDate ; endDate = $endDate');
    var now1 = DateTime.now();
    var formatter = new DateFormat('hh:mm:ss', 'tr_TR');
    String formattedDate = formatter.format(now);
    print(formattedDate); // 2018-08-16 12:00:00.000Z
    return Center(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Lottie.asset('assets/images/tracking_chart.json',
              height: MediaQuery.of(context).size.height * 0.18),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: ElevatedButton(
            onPressed: () {
              var provider =
                  Provider.of<LoginPageProvider>(context, listen: false);
              print(provider.userId);
              print('***********************');
            },
            child: Text('Show Date Picker'),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: DatePicker(
            initialDatee,
            initialSelectedDate: DateTime.now(),
            selectionColor: Colors.black,
            selectedTextColor: Colors.white,
            onDateChange: (value) {
              var formatter = DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(value);
              print(formattedDate);
              context.read<TrackingChartProvider>().getTrackingChart(
                  context.read<LoginPageProvider>().userId!, formattedDate);
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(5),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return trackingList(formattedDate);
            },
            itemCount: 10,
          ),
        ),
      ]),
    );
  }

  Card trackingList(String formattedDate) {
    return Card(
        color: Colors.blue.shade100,
        shadowColor: Colors.amber,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: ListTile(
          leading: Text(formattedDate.toString()),
          title: Text('test'),
          subtitle: Text('test'),
          trailing: Icon(Icons.abc),
        ));
  }
}
