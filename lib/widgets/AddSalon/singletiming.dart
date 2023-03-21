import 'package:flutter/material.dart';
import 'package:partner/providers/salon.dart';
import 'package:provider/provider.dart';

const List<String> timings = [
  "12:00 AM",
  "12:30 AM",
  "1:00 AM",
  "1:30 AM",
  "2:00 AM",
  "2:30 AM",
  "3:00 AM",
  "3:30 AM",
  "4:00 AM",
  "4:30 AM",
  "5:00 AM",
  "5:30 AM",
  "6:00 AM",
  "6:30 AM",
  "7:00 AM",
  "7:30 AM",
  "8:00 AM",
  "8:30 AM",
  "9:00 AM",
  "9:30 AM",
  "10:00 AM",
  "10:30 AM",
  "11:00 AM",
  "11:30 AM",
  "12:00 PM",
  "12:30 PM",
  "1:00 PM",
  "1:30 PM",
  "2:00 PM",
  "2:30 PM",
  "3:00 PM",
  "3:30 PM",
  "4:00 PM",
  "4:30 PM",
  "5:00 PM",
  "5:30 PM",
  "6:00 PM",
  "6:30 PM",
  "7:00 PM",
  "7:30 PM",
  "8:00 PM",
  "8:30 PM",
  "9:00 PM",
  "9:30 PM",
  "10:00 PM",
  "10:30 PM",
  "11:00 PM",
  "11:30 PM",
];

class SingleTiming extends StatefulWidget {
  const SingleTiming({
    super.key,
    required this.lableText,
  });
  final String lableText;

  @override
  State<SingleTiming> createState() => _SingleTimingState();
}

class _SingleTimingState extends State<SingleTiming> {
  bool _switchon = false;
  String openingValue = timings.first;
  String closingValue = timings.first;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 90,
              child: Text(
                widget.lableText,
                style: Theme.of(context).textTheme.subtitle1,
              ),
            ),
            Switch(
                value: _switchon,
                onChanged: (bool value) {
                  setState(() {
                    _switchon = value;
                  });
                }),
            Text(
              _switchon ? 'Open' : 'Closed',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        const SizedBox(
          height: 8.0,
        ),
        _switchon
            ? Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Opening Time',
                          border: OutlineInputBorder(),
                        ),
                        value: openingValue,
                        onSaved: (value) {
                          Provider.of<Salon>(context, listen: false)
                              .changeSalonData(
                            '${widget.lableText} opening time',
                            value!,
                          );
                        },
                        items: timings
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) {
                          openingValue = value!;
                        }),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          labelText: 'Closing Time',
                          border: OutlineInputBorder(),
                        ),
                        value: closingValue,
                        onSaved: (value) {
                          Provider.of<Salon>(context, listen: false)
                              .changeSalonData(
                            '${widget.lableText} closing time',
                            value!,
                          );
                        },
                        items: timings
                            .map<DropdownMenuItem<String>>(
                              (String value) => DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) {
                          closingValue = value!;
                        }),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
