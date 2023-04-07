import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

import '../providers/prediction_provider.dart';
import '../services/prediction_service.dart';

class HundredTwentyPrediction extends StatelessWidget {
  const HundredTwentyPrediction(
      {super.key,
      required this.predictionController1,
      required this.predictionController2,
      required this.predictionController3,
      required this.predictionController4,
      required this.predictionController5,
      required this.predictionController6,
      required this.predictionController7,
      required this.predictionController8,
      required this.predictionController9,
      required this.predictionController10,
      required this.predictionController11,
      required this.predictionController12,
      required this.predictionController13,
      required this.predictionController14,
      required this.predictionController15,
      required this.predictionController16,
      required this.predictionController17,
      required this.predictionController18,
      required this.predictionController19,
      required this.predictionController20,
      required this.predictionController21,
      required this.predictionController22,
      required this.predictionController23,
      required this.predictionController24});
  final TextEditingController predictionController1;
  final TextEditingController predictionController2;
  final TextEditingController predictionController3;
  final TextEditingController predictionController4;
  final TextEditingController predictionController5;
  final TextEditingController predictionController6;
  final TextEditingController predictionController7;
  final TextEditingController predictionController8;
  final TextEditingController predictionController9;
  final TextEditingController predictionController10;
  final TextEditingController predictionController11;
  final TextEditingController predictionController12;
  final TextEditingController predictionController13;
  final TextEditingController predictionController14;
  final TextEditingController predictionController15;
  final TextEditingController predictionController16;
  final TextEditingController predictionController17;
  final TextEditingController predictionController18;
  final TextEditingController predictionController19;
  final TextEditingController predictionController20;
  final TextEditingController predictionController21;
  final TextEditingController predictionController22;
  final TextEditingController predictionController23;
  final TextEditingController predictionController24;
  @override
  Widget build(BuildContext context) {
    PredictionModel predictionModel = PredictionModel();

    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: const Color.fromARGB(255, 164, 201, 255),
            ),
            onPressed: () {
              predictionModel
                  .load90Model(
                    predictionController1.text,
                    predictionController2.text,
                    predictionController3.text,
                    predictionController4.text,
                    predictionController5.text,
                    predictionController6.text,
                    predictionController7.text,
                    predictionController8.text,
                    predictionController9.text,
                    predictionController10.text,
                    predictionController11.text,
                    predictionController12.text,
                    predictionController13.text,
                    predictionController14.text,
                    predictionController15.text,
                    predictionController16.text,
                    predictionController17.text,
                    predictionController18.text,
                  )
                  .then((value) => CoolAlert.show(
                        context: context,
                        confirmBtnText: AppLocalizations.of(context)!.okay,
                        type: value <= 70
                            ? CoolAlertType.error
                            : value > 70 && value <= 140
                                ? CoolAlertType.success
                                : value > 140 && value <= 200
                                    ? CoolAlertType.warning
                                    : CoolAlertType.error,
                        title: value <= 70
                            ? AppLocalizations.of(context)!.risk_hypo
                            : value <= 140 && value > 70
                                ? AppLocalizations.of(context)!.normal_value
                                : value <= 200 && value > 140
                                    ? AppLocalizations.of(context)!.hidden_sugar
                                    : AppLocalizations.of(context)!.risk_hyper,
                        text: value.toStringAsFixed(2),
                      ));
            },
            child: Text(
              AppLocalizations.of(context)!.prediction,
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.478,
          child: StackedCardCarousel(
            type: StackedCardCarouselType.fadeOutStack,
            onPageChanged: (pageIndex) {},
            spaceBetweenItems: 200,
            items: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/100.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController1,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/100.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController2,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/100.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],
                          controller: predictionController3,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/100.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController4,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/95.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController5,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/90.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],
                          controller: predictionController6,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/85.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController7,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/80.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController8,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/75.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],
                          controller: predictionController9,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/70.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController10,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/65.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController11,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/sixty.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],
                          controller: predictionController12,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/fifty-five.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController13,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/fifty.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController14,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/fourty-five.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],
                          controller: predictionController15,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/fourty.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController16,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/thirty-five.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController17,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/thirty.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],
                          controller: predictionController18,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/twenty-five.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController19,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/twenty.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],

                          controller: predictionController20,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/fifteen.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],
                          controller: predictionController21,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/ten.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],
                          controller: predictionController22,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/five.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],
                          controller: predictionController23,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: const Color.fromARGB(255, 242, 243, 204),
                elevation: 30.0,
                shadowColor: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Image.asset("assets/images/now.png"),
                        ),
                      ),
                      SizedBox(
                        width: 200,
                        child: TextField(
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]+[,]{0,1}[0-9]*')),
                            TextInputFormatter.withFunction(
                              (oldValue, newValue) => newValue.copyWith(
                                text: newValue.text.replaceAll('.', ','),
                              ),
                            ),
                          ],
                          controller: predictionController24,
                          //controller: predictionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            labelText:
                                AppLocalizations.of(context)!.enterGlucoseValue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
