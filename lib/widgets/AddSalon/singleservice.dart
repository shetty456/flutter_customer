import 'package:flutter/material.dart';
import 'package:partner/providers/salon.dart';
import 'package:provider/provider.dart';

class SingleService extends StatefulWidget {
  const SingleService({
    super.key,
    required this.labelText,
  });
  final String labelText;

  @override
  State<SingleService> createState() => _SingleServiceState();
}

class _SingleServiceState extends State<SingleService> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() {
                  _isChecked = value!;
                });
              },
            ),
            Text(
              widget.labelText,
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        _isChecked
            ? Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Amount in Rupees',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        Provider.of<Salon>(context, listen: false)
                            .changeSalonData(
                          '${widget.labelText} Amount',
                          value!,
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field is Required';
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 16.0,
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Time Required (in Minutes)',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        Provider.of<Salon>(context, listen: false)
                            .changeSalonData(
                          '${widget.labelText} Time',
                          value!,
                        );
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'This Field is Required';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              )
            : Container(),
      ],
    );
  }
}
