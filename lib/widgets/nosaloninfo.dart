import 'package:flutter/material.dart';
import 'package:partner/screens/addsaloninfoscreen.dart';

class NoSalonInfo extends StatelessWidget {
  const NoSalonInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: ListView(
        children: [
          Text(
            'Setup Your Salon Details And Let Your Business Shine',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 32.0,
          ),
          Image.asset(
            'assets/images/nosalondata.png',
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 32.0,
          ),
          SizedBox(
            height: 40.0,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddSalonInfoScreen.routeName);
              },
              child: const Text('Get Started'),
            ),
          )
        ],
      ),
    );
  }
}
