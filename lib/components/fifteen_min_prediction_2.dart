import 'package:cool_alert/cool_alert.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import '../providers/prediction_provider.dart';
import '../services/prediction2_service.dart';
import '../services/prediction_service.dart';

class FifteenMinPredictionTwo extends StatelessWidget {
  const FifteenMinPredictionTwo({
    super.key,
    required this.predictionController1,
  });
  final TextEditingController predictionController1;

  static final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
    PredictionTwoModel predictionModel = PredictionTwoModel();
    var selectedText = context.watch<PredictionProvider>().selectedText ?? '';
    //String? selectedText = predictionProvider.selectedText ?? '15 Dakika';

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
                  .load15Model(predictionController1.text)
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
                              ? Color.fromARGB(255, 150, 228, 235)
                              : value <= 180 && value > 70
                                  ? Colors.green
                                  : value > 180
                                      ? Colors.red
                                      : Colors.red,
                          fontSize: 30,
                          fontWeight: FontWeight.bold)));
            },
            child: Text(
              AppLocalizations.of(context)!.prediction,
            )),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.38,
          child: StackedCardCarousel(
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
                          child: Image.asset("assets/images/now.png"),
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
