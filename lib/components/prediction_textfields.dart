import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:glucowizard_flutter/services/prediction_service.dart';
import 'package:provider/provider.dart';
import 'package:stacked_card_carousel/stacked_card_carousel.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import '../providers/prediction_provider.dart';

class PredictionTextFields extends StatelessWidget {
  final List<String> items = [
    '15 Dakika',
    '30 Dakika',
    '45 Dakika',
    '60 Dakika',
    '90 Dakika',
    '120 Dakika',
  ];
  TextEditingController predictionController1 = TextEditingController();
  TextEditingController predictionController2 = TextEditingController();
  TextEditingController predictionController3 = TextEditingController();
  TextEditingController predictionController4 = TextEditingController();
  TextEditingController predictionController5 = TextEditingController();
  TextEditingController predictionController6 = TextEditingController();

  String? selectedValue;

  PredictionTextFields({super.key, required this.title});
  final String title;

  // final List<Widget> fancyCards = <Widget>[
  //   FancyCard(
  //     image: Image.asset("assets/images/twenty-five.png"),
  //     title: "Don't be sad!",
  //     predictionController: TextEditingController(),
  //   ),
  //   FancyCard(
  //     image: Image.asset("assets/images/twenty.png"),
  //     title: "Go for a walk!",
  //     predictionController: TextEditingController(),
  //   ),
  //   FancyCard(
  //     image: Image.asset("assets/images/fifteen.png"),
  //     title: "Try teleportation!",
  //     predictionController: TextEditingController(),
  //   ),
  //   FancyCard(
  //     image: Image.asset("assets/images/ten.png"),
  //     title: "Enjoy your coffee!",
  //     predictionController: TextEditingController(),
  //   ),
  //   FancyCard(
  //     image: Image.asset("assets/images/five.png"),
  //     title: "Play with your cat!",
  //     predictionController: TextEditingController(),
  //   ),
  //   FancyCard(
  //     image: Image.asset("assets/images/now.png"),
  //     title: "Play with your cat!",
  //     predictionController: TextEditingController(),
  //   ),
  // ];

  @override
  Widget build(BuildContext context) {
    predictionController1.text = "254";
    predictionController2.text = "250";
    predictionController3.text = "249";
    predictionController4.text = "247";
    predictionController5.text = "242";
    predictionController6.text = "235";
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
                        'Select Item',
                        style: TextStyle(
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
                    color: Color(0xff95ABFE),
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
                      color: Color(0xff95ABFE),
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
                value: selectedValue,
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
                  selectedValue = e;
                  // print(context
                  //     .watch<PredictionProvider>()
                  //     .predictionController!
                  //     .text);
                }),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                  'Lütfen 5\'er dakika aralıklarla geçmiş 30 dakikalık verilerinizi giriniz',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  )),
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color(0xff3AB4F2),
                  shadowColor: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  backgroundColor: Color(0xff3AB4F2),
                ),
                onPressed: () {
                  PredictionModel predictionModel = PredictionModel();
                  predictionModel.loadModel(
                      predictionController1.text,
                      predictionController2.text,
                      predictionController3.text,
                      predictionController4.text,
                      predictionController5.text,
                      predictionController6.text);
                },
                child: Text('Tahmin Et'))
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.45,
          child: StackedCardCarousel(
            onPageChanged: (pageIndex) {},
            spaceBetweenItems: 180,
            items: [
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        child: Image.asset("assets/images/twenty-five.png"),
                        height: 50,
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
                            labelText: 'Enter your glucose value',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        child: Image.asset("assets/images/twenty.png"),
                        height: 50,
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
                            labelText: 'Enter your glucose value',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset("assets/images/fifteen.png"),
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
                            labelText: 'Enter your glucose value',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        height: 50,
                        child: Image.asset("assets/images/ten.png"),
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
                            labelText: 'Enter your glucose value',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        child: Image.asset("assets/images/five.png"),
                        height: 50,
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
                            labelText: 'Enter your glucose value',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        width: 50,
                        child: Image.asset("assets/images/now.png"),
                        height: 50,
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
                            labelText: 'Enter your glucose value',
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

// class FancyCard extends StatelessWidget {
//   const FancyCard({
//     super.key,
//     required this.image,
//     required this.title,
//     required this.predictionController,
//   });
//   final TextEditingController predictionController;

//   final Image image;
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     //TextEditingController? textEditingController =
//     //context.watch<PredictionProvider>().predictionController;

//     return Card(
//       elevation: 4.0,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: <Widget>[
//             SizedBox(
//               width: 50,
//               height: 50,
//               child: image,
//             ),
//             TextField(
//               controller: predictionController,
//               decoration: InputDecoration(
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 labelText: 'Enter your glucose value',
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
