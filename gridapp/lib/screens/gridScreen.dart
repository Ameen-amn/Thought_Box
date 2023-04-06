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
  final TextEditingController _inputAlpha = TextEditingController();
  bool circle = false;
  String newInpiut = "";
  List<String> inputList = [];
  String lastIn = '';
  String secondLastIn = "";
  bool gameStart = false;
  int secondIndex = 0;
  int lastIndex = 0;
  int entry = 0;
  bool allDirections = false;
  @override
  Widget build(BuildContext context) {
    final List data = ModalRoute.of(context)!.settings.arguments as List;
    int rowNum = data[0];
    int colNum = data[1];
    String alpha = data[2];
    List<String> alphaList = alpha.toUpperCase().split("");

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
                inputList = value.toUpperCase().split("");

                if (inputList.isNotEmpty) {
                  gameStart = true;

                  if (inputList.length == 1) {
                    lastIn = inputList[inputList.length - 1];
                  }
                  if (inputList.length >= 2) {
                    lastIn = inputList[inputList.length - 1];
                    secondLastIn = inputList[inputList.length - 2];
                  }
                }
                setState(() {
                  newInpiut = value.toUpperCase();
                });
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Icon(Icons.add_box_outlined),
                const Text(
                  "All Direction",
                  textAlign: TextAlign.end,
                ),
                Switch(
                    value: allDirections,
                    onChanged: (_) {
                      setState(() {
                        allDirections = !allDirections;
                      });
                    })
              ],
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
                    bool rldiaCheck = false;
                    bool lrdiaCheck = false;

                    if (inputList.length == 1) {
                      entry = alphaList.indexOf(lastIn);
                    }
                    if (inputList.length == 2) {
                      secondIndex = alphaList.indexOf(secondLastIn);
                      lastIndex = alphaList.indexOf(lastIn);
                    }

                    newInpiut.contains(alphaList[i]) ? c = true : c = false;
                    c ? gameStart = true : gameStart = false;

                    if ((entry < colNum || entry % colNum == 0) &&
                        !allDirections) {
                      if (inputList.length >= 2) {
                        if (lastIndex - secondIndex == 1) {
                          rowCheck = true;
                        } else if (lastIndex - secondIndex < colNum) {
                          errorOccur = true;
                          c = false;
                        } else if ((lastIndex - secondIndex) % colNum == 0) {
                          columnCheck = true;
                        } else if (rowNum == colNum) {
                          if (lastIndex - secondIndex == colNum - 1) {
                            rldiaCheck = true;
                          }
                        }
                        // ROW CHEKING
                        if (rowCheck) {
                          print("row Check");
                          int rowIndexLast = alphaList.indexOf(lastIn);
                          int rowIndexSecLast = alphaList.indexOf(secondLastIn);
                          if (rowIndexSecLast + 1 != rowIndexLast) {
                            errorOccur = true;
                            c = false;
                          }

                          if (inputList.length > colNum) {
                            errorOccur = true;
                            c = false;
                          }
                          if (rowIndexLast % colNum == 0) {
                            errorOccur = true;
                            c = false;
                          }
                        }
                        //COLUMN CHECK
                        else if (columnCheck) {
                          int colLastIndex = alphaList.indexOf(lastIn);
                          int colSecondLastIndex =
                              alphaList.indexOf(secondLastIn);

                          if (colLastIndex - colSecondLastIndex != colNum) {
                            errorOccur = true;
                            c = false;
                          }
                          if (inputList.length > rowNum) {
                            errorOccur = true;
                            c = false;
                          }
                        }
                        //Diagonal Checking right to left
                        else if (rldiaCheck) {
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
                    }

                    //ALL DIRECTION IS ON
                    else if (allDirections) {
                      if (inputList.length >= 2) {
                        if ((lastIndex - secondIndex).abs() == 1) {
                          rowCheck = true;
                        } else if ((lastIndex - secondIndex).abs() % colNum ==
                            0) {
                          columnCheck = true;
                        } else if (rowNum == colNum) {
                          if ((lastIndex - secondIndex).abs() == colNum - 1) {
                            rldiaCheck = true;
                          } else if ((lastIndex - secondIndex).abs() ==
                              colNum + 1) {
                            lrdiaCheck = true;
                          }
                        }

                        // ROW CHEKING
                        if (rowCheck) {
                          int rowIndexLast = alphaList.indexOf(lastIn);
                          int rowIndexSecLast = alphaList.indexOf(secondLastIn);
                          if ((rowIndexLast - rowIndexSecLast).abs() != 1) {
                            errorOccur = true;
                            c = false;
                          }

                          if (inputList.length > colNum) {
                            errorOccur = true;
                            c = false;
                          }
                        } else if (columnCheck) {
                          int colLastIndex = alphaList.indexOf(lastIn);
                          int colSecondLastIndex =
                              alphaList.indexOf(secondLastIn);

                          if ((colLastIndex - colSecondLastIndex).abs() !=
                              colNum) {
                            errorOccur = true;
                            c = false;
                          }
                          if (inputList.length > rowNum) {
                            errorOccur = true;
                            c = false;
                          }
                        }
                        //Diagonal Checking from right to left
                        else if (rldiaCheck) {
                          int diaLastIndex = alphaList.indexOf(lastIn);
                          int diaSecondLastIndex =
                              alphaList.indexOf(secondLastIn);
                          if ((diaLastIndex - diaSecondLastIndex).abs() !=
                              colNum - 1) {
                            errorOccur = true;
                            c = false;
                          }
                        }
                        //Diagonal Checking from  left to right
                        else if (lrdiaCheck) {
                          int diaLastIndex = alphaList.indexOf(lastIn);
                          int diaSecondLastIndex =
                              alphaList.indexOf(secondLastIn);

                          if ((diaLastIndex - diaSecondLastIndex).abs() !=
                              colNum + 1) {
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
