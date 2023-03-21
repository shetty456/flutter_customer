import 'package:flutter/material.dart';
import 'package:partner/providers/salon.dart';
import 'package:provider/provider.dart';
import './updatesingleservice.dart';

class UpdateAddServices extends StatefulWidget {
  const UpdateAddServices({super.key});

  @override
  State<UpdateAddServices> createState() => _UpdateAddServicesState();
}

class _UpdateAddServicesState extends State<UpdateAddServices> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    bool loading = Provider.of<Salon>(context).loading;
    return loading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  'Salon Services',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 32,
                ),
                const UpdateSingleService(
                  labelText: 'Hair Cut',
                ),
                const UpdateSingleService(
                  labelText: 'Shaving',
                ),
                const UpdateSingleService(
                  labelText: 'Head Massage',
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      Provider.of<Salon>(
                        context,
                        listen: false,
                      ).updateSalonServiceDetails();
                    },
                    child: const Text('Update'),
                  ),
                )
              ],
            ),
          );
  }
}
