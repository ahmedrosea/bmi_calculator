import 'package:flutter/material.dart';
import 'package:bmi_calculator/constants/constants.dart';
import 'package:provider/provider.dart';

import '../state_management/provider.dart';
import 'bmi_history.dart';

class Result extends StatelessWidget {
  const Result({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double bmi = Provider.of<Data>(context).bmi;
    String bmiStatus = Provider.of<Data>(context).bmiStatus;
    return Scaffold(
      backgroundColor: pageColor,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: whiteFont,
            size: 20.0,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: const Icon(Icons.history, color: whiteFont, size: 30.0),
              onPressed: () async {
                await Provider.of<HistoryData>(context, listen: false)
                    .selectData();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const History()));
              },
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
      ),
      body: DefaultTextStyle(
        style: const TextStyle(
          fontFamily: 'Raleway',
        ),
        child: Container(
          padding: const EdgeInsets.all(30.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Expanded(
                child: Text(
                  'Result',
                  style: TextStyle(
                    fontSize: 40.0,
                    color: whiteFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                height: 300.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Your current BMI',
                      style: TextStyle(
                        fontSize: 26.0,
                        color: Colors.grey[300],
                      ),
                    ),
                    Text(
                      Provider.of<Data>(context).bmi.toString(),
                      style: const TextStyle(
                        color: whiteFont,
                        fontSize: 80.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                decoration: const BoxDecoration(
                  color: greyColor,
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              Text(
                'Your BMI is $bmi, indicating your weight is in the $bmiStatus category for adults of your height.',
                style: const TextStyle(
                  fontSize: 20.0,
                  color: whiteFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                Provider.of<Data>(context).advice,
                style: const TextStyle(
                  fontSize: 20.0,
                  color: whiteFont,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
