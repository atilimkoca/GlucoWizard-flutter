import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:glucowizard_flutter/components/fifteen_min_prediction.dart';
import 'package:glucowizard_flutter/components/fourty_five_min_prediction.dart';
import 'package:glucowizard_flutter/components/hundred_twenty_prediction.dart';
import 'package:glucowizard_flutter/components/sixty_min_prediction_2.dart';
import 'package:glucowizard_flutter/components/sixty_prediction.dart';
import 'package:glucowizard_flutter/components/thirty_min_prediction.dart';
import 'package:glucowizard_flutter/components/thirty_min_prediction_2.dart';

import 'package:glucowizard_flutter/providers/prediction_provider.dart';
import 'package:glucowizard_flutter/services/prediction_service.dart';
import 'package:provider/provider.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../services/prediction2_service.dart';
import 'fifteen_min_prediction_2.dart';
import 'fourty_five_min_prediction_2.dart';
import 'hundred_twenty_prediction_2.dart';
import 'ninety_min_prediction.dart';
import 'ninety_min_prediction_2.dart';

class PredictionTextFieldsTwo extends StatelessWidget {
  PredictionTextFieldsTwo({super.key, required this.title});
  final String title;

  final predictionController15_1 = TextEditingController();

  final predictionController30_1 = TextEditingController();
  final predictionController30_2 = TextEditingController();

  final predictionController60_1 = TextEditingController();
  final predictionController60_2 = TextEditingController();
  final predictionController60_3 = TextEditingController();
  final predictionController60_4 = TextEditingController();

  final predictionController45_1 = TextEditingController();
  final predictionController45_2 = TextEditingController();
  final predictionController45_3 = TextEditingController();

  final predictionController90_1 = TextEditingController();
  final predictionController90_2 = TextEditingController();
  final predictionController90_3 = TextEditingController();
  final predictionController90_4 = TextEditingController();
  final predictionController90_5 = TextEditingController();
  final predictionController90_6 = TextEditingController();

  final predictionController120_1 = TextEditingController();
  final predictionController120_2 = TextEditingController();
  final predictionController120_3 = TextEditingController();
  final predictionController120_4 = TextEditingController();
  final predictionController120_5 = TextEditingController();
  final predictionController120_6 = TextEditingController();
  final predictionController120_7 = TextEditingController();
  final predictionController120_8 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    PredictionTwoModel predictionModel = PredictionTwoModel();
    String? selectedValue = context.watch<PredictionProvider>().selectedValue;
    final List<String> items = [
      //AppLocalizations.of(context)!.fiveMin,
      AppLocalizations.of(context)!.thirtyMin,
      AppLocalizations.of(context)!.fourtyMin,
      AppLocalizations.of(context)!.sixtyMin,
      AppLocalizations.of(context)!.ninetyMin,
      AppLocalizations.of(context)!.houndredMin,
    ];

    var selectedText = context.watch<PredictionProvider>().selectedText ?? '';

    return Column(
      children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset("assets/images/prediction.png",
                  height: MediaQuery.of(context).size.height * 0.13),
            ),
            DropdownButton2(
                isExpanded: true,
                hint: Row(
                  children: [
                    const Icon(
                      Icons.list,
                      size: 16,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        AppLocalizations.of(context)!.selectTime,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                buttonStyleData: ButtonStyleData(
                  height: 50,
                  width: 160,
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(
                      color: Colors.black26,
                    ),
                    color: const Color.fromARGB(255, 164, 201, 255),
                  ),
                  elevation: 2,
                ),
                iconStyleData: const IconStyleData(
                  icon: Icon(
                    Icons.arrow_drop_down,
                  ),
                  iconSize: 14,
                  iconEnabledColor: Colors.white,
                  iconDisabledColor: Colors.grey,
                ),
                dropdownStyleData: DropdownStyleData(
                    maxHeight: 200,
                    width: 200,
                    padding: null,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: const Color.fromARGB(255, 164, 201, 255),
                    ),
                    elevation: 8,
                    offset: const Offset(-20, 0),
                    scrollbarTheme: ScrollbarThemeData(
                      radius: const Radius.circular(40),
                      thickness: MaterialStateProperty.all(6),
                      thumbVisibility: MaterialStateProperty.all(true),
                    )),
                menuItemStyleData: const MenuItemStyleData(
                  overlayColor: MaterialStatePropertyAll(
                    Color.fromARGB(255, 210, 157, 218),
                  ),
                  height: 40,
                  padding: EdgeInsets.only(left: 14, right: 14),
                ),
                value: context.watch<PredictionProvider>().head,
                items: items
                    .map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                onChanged: (e) {
                  context.read<PredictionProvider>().setSelectedValue(e!);
                  context.read<PredictionProvider>().setHead(e);
                  context.read<PredictionProvider>().setSelectedText(e);
                  print(selectedValue);
                }),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                  // selectedText == '15 Dakika' || selectedText == '15 Minute'
                  //     ? AppLocalizations.of(context)!.fifteenMinText
                  selectedText == '30 Dakika' || selectedText == '30 Minute'
                      ? AppLocalizations.of(context)!.thirtyMinText
                      : selectedText == '45 Dakika' ||
                              selectedText == '45 Minute'
                          ? AppLocalizations.of(context)!.fortyFiveMinText
                          : selectedText == '60 Dakika' ||
                                  selectedText == '60 Minute'
                              ? AppLocalizations.of(context)!.sixtyminText
                              : selectedText == '90 Dakika' ||
                                      selectedText == '90 Minute'
                                  ? AppLocalizations.of(context)!.ninetyminText
                                  : selectedText == '120 Dakika' ||
                                          selectedText == '120 Minute'
                                      ? AppLocalizations.of(context)!
                                          .oneTwentyminText
                                      : selectedText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)),
            ),
            //     ))
          ],
        ),
        // selectedValue == '15 Dakika' || selectedValue == '15 Minute'
        //     ? FifteenMinPredictionTwo(
        //         predictionController1: predictionController15_1,
        //       )
        //     :
        selectedValue == '30 Dakika' || selectedValue == '30 Minute'
            ? ThirtyMinPredictionTwo(
                predictionController1: predictionController30_1,
                predictionController2: predictionController30_2,
              )
            : selectedValue == '45 Dakika' || selectedValue == '45 Minute'
                ? FourtyFiveMinPredictionTwo(
                    predictionController1: predictionController45_1,
                    predictionController2: predictionController45_2,
                    predictionController3: predictionController45_3,
                  )
                : selectedValue == '60 Dakika' || selectedValue == '60 Minute'
                    ? SixtyMinPredictionTwo(
                        predictionController1: predictionController60_1,
                        predictionController2: predictionController60_2,
                        predictionController3: predictionController60_3,
                        predictionController4: predictionController60_4,
                      )
                    : selectedValue == '90 Dakika' ||
                            selectedValue == '90 Minute'
                        ? NinetyMinPredictionTwo(
                            predictionController1: predictionController60_1,
                            predictionController2: predictionController90_2,
                            predictionController3: predictionController90_3,
                            predictionController4: predictionController90_4,
                            predictionController5: predictionController90_5,
                            predictionController6: predictionController90_6,
                          )
                        : selectedValue == '120 Dakika' ||
                                selectedValue == '120 Minute'
                            ? HundredTwentyPredictionTwo(
                                predictionController1:
                                    predictionController120_1,
                                predictionController2:
                                    predictionController120_2,
                                predictionController3:
                                    predictionController120_3,
                                predictionController4:
                                    predictionController120_4,
                                predictionController5:
                                    predictionController120_5,
                                predictionController6:
                                    predictionController120_6,
                                predictionController7:
                                    predictionController120_7,
                                predictionController8:
                                    predictionController120_8,
                              )
                            : ThirtyMinPredictionTwo(
                                predictionController1: predictionController15_1,
                                predictionController2: predictionController30_2,
                              ),
      ],
    );
  }
}
