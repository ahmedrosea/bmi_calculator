import 'package:bmi_calculator/constants/constants.dart';
import 'package:bmi_calculator/pages/bmi_result.dart';
import 'package:bmi_calculator/widgets/data_section.dart';
import 'package:bmi_calculator/widgets/gender_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/provider.dart';
import 'bmi_history.dart';

// ignore: camel_case_types
class BMI_Home extends StatefulWidget {
  const BMI_Home({Key? key}) : super(key: key);

  @override
  State<BMI_Home> createState() => _BMI_HomeState();
}

// ignore: camel_case_types
class _BMI_HomeState extends State<BMI_Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageColor,
      appBar: AppBar(
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
          color: Colors.black,
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                'bmi calculator'.toUpperCase(),
                style: const TextStyle(
                  color: whiteFont,
                  fontSize: 32.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Gender',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.9),
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(
                        height: 8.0,
                      ),
                      Row(
                        children: const <Widget>[
                          GenderButton(text: 'Male', icon: Icons.male),
                          SizedBox(
                            width: 20.0,
                          ),
                          GenderButton(text: 'Female', icon: Icons.female),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8.0,
              ),
              DataSection(
                items: const ['kg', 'lb'],
                sectionTitle: 'Weight',
                bloc: Provider.of<Data>(context).weight,
                metrics: true,
              ),
              const SizedBox(
                height: 8.0,
              ),
              DataSection(
                items: const ['cm', 'm'],
                sectionTitle: 'height',
                bloc: Provider.of<Data>(context).height,
                metrics: true,
              ),
              const SizedBox(
                height: 8.0,
              ),
              DataSection(
                  items: const [],
                  sectionTitle: 'Age',
                  bloc: Provider.of<Data>(context).age,
                  metrics: false),
              const SizedBox(
                height: 12.0,
              ),
              MaterialButton(
                height: 55.0,
                minWidth: double.infinity,
                onPressed: () {
                  Provider.of<Data>(context, listen: false).calculateBMI();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Result()));
                  Provider.of<HistoryData>(context, listen: false)
                      .insert(Provider.of<Data>(context, listen: false).bmi);
                },
                color: Colors.redAccent,
                child: const Text(
                  'Calculate',
                  style: TextStyle(
                    color: whiteFont,
                    fontSize: 22.0,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
