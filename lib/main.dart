import 'package:bmi_calculator/pages/bmi_home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state_management/provider.dart';

void main() => runApp(MultiProvider(
      child: const BMI_Calculator(),
      providers: [
        ChangeNotifierProvider(create: (_) => Data()),
        ChangeNotifierProvider(create: (_) => HistoryData())
      ],
    ));

// ignore: camel_case_types
class BMI_Calculator extends StatefulWidget {
  const BMI_Calculator({Key? key}) : super(key: key);

  @override
  State<BMI_Calculator> createState() => _BMI_CalculatorState();
}

// ignore: camel_case_types
class _BMI_CalculatorState extends State<BMI_Calculator> {
  @override
  void initState() {
    Provider.of<HistoryData>(context, listen: false).databaseCreation();
    Provider.of<HistoryData>(context, listen: false).selectData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BMI_Home(),
    );
  }
}
