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
 
  @override
  Widget build(BuildContext context) {
    final List data = ModalRoute.of(context)!.settings.arguments as List;
    int rowNum = data[0];
    int colNum = data[1];
    String alpha = data[2];
    List<String> alphaList = alpha.split("");
    List<List<String>> alphaMainList;
    List  isCircle = List.filled(rowNum* colNum, false);
    /* for (int i = 0; i < rowNum; i++) {
      for(int j=0;j<colNum;j++){
        alphaMainList.
      }
    } */

    print(alphaList);
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
                  lastIn = inputList[inputList.length - 1];
                  print(inputList);
                }
                
                //Method 1

                /* if (alphaList.contains(lastInput)) {
                  for (int i = 0; i < inputList.length;i++){

                    for (int j = 0; j < colNum; j++) {
                      if (alphaList[j] == inputList[j]) {
                        setState(() {
                          circle = true;
                        });
                      } else {
                        setState(() {
                          circle = false;
                        });
                      }
                    }
                  }
                } */
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
                    if (inputList.isNotEmpty) {
                      if (inputList.length <= colNum) {
                        for (int i = 0; i < inputList.length; i++) {
                          if (alphaList.sublist(0, colNum).contains(lastIn)) {
                            c = true;
                          } else {
                            c = false;
                          }
                          // print("for loop wrking");
                        }
                        print("c value ${c}");
                      }
                    }

                    return AlphaButton(alphaList[i],c);
                  }),
            )
          ],
        ),
      ),
    );
  }
}
