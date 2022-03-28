import 'package:bmi_calculator/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/provider.dart';

class GenderButton extends StatelessWidget {
  const GenderButton({Key? key, required this.text, required this.icon})
      : super(key: key);

  final String text;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          (text == 'Male')
              ? Provider.of<Data>(context, listen: false).setAsMale()
              : Provider.of<Data>(context, listen: false).setAsFemale();
        },
        child: Container(
          height: 180.0,
          child: Stack(
            children: [
              Positioned(
                child: Icon(
                  Icons.check_circle,
                  size: 26.0,
                  color: (Provider.of<Data>(context).isMale == true &&
                              text == 'Male') ||
                          (Provider.of<Data>(context).isMale == false &&
                              text == 'Female')
                      ? Colors.redAccent
                      : Colors.grey[900],
                ),
                top: 10.0,
                right: 10.0,
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      icon,
                      color: whiteFont,
                      size: 75.0,
                    ),
                    const SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      text,
                      style: const TextStyle(
                        color: whiteFont,
                        fontSize: 22.0,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color: (Provider.of<Data>(context).isMale == true &&
                            text == 'Male') ||
                        (Provider.of<Data>(context).isMale == false &&
                            text == 'Female')
                    ? Colors.redAccent
                    : Colors.transparent,
                width: 2.0),
            color: greyColor,
            borderRadius: const BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}
