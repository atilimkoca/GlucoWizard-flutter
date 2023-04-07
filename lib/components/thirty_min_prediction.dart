import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

import '../providers/prediction_provider.dart';
import '../services/prediction_service.dart';

class ThirtyMinPrediction extends StatelessWidget {
  ThirtyMinPrediction(
      {super.key,
      required this.predictionController1,
      required this.predictionController2,
      required this.predictionController3,
      required this.predictionController4,
      required this.predictionController5,
      required this.predictionController6});

  final TextEditingController predictionController1;
  final TextEditingController predictionController2;
  final TextEditingController predictionController3;
  final TextEditingController predictionController4;
  final TextEditingController predictionController5;
  final TextEditingController predictionController6;
  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    PredictionModel predictionModel = PredictionModel();
    String? selectedValue = context.watch<PredictionProvider>().selectedValue;
    final List<String> items = [
      AppLocalizations.of(context)!.fiveMin,
      AppLocalizations.of(context)!.thirtyMin,
      AppLocalizations.of(context)!.fourtyMin,
      AppLocalizations.of(context)!.sixtyMin,
      AppLocalizations.of(context)!.ninetyMin,
      AppLocalizations.of(context)!.houndredMin,
      // "15",
      // "30",
      // "45",
      // "60",
      // "90",
      // "120",
    ];
    var selectedText = context.watch<PredictionProvider>().selectedText ?? '';
    //String? selectedText = predictionProvider.selectedText ?? '15 Dakika';
    String text1 = '';
    String text2 = '';
    String text3 = '';
    String text4 = '';
    String text5 = '';
    String text6 = '';

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
              bool _validate = _formKey.currentState!.validate();
              if (_validate) {
                print('hata');
                predictionModel
                    .load30Model(
                      predictionController1.text,
                      predictionController2.text,
                      predictionController3.text,
                      predictionController4.text,
                      predictionController5.text,
                      predictionController6.text,
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
                                      ? AppLocalizations.of(context)!
                                          .hidden_sugar
                                      : AppLocalizations.of(context)!
                                          .risk_hyper,
                          text: value.toStringAsFixed(2),
                        ));
              } else {
                print('hata yok');
              }
            },
            child: Text(
              AppLocalizations.of(context)!.prediction,
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.478,
          child: Form(
            key: _formKey,
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
                            child: Image.asset("assets/images/twenty-five.png"),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
                            onSaved: (value) {
                              text1 = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .enterGlucoseValue;
                              }
                              return null;
                            },

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
                              labelText: AppLocalizations.of(context)!
                                  .enterGlucoseValue,
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
                          child: TextFormField(
                            onSaved: (value) {
                              text2 = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .enterGlucoseValue;
                              }
                              return null;
                            },
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
                              labelText: AppLocalizations.of(context)!
                                  .enterGlucoseValue,
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
                          child: TextFormField(
                            onSaved: (value) {
                              text3 = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .enterGlucoseValue;
                              }
                              return null;
                            },
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
                              labelText: AppLocalizations.of(context)!
                                  .enterGlucoseValue,
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
                          child: TextFormField(
                            onSaved: (value) {
                              text4 = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .enterGlucoseValue;
                              }
                              return null;
                            },
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
                              labelText: AppLocalizations.of(context)!
                                  .enterGlucoseValue,
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
                          child: TextFormField(
                            onSaved: (value) {
                              text5 = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .enterGlucoseValue;
                              }
                              return null;
                            },
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
                              labelText: AppLocalizations.of(context)!
                                  .enterGlucoseValue,
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
                          child: TextFormField(
                            onSaved: (value) {
                              text6 = value!;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .enterGlucoseValue;
                              }
                              return null;
                            },
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
                              labelText: AppLocalizations.of(context)!
                                  .enterGlucoseValue,
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
        ),
      ],
    );
  }
}
