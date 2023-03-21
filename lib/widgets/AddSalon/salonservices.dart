import 'package:flutter/material.dart';
import './singleservice.dart';

class AddServices extends StatefulWidget {
  const AddServices({super.key});

  @override
  State<AddServices> createState() => _AddServicesState();
}

class _AddServicesState extends State<AddServices> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Salon Services',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        const SingleService(
          labelText: 'Hair Cut',
        ),
        const SingleService(
          labelText: 'Shaving',
        ),
        const SingleService(
          labelText: 'Head Massage',
        ),
      ],
    );
  }
}
