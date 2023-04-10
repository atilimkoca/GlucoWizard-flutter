import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ml_dataframe/ml_dataframe.dart';
import 'package:ml_algo/ml_algo.dart';

class DiagnoseCard extends StatelessWidget {
  const DiagnoseCard(
      {super.key,
      required this.glucoseController,
      required this.insulinController});
  final TextEditingController glucoseController;
  final TextEditingController insulinController;
  static final _formKey = GlobalKey<FormState>();
  static final _insulinkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    glucoseController.text = '148';
    insulinController.text = '220';
    Future predictDiagnose() async {
      String data = await DefaultAssetBundle.of(context)
          .loadString("assets/diabetestype.json");

      final model = KnnClassifier.fromJson(data);
      final features = DataFrame([
        ['feature_1', 'feature_2'],
        [glucoseController.text, insulinController.text],
      ]);
      final prediction = model.predict(features);

      return prediction.rows.first.first;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: ElevatedButton(
              onPressed: () async {
                predictDiagnose().then((value) => CoolAlert.show(
                      context: context,
                      confirmBtnText: AppLocalizations.of(context)!.okay,
                      type: CoolAlertType.error,
                      text: value.toString() == '0.0'
                          ? 'Sağlıklısınız'
                          : value.toString() == '1.0'
                              ? 'Gizli Şeker Hastası'
                              : value.toString() == '2.0'
                                  ? 'Tip 1 Diyabetlisiniz'
                                  : value.toString() == '3.0'
                                      ? 'Tip 2 Diyabetlisiniz'
                                      : '',
                    ));

                bool validate2 = _insulinkey.currentState!.validate();
                bool validate = _formKey.currentState!.validate();
                if (validate && validate2) {
                  // diagnoseModel
                  //     .loadModel(
                  //       glucoseController.text,
                  //       insulinController.text,
                  //     )
                  //     .then((value) => CoolAlert.show(
                  //           context: context,
                  //           confirmBtnText: AppLocalizations.of(context)!.okay,
                  //           type: CoolAlertType.error,
                  //           text: value == 0
                  //               ? 'Sağlıklısınız'
                  //               : value == 1
                  //                   ? 'Gizli Şeker Hastası'
                  //                   : value == 2
                  //                       ? 'Tip 1 Diyabetlisiniz'
                  //                       : value == 3
                  //                           ? 'Tip 2 Diyabetlisiniz'
                  //                           : '',
                  //         ));
                }
              },
              child: Text(AppLocalizations.of(context)!.diagnose)),
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.01,
                bottom: MediaQuery.of(context).size.height * 0.02),
            child: Card(
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
                      child: Image.asset(
                        "assets/images/glucose-meter.png",
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: TextFormField(
                          onSaved: (value) {},
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

                          controller: glucoseController,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Form(
          key: _insulinkey,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                      padding: const EdgeInsets.only(bottom: 0),
                      child: Image.asset("assets/images/insulin.png"),
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: TextFormField(
                        onSaved: (value) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return AppLocalizations.of(context)!
                                .enter_insulin_value;
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

                        controller: insulinController,
                        //controller: predictionController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          labelText:
                              AppLocalizations.of(context)!.enter_insulin_value,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
