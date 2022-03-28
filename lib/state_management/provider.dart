import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart' as sql;

class Data with ChangeNotifier {
  int weight = 80;
  num height = 170;
  int age = 18;
  bool isMale = true;
  String weightMetric = 'kg';
  String heightMetric = 'cm';

  late double bmi;
  late String bmiStatus;
  late String advice;

  void addWeight() {
    weight++;
    notifyListeners();
  }

  void removeWeight() {
    weight--;
    notifyListeners();
  }

  void addHeight() {
    heightMetric == 'cm' ? height++ : height += 0.01;
    notifyListeners();
  }

  void removeHeight() {
    heightMetric == 'cm' ? height-- : height -= 0.01;
    notifyListeners();
  }

  void addAge() {
    age >= 65 ? age : age++;
    notifyListeners();
  }

  void removeAge() {
    age <= 18 ? age : age--;
    notifyListeners();
  }

  void setAsMale() {
    isMale = true;
    notifyListeners();
  }

  void setAsFemale() {
    isMale = false;
    notifyListeners();
  }

  void setWeightMetric(String met) {
    if (weightMetric != met) {
      weightMetric = met;
      if (met == 'kg') {
        weight = (weight * 0.45359237).toInt();
      } else {
        weight = weight ~/ 0.45359237;
      }
      notifyListeners();
    }
  }

  void setHeightMetric(String met) {
    if (heightMetric != met) {
      heightMetric = met;
      if (met == 'm') {
        height = (height / 100);
      } else {
        height = (height * 100).toInt();
      }
      notifyListeners();
    }
  }

  void calculateBMI() {
    bmi = double.parse(((weightMetric == 'kg' ? weight : weight * 0.45359237) /
            pow((heightMetric == 'cm' ? height / 100 : height), 2))
        .toStringAsFixed(2));
    if (bmi > 18.5 && bmi < 24.9) {
      bmiStatus = 'Normal';
      advice =
          'Maintaining a healthy weight may reduce the risk of chronic diseases associated with overweight and underweight.';
    } else if (bmi > 25 && bmi < 30) {
      bmiStatus = 'Overweight';
      advice =
          'Change your life habits, do more workouts and have a special diets.';
    } else if (bmi < 18.5) {
      bmiStatus = 'Underweight';
      advice = 'have a more healthy life habits, go to gym and get a diet.';
    } else {
      bmiStatus = 'Obese';
      advice = 'You must have a healthy life and do workout';
    }
    notifyListeners();
  }
}

class HistoryData with ChangeNotifier {
  late List<Map> data;
  Future<sql.Database> databaseCreation() async {
    return await sql.openDatabase('HISTORY.db', version: 1,
        onCreate: (db, version) async {
      await db
          .execute('CREATE TABLE HISTORY (id INTEGER PRIMARY KEY, bmi REAL)');
    });
  }

  void insert(double bmi) async {
    final sql.Database database = await databaseCreation();
    await database.rawInsert('INSERT INTO HISTORY(bmi) VALUES($bmi)');
    notifyListeners();
  }

  Future<List<Map>> selectData() async {
    final sql.Database database = await databaseCreation();
    final List<Map> history = await database.rawQuery('SELECT * FROM HISTORY');
    data = history;
    notifyListeners();
    return history;
  }
}
