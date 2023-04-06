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
  int secondIndex = 0;
  int lastIndex = 0;
  int Entry = 0;
  @override
  Widget build(BuildContext context) {
    final List data = ModalRoute.of(context)!.settings.arguments as List;
    int rowNum = data[0];
    int colNum = data[1];
    String alpha = data[2];
    List<String> alphaList = alpha.split("");

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

                  if (inputList.length == 1) {
                    lastIn = inputList[inputList.length - 1];
                    //   secondLastIn = inputList[inputList.length - 2];
                  }
                  if (inputList.length >= 2) {
                    //  print("input lis length ${inputList.length}");
                    lastIn = inputList[inputList.length - 1];
                    secondLastIn = inputList[inputList.length - 2];
                  }
                  print(inputList);
                }
                setState(() {
                  newInpiut = value;
                });
              },
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [],
              ),
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
                  itemBuilder: (BuildContext ctx, i) {
                    bool c = false;

                    bool errorOccur = false;

                    bool rowCheck = false;
                    bool columnCheck = false;
                    bool diaCheck = false;

                    //new Mehtod
                    if (inputList.length == 1) {
                      // secondIndex = alphaList.indexOf(secondLastIn);
                      Entry = alphaList.indexOf(lastIn);
                    }
                    if (inputList.length == 2) {
                      secondIndex = alphaList.indexOf(secondLastIn);
                      lastIndex = alphaList.indexOf(lastIn);
                    }

                    newInpiut.contains(alphaList[i]) ? c = true : c = false;
                    c ? gameStart = true : gameStart = false;

                    if (Entry < colNum || Entry % colNum == 0) {
                      if (inputList.length >= 2) {
                        if (lastIndex - secondIndex == 1) {
                          rowCheck = true;
                        } else if ((lastIndex - secondIndex) % colNum == 0) {
                          columnCheck = true;
                        } else if (rowNum == colNum) {
                          if (lastIndex - secondIndex == colNum - 1) {
                            diaCheck = true;
                          }
                        }
                        // ROW CHEKING
                        if (rowCheck) {
                          int rowIndexLast = alphaList.indexOf(lastIn);
                          int rowIndexSecLast = alphaList.indexOf(secondLastIn);
                          if (rowIndexSecLast + 1 != rowIndexLast) {
                            //  print("colum error occr here");
                            errorOccur = true;
                            c = false;
                          }
                          print("row checking");
                          if (inputList.length > colNum) {
                            errorOccur = true;
                            c = false;
                          }
                          if (rowIndexLast % colNum == 0) {
                            errorOccur = true;
                            c = false;
                          }
                        }
                        // print("col entry checking f s $lastIndex $secondIndex");
                        else if (columnCheck) {
                          print("col checking");
                          int colLastIndex = alphaList.indexOf(lastIn);
                          int colSecondLastIndex =
                              alphaList.indexOf(secondLastIn);
                          /*   print(
                              "col checking f s $colLastIndex $colSecondLastIndex"); */
                          if (colLastIndex - colSecondLastIndex != colNum) {
                            errorOccur = true;
                            c = false;
                          }
                          if (inputList.length > rowNum) {
                            errorOccur = true;
                            c = false;
                          }
                        } 
                        //Diagonal Checking
                        else if (diaCheck) {
                          print("dia checking");
                          int diaLastIndex = alphaList.indexOf(lastIn);
                          int diaSecondLastIndex =
                              alphaList.indexOf(secondLastIn);
                          if (diaLastIndex - diaSecondLastIndex != colNum - 1) {
                            errorOccur = true;
                            c = false;
                          }
                        } else {
                          errorOccur = true;
                          c = false;
                        }
                      }
                    } else {
                      errorOccur = true;
                      c = false;
                    }
                 

                    return AlphaButton(alphaList[i], c, gameStart, errorOccur);
                  }),
            )
          ],
        ),
      ),
    );
  }
}







//Working method
/* 

 if (inputList.length >= 2) {
                    lastIn = inputList[inputList.length - 1];
                    secondLastIn = inputList[inputList.length - 2];
                  }
if (secondIndex + 2 != lastIndex) {
                        if (inputList.length >= 2) {
                          //DIAGONAL CHECKING
                          //avoid left ot right
                          if (lastIndex - secondIndex > colNum) {
                            c = false;
                            errorOccur = true;
                          }
                          //ROW CHECKING
                          if (secondIndex > lastIndex) {
                            c = false;
                            errorOccur = true;
                          }
                          if ((lastIndex - secondIndex).abs() < rowNum) {
                            int rowChecklast = alphaList.indexOf(lastIn);
                            int rowCheckSecondLast =
                                alpha.indexOf(secondLastIn);
                            if ((rowChecklast - rowCheckSecondLast).abs() >
                                rowNum) {
                              errorOccur = true;
                              c = false;
                            } else if (inputList.length > rowNum) {
                              errorOccur = true;
                              c = false;
                            }
                            /*   print("circle value${c}");
                        print("eror staus${errorOccur}"); */
                          }
                          //COLUMN CHECKING
                          else if ((lastIndex + secondIndex).abs() % colNum ==
                              0) {
                            int colChecklast = alphaList.indexOf(lastIn);
                            int colCheckSecondLast =
                                alpha.indexOf(secondLastIn);
                            if (colCheckSecondLast != colChecklast - colNum) {
                              errorOccur = true;
                              c = false;
                            }
                            if ((colCheckSecondLast - colChecklast).abs() %
                                    colNum !=
                                0) {
                              errorOccur = true;
                              c = false;
                            } else if (inputList.length > colNum) {
                              errorOccur = true;
                              c = false;
                            }
                            if (lastIndex - secondIndex > colNum) {
                              errorOccur = true;
                              c = false;
                            }
                          }
                        }
                      } */