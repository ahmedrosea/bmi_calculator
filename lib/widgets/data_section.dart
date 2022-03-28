import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bmi_calculator/state_management/provider.dart';

// ignore: must_be_immutable
class DataSection extends StatelessWidget {
  DataSection(
      {Key? key,
      required this.items,
      required this.sectionTitle,
      required this.bloc,
      required this.metrics})
      : super(key: key);

  final List<String> items;
  final String sectionTitle;
  int value = 99;
  final dynamic bloc;
  final bool metrics;
  bool metricChanged = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: Container(
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          if (bloc ==
                              Provider.of<Data>(context, listen: false)
                                  .weight) {
                            Provider.of<Data>(context, listen: false)
                                .removeWeight();
                          } else if (bloc ==
                              Provider.of<Data>(context, listen: false)
                                  .height) {
                            Provider.of<Data>(context, listen: false)
                                .removeHeight();
                          } else {
                            Provider.of<Data>(context, listen: false)
                                .removeAge();
                          }
                        },
                        icon: const Icon(
                          Icons.remove_circle,
                          size: 22.0,
                        )),
                    Text(
                      bloc.toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 26.0,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (bloc ==
                              Provider.of<Data>(context, listen: false)
                                  .weight) {
                            Provider.of<Data>(context, listen: false)
                                .addWeight();
                          } else if (bloc ==
                              Provider.of<Data>(context, listen: false)
                                  .height) {
                            Provider.of<Data>(context, listen: false)
                                .addHeight();
                          } else {
                            Provider.of<Data>(context, listen: false).addAge();
                          }
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          size: 22.0,
                        )),
                  ],
                ),
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6.0)),
                  color: Colors.white,
                ),
              ),
            ),
            metrics == false
                ? const SizedBox()
                : const SizedBox(
                    width: 10.0,
                  ),
            metrics == false
                ? const SizedBox()
                : Expanded(
                    flex: 1,
                    child: Container(
                      height: 50.0,
                      child: Center(
                        child: DropdownButton(
                          dropdownColor: Colors.white,
                          icon: const Icon(Icons.arrow_drop_down),
                          iconSize: 42.0,
                          value: sectionTitle == 'Weight'
                              ? Provider.of<Data>(context).weightMetric
                              : Provider.of<Data>(context).heightMetric,
                          focusColor: Colors.white,
                          underline: const SizedBox(),
                          items: items
                              .map((String items) => DropdownMenuItem(
                                    value: items,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Text(items),
                                    ),
                                  ))
                              .toList(),
                          onChanged: (value) => sectionTitle == 'Weight'
                              ? Provider.of<Data>(context, listen: false)
                                  .setWeightMetric(value.toString())
                              : Provider.of<Data>(context, listen: false)
                                  .setHeightMetric(value.toString()),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            letterSpacing: 1.3,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ))
          ],
        ),
      ],
    );
  }
}
