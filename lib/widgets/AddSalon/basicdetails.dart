import 'package:flutter/material.dart';
import 'package:partner/providers/salon.dart';
import 'package:provider/provider.dart';

class BasicDetails extends StatelessWidget {
  final Map<String, dynamic> salonData;
  const BasicDetails({
    super.key,
    required this.salonData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'Basic Salon Details',
          style: Theme.of(context).textTheme.headline6,
          textAlign: TextAlign.center,
        ),
        const SizedBox(
          height: 32,
        ),
        TextFormField(
          decoration: const InputDecoration(
            labelText: 'Shop Name',
            border: OutlineInputBorder(),
          ),
          onSaved: (value) {
            Provider.of<Salon>(context, listen: false).changeSalonData(
              'shopName',
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
        const SizedBox(
          height: 16.0,
        ),
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.grey,
              ),
              height: 210,
            ),
            const Center(
              child: Text('Upload An Image'),
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {},
                child: const Icon(Icons.add),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 16.0,
        ),
      ],
    );
  }
}
