import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:glucowizard_flutter/services/diagnose_service.dart';

class DiagnoseCard extends StatelessWidget {
  const DiagnoseCard(
      {super.key,
      required this.glucoseController,
      required this.insulinController});
  final TextEditingController glucoseController;
  final TextEditingController insulinController;

  @override
  Widget build(BuildContext context) {
    DiagnoseModel diagnoseModel = DiagnoseModel();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: ElevatedButton(
              onPressed: () {
                diagnoseModel
                    .loadModel(
                      glucoseController.text,
                      insulinController.text,
                    )
                    .then((value) => CoolAlert.show(
                          context: context,
                          confirmBtnText: AppLocalizations.of(context)!.okay,
                          type: CoolAlertType.error,
                          text: value.toString(),
                        ));
              },
              child: Text(AppLocalizations.of(context)!.diagnose)),
        ),
        Padding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.02,
              bottom: MediaQuery.of(context).size.height * 0.05),
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
                    child: Image.asset(
                      "assets/images/glucose-meter.png",
                    ),
                  ),
                  SizedBox(
                    width: 200,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
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
        Card(
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
      ],
    );
  }
}
