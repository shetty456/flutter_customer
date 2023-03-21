import 'package:flutter/material.dart';
import 'package:partner/providers/salon.dart';
import 'package:provider/provider.dart';
import './updatesingletiming.dart';

class UpdateAddTimings extends StatefulWidget {
  const UpdateAddTimings({super.key});

  @override
  State<UpdateAddTimings> createState() => _UpdateAddTimingsState();
}

class _UpdateAddTimingsState extends State<UpdateAddTimings> {
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
                  'Salon Timings',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 32,
                ),
                const UpdateSingleTiming(
                  lableText: 'Sunday',
                ),
                const UpdateSingleTiming(
                  lableText: 'Monday',
                ),
                const UpdateSingleTiming(
                  lableText: 'Tuesday',
                ),
                const UpdateSingleTiming(
                  lableText: 'Wednesday',
                ),
                const UpdateSingleTiming(
                  lableText: 'Thursday',
                ),
                const UpdateSingleTiming(
                  lableText: 'Friday',
                ),
                const UpdateSingleTiming(
                  lableText: 'Saturday',
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  height: 40.0,
                  child: ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.save();
                      Provider.of<Salon>(
                        context,
                        listen: false,
                      ).updateSalonTimingDetails();
                    },
                    child: const Text('Update'),
                  ),
                )
              ],
            ),
          );
  }
}
