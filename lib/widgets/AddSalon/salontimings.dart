import 'package:flutter/material.dart';
import './singletiming.dart';

class AddTimings extends StatelessWidget {
  const AddTimings({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Salon Timings',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        const SingleTiming(
          lableText: 'Sunday',
        ),
        const SingleTiming(
          lableText: 'Monday',
        ),
        const SingleTiming(
          lableText: 'Tuesday',
        ),
        const SingleTiming(
          lableText: 'Wednesday',
        ),
        const SingleTiming(
          lableText: 'Thursday',
        ),
        const SingleTiming(
          lableText: 'Friday',
        ),
        const SingleTiming(
          lableText: 'Saturday',
        ),
      ],
    );
  }
}
