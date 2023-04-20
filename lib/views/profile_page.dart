import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:glucowizard_flutter/providers/login_provider.dart';
import 'package:glucowizard_flutter/providers/profile_provider.dart';

import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../models/tracking_chart_model.dart';
import '../models/user_model.dart';

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
  final List<String> items = [
    "Erkek",
    "Kadın",
  ];

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
  void onStepCount(StepCount event) {
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    var loginProvider = Provider.of<LoginPageProvider>(context, listen: false);
    setState(() {
      if (profileProvider.users.counter == 1) {
        profileProvider.setOldSteps(event.steps);
        profileProvider.updateCounter(
            loginProvider.userId!, profileProvider.users.counter!);
      }

      context.read<ProfileProvider>().setNewSteps(event.steps);
      _steps = (profileProvider.newSteps! - (profileProvider.oldSteps ?? 0))
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
              color: Colors.white,
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
                        const Text(
                          "Kişisel Bilgiler",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "İsim: ",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                '\t${context.watch<ProfileProvider>().users.name ?? ""}',
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Soyisim: ",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                '\t${context.watch<ProfileProvider>().users.surname ?? ""}',
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Yaş :",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                '\t${context.watch<ProfileProvider>().users.age ?? ""}',
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Cinsiyet :",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                '\t${context.watch<ProfileProvider>().users.gender ?? ""}',
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Boy :",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                '\t${context.watch<ProfileProvider>().users.height ?? ""}',
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Text(
                              "Kilo :",
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                                '\t${context.watch<ProfileProvider>().users.weight ?? ""}',
                                style: const TextStyle(fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
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
                                  title: const Text('Kişisel Bilgiler'),
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
                                              labelText: "Name",
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
                                              labelText: "Surname",
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
                                              labelText: "Age",
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
                                              labelText: "Height",
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
                                                labelText: "Weight"),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButton2(
                                              isExpanded: true,
                                              hint: Row(
                                                children: const [
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
                                                      "Cinsiyet",
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
                                                  color: const Color.fromARGB(
                                                      255, 164, 201, 255),
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
                                                        color: const Color
                                                                .fromARGB(
                                                            255, 164, 201, 255),
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
                                      color: Colors.green,
                                      textColor: Colors.white,
                                      child: const Text('OK'),
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
                        Text('Günlük su tüketim miktarı\n'),
                        Text(
                            '${context.watch<ProfileProvider>().users.water ?? 0}/2000 ml'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                var newWater = profileProvider.water! + 100;
                                context
                                    .read<ProfileProvider>()
                                    .setWater(newWater, loginProvider.userId!);
                              },
                              icon: const Icon(Icons.water),
                            ),
                            const Text('100 ml')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                var newWater = profileProvider.water! + 200;
                                context
                                    .read<ProfileProvider>()
                                    .setWater(newWater, loginProvider.userId!);
                              },
                              icon: const Icon(
                                Icons.water,
                              ),
                            ),
                            const Text('200 ml')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                var newWater = profileProvider.water! + 300;
                                context
                                    .read<ProfileProvider>()
                                    .setWater(newWater, loginProvider.userId!);
                              },
                              icon: const Icon(Icons.water),
                            ),
                            const Text('300 ml')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                var newWater = profileProvider.water! + 400;
                                context
                                    .read<ProfileProvider>()
                                    .setWater(newWater, loginProvider.userId!);
                              },
                              icon: const Icon(Icons.water),
                            ),
                            const Text('400 ml')
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              onPressed: () {
                                var newWater = profileProvider.water! + 500;
                                context
                                    .read<ProfileProvider>()
                                    .setWater(newWater, loginProvider.userId!);
                              },
                              icon: const Icon(Icons.water),
                            ),
                            const Text('500 ml')
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
                        const Text(
                          'Steps taken:',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          _steps,
                          style: const TextStyle(fontSize: 15),
                        ),
                        // const Divider(
                        //   height: 50,
                        //   thickness: 0,
                        //   color: Colors.white,
                        // ),
                        const Text(
                          'Pedestrian status:',
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
                            _status,
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
