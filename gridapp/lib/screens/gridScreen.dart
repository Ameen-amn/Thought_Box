import 'package:flutter/material.dart';
import 'package:gridapp/constants.dart';

import '../widgets/alphaButton.dart';

class GridScreen extends StatefulWidget {
  static const routeName = "/GridScreen";
  const GridScreen({super.key});

  @override
  State<GridScreen> createState() => _GridScreenState();
}

class _GridScreenState extends State<GridScreen> {
  TextEditingController _inputAlpha = TextEditingController();
  bool circle = false;
  String newInpiut = "";
  List<String> inputList = [];
  String lastIn = '';
  String secondLastIn = "";
  bool gameStart = false;
  bool errorOccur = false;

  @override
  Widget build(BuildContext context) {
    final List data = ModalRoute.of(context)!.settings.arguments as List;
    int rowNum = data[0];
    int colNum = data[1];
    String alpha = data[2];
    List<String> alphaList = alpha.split("");
    List<List<String>> alphaMainList = [
      [""]
    ];
    /* print(alphaList.sublist(0, 3));
    print(alphaList.sublist(3, 6)); */
    /* for (int i = 0; i < rowNum; i++) {
      int startIndex = (rowNum * i) + i;
      int endIndex = colNum - 1;
      print("starting Index${startIndex}");
      print("Ending Index${endIndex + startIndex + 1}");
      alphaMainList[i]
          .addAll(alphaList.sublist(startIndex, endIndex + startIndex + 1));
    }
    print(alphaMainList); */
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Play Ground",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 40, 10, 10),
        child: Column(
          children: [
            TextField(
              controller: _inputAlpha,
              decoration: kFieldStyle.copyWith(label: const Text("Play text")),
              onChanged: (value) {
                inputList = value.split("");
                String lastInput = "";
                if (inputList.isNotEmpty) {
                  gameStart = true;
                  lastIn = inputList[inputList.length - 1];
                  if (inputList.length >= 2) {
                    secondLastIn = inputList[inputList.length - 2];
                  }
                  print(inputList);
                }
                setState(() {
                  newInpiut = value;
                });
              },
            ),
            const SizedBox(
              height: 40,
            ),
            Expanded(
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: colNum,
                    mainAxisSpacing: 15,
                    crossAxisSpacing: 15,
                  ),
                  itemCount: alphaList.length,
                  itemBuilder: (BuildContext, i) {
                    bool c = false;
                    int newIndex = newInpiut.indexOf(lastIn);
                    //new Mehtod
                    int secondIndex = alphaList.indexOf(secondLastIn);
                    int alphaIndex = alphaList.indexOf(lastIn);
                    if (alphaIndex / colNum < 0) {}
                    //test Area over
                    /************ */
                    //  alphaList[i] == lastIn ? c[i] = true : c[i] = false;

                    newInpiut.contains(alphaList[i]) ? c = true : c = false;
                    c ? gameStart = true : gameStart = false;
                    /*  if (inputList.length > 2) {
                      print(alphaIndex - 1);
                      print(secondIndex);
                      if (alphaIndex - 2 == secondIndex && c) {
                        errorOccur = false;
                        c = true;
                      } else {
                        errorOccur = true;
                        c = false;
                      }
                    } */
                    //bool  color=  gameStart && !errorOccur;
                    return AlphaButton(alphaList[i], c, gameStart, errorOccur);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
