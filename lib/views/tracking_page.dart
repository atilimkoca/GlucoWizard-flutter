import 'dart:io';

import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:glucowizard_flutter/models/tracking_chart_model.dart';
import 'package:glucowizard_flutter/providers/language_provider.dart';
import 'package:glucowizard_flutter/providers/login_provider.dart';
import 'package:glucowizard_flutter/providers/tracking_chart_provider.dart';

import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

import 'package:flutter/material.dart' hide CalendarDatePicker;
import 'package:provider/provider.dart';

class TrackingPage extends StatelessWidget {
  final DatePickerController _controller = DatePickerController();
  TrackingPage({super.key});
  void executeAfterBuild() {
    _controller.animateToSelection();
  }

  @override
  Widget build(BuildContext context) {
    //

    var date = DateTime.now();
    var initialDatee = DateTime(date.year, date.month, date.day);
    var now = DateTime.now();

    DateTime endDate = now.add(Duration(days: 7));

    DateTime startDate = now.subtract(Duration(days: 14));

    var now1 = DateTime.now();
    var formatter = new DateFormat('hh:mm:ss', 'tr_TR');
    String formattedDate2 = formatter.format(now);
    var getLocale = Provider.of<LanguageProvider>(context, listen: false);
    var locale = getLocale.locale ?? Locale(Platform.localeName.split('_')[0]);
    var stringLocale = locale.toString();
    //_controller.jumpToSelection();
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
              _controller.animateToDate(date);
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
            DateTime.now().subtract(Duration(days: 30)),
            // activeDates: List.generate(
            //     30,
            //     (index) => (DateTime.now().subtract(Duration(days: 30)))
            //         .add(Duration(days: index))),
            controller: _controller,
            initialSelectedDate: DateTime.now(),
            daysCount: 31,
            selectionColor: Colors.black,
            selectedTextColor: Colors.white,
            onDateChange: (value) {
              var formatter = DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(value);
              //print(formattedDate);
              TrackingChart _chart = TrackingChart(
                  date: formattedDate,
                  uid: context.read<LoginPageProvider>().userId,
                  hour: formattedDate2);
              context.read<TrackingChartProvider>().getTrackingChart(_chart);
            },
            locale: stringLocale,
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(5),
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return Card(
                  color: Colors.blue.shade100,
                  shadowColor: Colors.amber,
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: ListTile(
                    leading: Text(context
                        .watch<TrackingChartProvider>()
                        .trackingCharts[index]
                        .hour),
                    title: Text(context
                        .watch<TrackingChartProvider>()
                        .trackingCharts[index]
                        .glucoseLevel),
                    subtitle: Text('test'),
                    trailing: Icon(Icons.abc),
                  ));
              ;
            },
            itemCount:
                context.watch<TrackingChartProvider>().trackingCharts.length,
          ),
        ),
      ]),
    );
  }
}
