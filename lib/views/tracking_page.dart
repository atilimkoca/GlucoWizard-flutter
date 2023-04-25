import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:glucowizard_flutter/models/tracking_chart_model.dart';
import 'package:glucowizard_flutter/providers/language_provider.dart';
import 'package:glucowizard_flutter/providers/login_provider.dart';
import 'package:glucowizard_flutter/providers/tracking_chart_provider.dart';

import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart' hide CalendarDatePicker;
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
            child: Image.asset('assets/images/chart_page.png')
            //  Lottie.asset('assets/images/chart_.json',
            //     height: MediaQuery.of(context).size.height * 0.18),
            ),
        Padding(
          padding: const EdgeInsets.all(5),
          child: DatePicker(
            DateTime.now().subtract(Duration(days: 30)),
            controller: _controller,
            monthTextStyle: TextStyle(
                fontSize: 13,
                color: Color(0xff473169),
                fontWeight: FontWeight.w600),
            dayTextStyle: TextStyle(
                fontSize: 13,
                color: Color(0xff473169),
                fontWeight: FontWeight.w600),
            dateTextStyle: TextStyle(
                fontSize: 23,
                color: Color(0xff473169),
                fontWeight: FontWeight.w600),
            initialSelectedDate: DateTime.now(),
            daysCount: 31,
            selectionColor: const Color(0xffc7b0e8),
            selectedTextColor: Color(0xff473169),
            onDateChange: (value) {
              var formatter = DateFormat('yyyy-MM-dd');
              String formattedDate = formatter.format(value);

              //print(formattedDate);
              context
                  .read<TrackingChartProvider>()
                  .setCurrentDate(formattedDate);

              TrackingChart _chart = TrackingChart(
                date: formattedDate,
                uid: context.read<LoginPageProvider>().userId,
              );
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
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: cardTrackingChart(context, index),
              );
            },
            itemCount:
                context.watch<TrackingChartProvider>().trackingCharts.length,
          ),
        ),
      ]),
    );
  }

  Slidable cardTrackingChart(BuildContext context, int index) {
    TextEditingController popupController = TextEditingController();
    Future<void> displayTextInputDialog(BuildContext context, String hour) {
      var trackingChartProvider =
          Provider.of<TrackingChartProvider>(context, listen: false);
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              buttonPadding: EdgeInsets.only(right: 30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0))),
              title: Text(AppLocalizations.of(context)!.update_glucose),
              content: TextField(
                  controller: popupController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    labelText: AppLocalizations.of(context)!.enterGlucoseValue,
                  )),
              actions: <Widget>[
                MaterialButton(
                  color: Colors.green,
                  textColor: Colors.white,
                  child: Text(AppLocalizations.of(context)!.okay),
                  onPressed: () {
                    TrackingChart _chart = TrackingChart(
                        date: trackingChartProvider.trackingCharts[index].date,
                        uid: context.read<LoginPageProvider>().userId,
                        hour: hour,
                        glucoseLevel: popupController.text);
                    trackingChartProvider.updateTrackingChart(_chart);

                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          });
    }

    var trackingChartProvider =
        Provider.of<TrackingChartProvider>(context, listen: false);
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              displayTextInputDialog(
                  context, trackingChartProvider.trackingCharts[index].hour);
            },
            backgroundColor: const Color(0xff8e61d1),
            borderRadius: BorderRadius.circular(15.0),
            icon: Icons.edit,
          ),
          SlidableAction(
            onPressed: (context) {
              TrackingChart _chart = TrackingChart(
                  date: trackingChartProvider.trackingCharts[index].date,
                  uid: context.read<LoginPageProvider>().userId,
                  hour: trackingChartProvider.trackingCharts[index].hour);
              trackingChartProvider.deleteTrackingChart(_chart);
            },
            backgroundColor: Color(0xff473169),
            borderRadius: BorderRadius.circular(15.0),
            icon: Icons.delete,
          )
        ],
      ),
      child: Card(
          margin: EdgeInsets.all(0),
          color: int.parse(context.watch<TrackingChartProvider>().trackingCharts[index].glucoseLevel) >
                  215
              ? Color(0xffEF4B4B)
              : int.parse(context.watch<TrackingChartProvider>().trackingCharts[index].glucoseLevel) < 215 &&
                      int.parse(context.watch<TrackingChartProvider>().trackingCharts[index].glucoseLevel) >=
                          150
                  ? Color(0xffFFD966)
                  : int.parse(context.watch<TrackingChartProvider>().trackingCharts[index].glucoseLevel) < 150 &&
                          int.parse(context
                                  .watch<TrackingChartProvider>()
                                  .trackingCharts[index]
                                  .glucoseLevel) >=
                              75
                      ? Color(0xffB6E2A1)
                      : Color(0xffB0F0F6),
          // shadowColor: Colors.amber,
          // elevation: 10,
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(
                  color: int.parse(context.watch<TrackingChartProvider>().trackingCharts[index].glucoseLevel) >
                          215
                      ? Color(0xffEF4B4B)
                      : int.parse(context.watch<TrackingChartProvider>().trackingCharts[index].glucoseLevel) < 215 &&
                              int.parse(context
                                      .watch<TrackingChartProvider>()
                                      .trackingCharts[index]
                                      .glucoseLevel) >=
                                  150
                          ? Color(0xffFFD966)
                          : int.parse(context.watch<TrackingChartProvider>().trackingCharts[index].glucoseLevel) < 150 &&
                                  int.parse(context.watch<TrackingChartProvider>().trackingCharts[index].glucoseLevel) >= 75
                              ? Color(0xffB6E2A1)
                              : Color(0xffB0F0F6))),
          child: ListTile(
            selectedColor: Colors.blue,
            contentPadding: EdgeInsets.all(5),
            leading: Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    context
                        .watch<TrackingChartProvider>()
                        .trackingCharts[index]
                        .hour,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: Text(
                  context
                      .watch<TrackingChartProvider>()
                      .trackingCharts[index]
                      .glucoseLevel,
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 35.0),
              child: int.parse(context.watch<TrackingChartProvider>().trackingCharts[index].glucoseLevel) >
                      215
                  ? Text(AppLocalizations.of(context)!.tracking_hyper,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black))
                  : int.parse(context.watch<TrackingChartProvider>().trackingCharts[index].glucoseLevel) <
                              215 &&
                          int.parse(context
                                  .watch<TrackingChartProvider>()
                                  .trackingCharts[index]
                                  .glucoseLevel) >=
                              150
                      ? Text(AppLocalizations.of(context)!.tracking_hidden,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black))
                      : int.parse(context
                                      .watch<TrackingChartProvider>()
                                      .trackingCharts[index]
                                      .glucoseLevel) <
                                  150 &&
                              int.parse(context
                                      .watch<TrackingChartProvider>()
                                      .trackingCharts[index]
                                      .glucoseLevel) >=
                                  75
                          ? Text(
                              AppLocalizations.of(context)!.tracking_normal,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            )
                          : Text(
                              AppLocalizations.of(context)!.tracking_hypo,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ),
            ),
            trailing: Icon(
              LineIcons.angleLeft,
              color: Colors.black,
              weight: 30,
            ),
          )),
    );
  }
}
