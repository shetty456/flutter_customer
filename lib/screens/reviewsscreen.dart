import 'package:flutter/material.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          children: [
            Text(
              'There is a lot to learn from all the reviews and a lot to rejoice.',
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32.0,
            ),
            Image.asset(
              'assets/images/review.png',
              fit: BoxFit.contain,
              height: 150,
            ),
            const SizedBox(
              height: 32.0,
            ),
            Text(
              'No Reviews',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
