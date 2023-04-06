import 'package:flutter/material.dart';
import 'package:gridapp/screens/gridScreen.dart';
import '../constants.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/HomeScreen";
  HomeScreen({super.key});
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _rowNum = TextEditingController();
  final TextEditingController _colNum = TextEditingController();
  final TextEditingController _alphabets = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text(
          "Home",
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.5,
        decoration: const BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            blurRadius: 2,
            color: Colors.black26,
            offset: Offset(0, 2),
          )
        ]),
        child: ListView(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                "Enter the Number of Rows \n Columns and The Alphabets",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width - 40,
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 40, 5, 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _rowNum,
                              decoration: kFieldStyle.copyWith(
                                  label: const Text("Rows")),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the No. of Rows";
                                }
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextFormField(
                              controller: _colNum,
                              decoration: kFieldStyle.copyWith(
                                  label: const Text("Columns")),
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Enter the No. of Columns";
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 5, 5, 30),
                      child: TextFormField(
                        controller: _alphabets,
                        decoration: kFieldStyle.copyWith(
                            label: const Text("Alphabets")),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          int reqAlhpabets =
                              int.parse(_colNum.text) * int.parse(_rowNum.text);
                          if (value!.isEmpty) {
                            return "Enter the Alphabets";
                          } else if (_alphabets.text.length != reqAlhpabets) {
                            return "Only ${reqAlhpabets} needed Now its ${_alphabets.text.length}";
                          }
                        },
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(150, 50),
                          backgroundColor: Colors.black),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final data = [
                            int.parse(_rowNum.text),
                            int.parse(_colNum.text),
                            _alphabets.text,
                          ];
                          Navigator.of(context)
                              .pushNamed(GridScreen.routeName, arguments: data);
                        }
                      },
                      icon: const Icon(Icons.grid_3x3),
                      label: const Text("Make Grid"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
