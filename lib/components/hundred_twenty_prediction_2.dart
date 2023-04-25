import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';

import '../providers/prediction_provider.dart';
import '../services/prediction2_service.dart';
import '../services/prediction_service.dart';

class HundredTwentyPredictionTwo extends StatelessWidget {
  const HundredTwentyPredictionTwo({
    super.key,
    required this.predictionController1,
    required this.predictionController2,
    required this.predictionController3,
    required this.predictionController4,
    required this.predictionController5,
    required this.predictionController6,
    required this.predictionController7,
    required this.predictionController8,
  });
  final TextEditingController predictionController1;
  final TextEditingController predictionController2;
  final TextEditingController predictionController3;
  final TextEditingController predictionController4;
  final TextEditingController predictionController5;
  final TextEditingController predictionController6;
  final TextEditingController predictionController7;
  final TextEditingController predictionController8;

  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    PredictionTwoModel predictionModel = PredictionTwoModel();

    return Column(
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
              shadowColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: const Color(0xffB7A1E0),
            ),
            onPressed: () {
              bool _validate = _formKey.currentState!.validate();
              if (_validate) {
                predictionModel
                    .load120Model(
                      predictionController1.text,
                      predictionController2.text,
                      predictionController3.text,
                      predictionController4.text,
                      predictionController5.text,
                      predictionController6.text,
                      predictionController7.text,
                      predictionController8.text,
                    )
                    .then((value) => CoolAlert.show(
                        context: context,
                        confirmBtnColor: Color.fromARGB(255, 142, 97, 209),
                        confirmBtnText: AppLocalizations.of(context)!.okay,
                        backgroundColor: Color.fromARGB(255, 213, 196, 238),
                        type: CoolAlertType.success,
                        loopAnimation: true,
                        lottieAsset: value <= 70
                            ? 'assets/images/hypo_prediction.json'
                            : value <= 180 && value > 70
                                ? 'assets/images/heart.json'
                                : value > 180
                                    ? 'assets/images/hyper_prediction.json'
                                    : 'assets/images/hyper_prediction.json',
                        title: value <= 70
                            ? '${AppLocalizations.of(context)!.thirty_min_later} ${AppLocalizations.of(context)!.risk_hypo}'
                            : value <= 180 && value > 70
                                ? '${AppLocalizations.of(context)!.thirty_min_later} ${AppLocalizations.of(context)!.normal_value}'
                                : value > 180
                                    ? '${AppLocalizations.of(context)!.thirty_min_later} ${AppLocalizations.of(context)!.risk_hyper}'
                                    : '${AppLocalizations.of(context)!.thirty_min_later} ${AppLocalizations.of(context)!.risk_hyper}',
                        text: value.toStringAsFixed(2),
                        textTextStyle: TextStyle(
                            color: value <= 70
                                ? Color.fromARGB(255, 160, 228, 235)
                                : value <= 180 && value > 70
                                    ? Colors.green
                                    : value > 180
                                        ? Colors.red
                                        : Colors.red,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)));
              }
            },
            child: Text(
              AppLocalizations.of(context)!.prediction,
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.41,
          child: Form(
            key: _formKey,
            child: StackedCardCarousel(
              initialOffset: 6,
              type: StackedCardCarouselType.fadeOutStack,
              onPageChanged: (pageIndex) {},
              spaceBetweenItems: 200,
              items: [
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: const Color(0xffFFEFEF),
                  elevation: 30.0,
                  shadowColor: const Color(0xffFFEFEF),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child:
                                Image.asset("assets/images/hundred_five.png"),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
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
                                  RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                                  text: newValue.text.replaceAll(',', '.'),
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
                  color: const Color(0xffFFEFEF),
                  elevation: 30.0,
                  shadowColor: const Color(0xffFFEFEF),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Image.asset("assets/images/ninety.png"),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
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
                                  RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                                  text: newValue.text.replaceAll(',', '.'),
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
                  color: const Color(0xffFFEFEF),
                  elevation: 30.0,
                  shadowColor: const Color(0xffFFEFEF),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child:
                                Image.asset("assets/images/seventy_five.png"),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
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
                                  RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                                  text: newValue.text.replaceAll(',', '.'),
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
                  color: const Color(0xffFFEFEF),
                  elevation: 30.0,
                  shadowColor: const Color(0xffFFEFEF),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Image.asset("assets/images/sixty.png"),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
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
                                  RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                                  text: newValue.text.replaceAll(',', '.'),
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
                  color: const Color(0xffFFEFEF),
                  elevation: 30.0,
                  shadowColor: const Color(0xffFFEFEF),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Image.asset("assets/images/fourty_five.png"),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
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
                                  RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                                  text: newValue.text.replaceAll(',', '.'),
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
                  color: const Color(0xffFFEFEF),
                  elevation: 30.0,
                  shadowColor: const Color(0xffFFEFEF),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Image.asset("assets/images/thirty.png"),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
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
                                  RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                                  text: newValue.text.replaceAll(',', '.'),
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
                Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: const Color(0xffFFEFEF),
                  elevation: 30.0,
                  shadowColor: const Color(0xffFFEFEF),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Image.asset("assets/images/fifteen.png"),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
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
                                  RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                                  text: newValue.text.replaceAll(',', '.'),
                                ),
                              ),
                            ],
                            controller: predictionController7,
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
                  color: const Color(0xffFFEFEF),
                  elevation: 30.0,
                  shadowColor: const Color(0xffFFEFEF),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          width: 60,
                          height: 60,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Image.asset("assets/images/present.png"),
                          ),
                        ),
                        SizedBox(
                          width: 200,
                          child: TextFormField(
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
                                  RegExp(r'[0-9]+[.]{0,1}[0-9]*')),
                              TextInputFormatter.withFunction(
                                (oldValue, newValue) => newValue.copyWith(
                                  text: newValue.text.replaceAll(',', '.'),
                                ),
                              ),
                            ],
                            controller: predictionController8,
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
