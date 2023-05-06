import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:glucowizard_flutter/providers/language_provider.dart';
import 'package:glucowizard_flutter/providers/login_provider.dart';
import 'package:glucowizard_flutter/providers/profile_provider.dart';

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../models/tracking_chart_model.dart';
import '../models/user_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with TickerProviderStateMixin {
  late Stream<StepCount> _stepCountStream;
  late Stream<PedestrianStatus> _pedestrianStatusStream;
  TextEditingController _nameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _surnameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  var water;

  String _status = '?', _steps = '?';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlatformState();
    _nameController.text = context.read<ProfileProvider>().users.name ?? "";
    _surnameController.text =
        context.read<ProfileProvider>().users.surname ?? "";
    _ageController.text = context.read<ProfileProvider>().users.age ?? "";
    _heightController.text = context.read<ProfileProvider>().users.height ?? "";
    _weightController.text = context.read<ProfileProvider>().users.weight ?? "";
  }

  @override
  //void dispose() {}
  void onStepCount(StepCount event) async {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    var loginProvider = Provider.of<LoginPageProvider>(context, listen: false);
    if (profileProvider.users.counter == 1) {
      await profileProvider.pastSteps(loginProvider.userId!, event.steps);
    }
    print(event.steps);
    await context.read<ProfileProvider>().getInfos(loginProvider.userId!);
    if (event.steps < profileProvider.users.pastSteps!) {
      await profileProvider.pastSteps(loginProvider.userId!, event.steps);
    }
    setState(() {
      if (profileProvider.users.counter == 1) {
        profileProvider.setOldSteps(event.steps);
        profileProvider.updateCounter(
            loginProvider.userId!, profileProvider.users.counter!);
      }

      context.read<ProfileProvider>().setNewSteps(event.steps);

      _steps = (profileProvider.newSteps! -
              (profileProvider.users.pastSteps ?? profileProvider.newSteps!))
          .toString();
      print(profileProvider.newSteps!);
      context
          .read<ProfileProvider>()
          .updateSteps(loginProvider.userId!, event.steps);
      //print(profileProvider.oldSteps!);
    });
  }

  void onPedestrianStatusChanged(PedestrianStatus event) {
    print(event);
    if (!mounted) return;
    setState(() {
      _status = event.status;
    });
  }

  void onPedestrianStatusError(error) {
    print('onPedestrianStatusError: $error');
    setState(() {
      _status = 'Pedestrian Status not available';
    });
    print(_status);
  }

  void onStepCountError(error) {
    print('onStepCountError: $error');
    setState(() {
      _steps = 'Step Count not available';
    });
  }

  void initPlatformState() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream
        .listen(onPedestrianStatusChanged)
        .onError(onPedestrianStatusError);

    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(onStepCount).onError(onStepCountError);

    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    var languageProvider =
        Provider.of<LanguageProvider>(context, listen: false);
    var profileProvider1 = Provider.of<ProfileProvider>(context, listen: false);
    var gender = profileProvider1.users.gender == 'Male' &&
            languageProvider.locale.toString() == 'en'
        ? 'Male'
        : profileProvider1.users.gender == 'Male' &&
                languageProvider.locale.toString() == 'tr'
            ? 'Erkek'
            : profileProvider1.users.gender == 'Erkek' &&
                    languageProvider.locale.toString() == 'en'
                ? 'Male'
                : profileProvider1.users.gender == 'Erkek' &&
                        languageProvider.locale.toString() == 'tr'
                    ? 'Erkek'
                    : profileProvider1.users.gender == 'Kadın' &&
                            languageProvider.locale.toString() == 'tr'
                        ? 'Kadın'
                        : profileProvider1.users.gender == 'Kadın' &&
                                languageProvider.locale.toString() == 'en'
                            ? 'Female'
                            : profileProvider1.users.gender == 'Female' &&
                                    languageProvider.locale.toString() == 'en'
                                ? 'Female'
                                : profileProvider1.users.gender == 'Female' &&
                                        languageProvider.locale.toString() ==
                                            'tr'
                                    ? 'Kadın'
                                    : "";
    final List<String> items = [
      AppLocalizations.of(context)!.male,
      AppLocalizations.of(context)!.female,
    ];
    water = double.parse(context.watch<ProfileProvider>().users.water!);
    print(context.watch<ProfileProvider>().users.water);
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    if (DateTime.now().hour == 0 && DateTime.now().minute == 0) {
      print('object');
    }
    //context.read<ProfileProvider>().setWater(-100);
    var loginProvider = Provider.of<LoginPageProvider>(context, listen: false);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
              color: Color.fromARGB(255, 246, 244, 248),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                AppLocalizations.of(context)!.personal_info,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 107,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Image.asset(
                                            'assets/images/person.png',
                                            scale: 4,
                                          ),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.name,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  Container(
                                    width: 107,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffCCA8E9),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                            bottomLeft: Radius.circular(12))),
                                    child: Center(
                                      child: Text(
                                          '\t${context.watch<ProfileProvider>().users.name ?? ""}',
                                          style: const TextStyle(fontSize: 20)),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 107,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(top: 4),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0.0),
                                      child: Row(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.only(
                                                right: 0.0, left: 0),
                                            child: Image.asset(
                                                'assets/images/surname.png',
                                                scale: 4),
                                          ),
                                          Text(
                                            AppLocalizations.of(context)!
                                                .surname,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(11),
                                  ),
                                  Container(
                                    width: 107,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffCCA8E9),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                            bottomLeft: Radius.circular(12))),
                                    child: Center(
                                      child: Text(
                                          '\t${context.watch<ProfileProvider>().users.surname ?? ""}',
                                          style: const TextStyle(fontSize: 20)),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 107,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 107,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 2.0),
                                          child: Image.asset(
                                              'assets/images/gender.png',
                                              scale: 4),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.gender,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  Container(
                                    width: 107,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffCCA8E9),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                            bottomLeft: Radius.circular(12))),
                                    child: Center(
                                      child: Text('\t${gender}',
                                          style: const TextStyle(fontSize: 20)),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 107,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Image.asset(
                                              'assets/images/age.png',
                                              scale: 4),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.age,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  Container(
                                    width: 107,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffCCA8E9),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                            bottomLeft: Radius.circular(12))),
                                    child: Center(
                                      child: Text(
                                          '\t${context.watch<ProfileProvider>().users.age ?? ""}',
                                          style: const TextStyle(fontSize: 20)),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 107,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 107,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: 8.0),
                                          child: Image.asset(
                                              'assets/images/height.png',
                                              scale: 4),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.height,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  Container(
                                    width: 107,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffCCA8E9),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                            bottomLeft: Radius.circular(12))),
                                    child: Center(
                                      child: Text(
                                          '\t${context.watch<ProfileProvider>().users.height ?? ""}',
                                          style: const TextStyle(fontSize: 20)),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              width: 107,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.white,
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    width: 107,
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 8.0),
                                          child: Image.asset(
                                              'assets/images/weight.png',
                                              scale: 4),
                                        ),
                                        Text(
                                          AppLocalizations.of(context)!.weight,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  ),
                                  Container(
                                    width: 107,
                                    decoration: const BoxDecoration(
                                        color: Color(0xffCCA8E9),
                                        borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(12),
                                            bottomLeft: Radius.circular(12))),
                                    child: Center(
                                      child: Text(
                                          '\t${context.watch<ProfileProvider>().users.weight ?? ""}',
                                          style: const TextStyle(fontSize: 20)),
                                    ),
                                    padding: const EdgeInsets.all(12),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0.002,
                    right: 0.002,
                    child: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // context.read<ProfileProvider>().getInfos(
                        //     context.read<LoginPageProvider>().userId!);
                        showDialog(
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                child: AlertDialog(
                                  title: Text(AppLocalizations.of(context)!
                                      .personal_info),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _nameController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              labelText:
                                                  AppLocalizations.of(context)!
                                                      .name,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            controller: _surnameController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              labelText:
                                                  AppLocalizations.of(context)!
                                                      .surname,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: _ageController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              labelText:
                                                  AppLocalizations.of(context)!
                                                      .age,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: _heightController,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              labelText:
                                                  AppLocalizations.of(context)!
                                                      .height,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextField(
                                            keyboardType: TextInputType.number,
                                            controller: _weightController,
                                            decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                ),
                                                labelText: AppLocalizations.of(
                                                        context)!
                                                    .weight),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Row(
                                                children: [
                                                  Icon(
                                                    Icons.list,
                                                    size: 16,
                                                    color: Colors.white,
                                                  ),
                                                  SizedBox(
                                                    width: 4,
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      AppLocalizations.of(
                                                              context)!
                                                          .gender,
                                                      style: TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                      ),
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              buttonStyleData: ButtonStyleData(
                                                height: 50,
                                                width: 160,
                                                padding: const EdgeInsets.only(
                                                    left: 14, right: 14),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(14),
                                                  border: Border.all(
                                                    color: Colors.black26,
                                                  ),
                                                  color:
                                                      const Color(0xffB7A1E0),
                                                ),
                                                elevation: 2,
                                              ),
                                              iconStyleData:
                                                  const IconStyleData(
                                                icon: Icon(
                                                  Icons.arrow_drop_down,
                                                ),
                                                iconSize: 14,
                                                iconEnabledColor: Colors.white,
                                                iconDisabledColor: Colors.grey,
                                              ),
                                              dropdownStyleData:
                                                  DropdownStyleData(
                                                      maxHeight: 200,
                                                      width: 200,
                                                      padding: null,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        color: const Color(
                                                            0xffB7A1E0),
                                                      ),
                                                      elevation: 8,
                                                      offset:
                                                          const Offset(-20, 0),
                                                      scrollbarTheme:
                                                          ScrollbarThemeData(
                                                        radius: const Radius
                                                            .circular(40),
                                                        thickness:
                                                            MaterialStateProperty
                                                                .all(6),
                                                        thumbVisibility:
                                                            MaterialStateProperty
                                                                .all(true),
                                                      )),
                                              menuItemStyleData:
                                                  const MenuItemStyleData(
                                                overlayColor:
                                                    MaterialStatePropertyAll(
                                                  Color.fromARGB(
                                                      255, 210, 157, 218),
                                                ),
                                                height: 40,
                                                padding: EdgeInsets.only(
                                                    left: 14, right: 14),
                                              ),
                                              value: context
                                                  .watch<ProfileProvider>()
                                                  .gender,
                                              items: items
                                                  .map((item) =>
                                                      DropdownMenuItem<String>(
                                                        value: item,
                                                        child: Text(
                                                          item,
                                                          style:
                                                              const TextStyle(
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                      ))
                                                  .toList(),
                                              onChanged: (e) {
                                                profileProvider.setGender(e!);

                                                print(e);
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                  actions: <Widget>[
                                    MaterialButton(
                                      color: const Color(0xffB7A1E0),
                                      textColor: Colors.white,
                                      child: Text(
                                          AppLocalizations.of(context)!.okay),
                                      onPressed: () {
                                        var loginProvider =
                                            Provider.of<LoginPageProvider>(
                                                context,
                                                listen: false);
                                        // Update user info
                                        UserModel userModel = UserModel(
                                          id: loginProvider.userId,
                                          name: _nameController.text,
                                          surname: _surnameController.text,
                                          age: _ageController.text,
                                          height: _heightController.text,
                                          weight: _weightController.text,
                                          gender: profileProvider.gender,
                                        );
                                        profileProvider
                                            .updateTrackingChart(userModel);
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            });

                        // Edit button pressed
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.20,
            width: MediaQuery.of(context).size.width * 0.9,
            child: LiquidLinearProgressIndicator(
              value: water / 2000, // Defaults to 0.5.
              valueColor: const AlwaysStoppedAnimation(
                  Colors.blue), // Defaults to the current Theme's accentColor.
              backgroundColor: Colors
                  .white, // Defaults to the current Theme's backgroundColor.
              borderColor: Colors.white,
              borderWidth: 0.0,
              borderRadius: 12.0,
              direction: Axis
                  .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
              center: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text('${AppLocalizations.of(context)!.water}\n'),
                        Text(
                            '${context.watch<ProfileProvider>().users.water ?? 0}/2000 mL'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                var newWater = profileProvider.water! + 100;
                                context
                                    .read<ProfileProvider>()
                                    .setWater(newWater, loginProvider.userId!);
                              },
                              child: Image.asset(
                                'assets/images/100water.png',
                                scale: 1.6,
                              ),
                            ),
                            const Text('100 mL')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                var newWater = profileProvider.water! + 200;
                                context
                                    .read<ProfileProvider>()
                                    .setWater(newWater, loginProvider.userId!);
                              },
                              child: Image.asset(
                                'assets/images/200water.png',
                                scale: 2.5,
                              ),
                            ),
                            const Text('200 mL')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                var newWater = profileProvider.water! + 300;
                                context
                                    .read<ProfileProvider>()
                                    .setWater(newWater, loginProvider.userId!);
                              },
                              child: Image.asset(
                                'assets/images/300water.png',
                                scale: 3.2,
                              ),
                            ),
                            const Text('300 mL')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                var newWater = profileProvider.water! + 400;
                                context
                                    .read<ProfileProvider>()
                                    .setWater(newWater, loginProvider.userId!);
                              },
                              child: Image.asset(
                                'assets/images/400water.png',
                                scale: 4,
                              ),
                            ),
                            const Text('400 mL')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // IconButton(
                            //   onPressed: () {
                            //     var newWater = profileProvider.water! + 500;
                            //     context
                            //         .read<ProfileProvider>()
                            //         .setWater(newWater, loginProvider.userId!);
                            //   },
                            //   icon: const Icon(Icons.water),
                            // ),
                            GestureDetector(
                              onTap: () {
                                var newWater = profileProvider.water! + 500;
                                context
                                    .read<ProfileProvider>()
                                    .setWater(newWater, loginProvider.userId!);
                              },
                              child: Image.asset(
                                'assets/images/500water.png',
                                scale: 4.8,
                              ),
                            ),
                            const Text('500 mL')
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.9,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: Colors.white,
                elevation: 30.0,
                shadowColor: Colors.white,
                child: Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(context)!.step_taken,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          _steps == 'Step Count not available'
                              ? AppLocalizations.of(context)!.step_not_avaliable
                              : _steps,
                          style: const TextStyle(fontSize: 15),
                        ),
                        // const Divider(
                        //   height: 50,
                        //   thickness: 0,
                        //   color: Colors.white,
                        // ),
                        Text(
                          AppLocalizations.of(context)!.pedestrian_status,
                          style: TextStyle(fontSize: 15),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _status == 'walking'
                                  ? Icons.directions_walk
                                  : _status == 'stopped'
                                      ? Icons.accessibility_new
                                      : Icons.error,
                              size: 125,
                            ),
                            // new CircularPercentIndicator(
                            //   radius: 55.0,
                            //   lineWidth: 5.0,
                            //   percent: _steps == '0'
                            //       ? 0
                            //       : _steps == null
                            //           ? 0
                            //           : int.parse(_steps) / 6000,
                            //   center: new Text("100%"),
                            //   progressColor: Colors.green,
                            // )
                          ],
                        ),
                        Center(
                          child: Text(
                            _status == 'walking'
                                ? AppLocalizations.of(context)!.walking
                                : _status == 'stopped'
                                    ? AppLocalizations.of(context)!.stopped
                                    : '?',
                            style: _status == 'walking' || _status == 'stopped'
                                ? const TextStyle(fontSize: 30)
                                : const TextStyle(
                                    fontSize: 20, color: Colors.red),
                          ),
                        )
                      ]),
                )),
          ),
        ],
      ),
    );
  }
}
