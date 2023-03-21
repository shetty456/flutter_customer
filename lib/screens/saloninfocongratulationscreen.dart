import 'package:flutter/material.dart';
import 'package:partner/screens/tabsscreen.dart';

class SalonInfoCongratulationsScreen extends StatelessWidget {
  static const routeName = '/congats';
  const SalonInfoCongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            children: [
              Text(
                'Hooray, Congratulations!',
                style: Theme.of(context).textTheme.headline4,
              ),
              const SizedBox(
                height: 24.0,
              ),
              Text(
                'You Have successfully Added Salon Information',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(
                height: 24.0,
              ),
              SizedBox(
                height: 40.0,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacementNamed(TabsScreen.routeName);
                  },
                  child: const Text('Go To Homepage'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
