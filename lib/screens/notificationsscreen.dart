import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: ListView(
          children: [
            Text(
              'Know all the essential things necessary for you.',
              style: Theme.of(context).textTheme.subtitle1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 32.0,
            ),
            Image.asset(
              'assets/images/notification.png',
              fit: BoxFit.contain,
              height: 150,
            ),
            const SizedBox(
              height: 32.0,
            ),
            Text(
              'No Notifications',
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
