import 'package:flutter/material.dart';
import 'package:partner/providers/salon.dart';
import 'package:partner/screens/saloninfocongratulationscreen.dart';
import 'package:provider/provider.dart';

import '../widgets/AddSalon/basicdetails.dart';
import '../widgets/AddSalon/salonaddress.dart';
import '../widgets/AddSalon/salontimings.dart';
import '../widgets/AddSalon/salonservices.dart';

class AddSalonInfoScreen extends StatefulWidget {
  static const routeName = '/addsaloninfo';
  const AddSalonInfoScreen({super.key});

  @override
  State<AddSalonInfoScreen> createState() => _AddSalonInfoScreenState();
}

class _AddSalonInfoScreenState extends State<AddSalonInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  int _index = 0;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final salonData = Provider.of<Salon>(context).salonData;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salon Info'),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Stepper(
                  currentStep: _index,
                  onStepCancel: () {
                    if (_index > 0) {
                      setState(() {
                        _index -= 1;
                      });
                    }
                  },
                  onStepContinue: () async {
                    if (_index < 3) {
                      setState(() {
                        _index += 1;
                      });
                    } else if (_index == 3) {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      _formKey.currentState!.save();
                      setState(() {
                        _isLoading = true;
                      });

                      try {
                        await Provider.of<Salon>(context, listen: false)
                            .addSalonInformation();
                        if (!mounted) return;
                        Navigator.of(context).pushReplacementNamed(
                            SalonInfoCongratulationsScreen.routeName);
                      } catch (error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            content:
                                Text('Something went wrong, Please try again'),
                          ),
                        );
                      }
                    }
                  },
                  onStepTapped: (int index) {
                    setState(() {
                      _index = index;
                    });
                  },
                  type: StepperType.horizontal,
                  steps: <Step>[
                    Step(
                      title: const Text('Step 1'),
                      content: BasicDetails(
                        salonData: salonData,
                      ),
                    ),
                    const Step(
                      title: Text('Step 2'),
                      content: SalonAddress(),
                    ),
                    const Step(
                      title: Text('Step 3'),
                      content: AddTimings(),
                    ),
                    const Step(
                      title: Text('Step 4'),
                      content: AddServices(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
