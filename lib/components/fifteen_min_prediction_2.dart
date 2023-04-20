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
