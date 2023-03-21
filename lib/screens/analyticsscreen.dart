import 'package:flutter/material.dart';

class AnalyticsScreen extends StatelessWidget {
  const AnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          children: [
            Text(
              'Learn, Grow and Enhance Thyself.',
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32.0,
            ),
            Image.asset(
              'assets/images/analytics.png',
              height: 150,
            ),
            const SizedBox(
              height: 32.0,
            ),
            Text(
              'No Analyitcs Data',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
          ],
        ),
      ),
    );
  }
}
