import 'package:flutter/material.dart';
import 'package:partner/providers/salon.dart';
import 'package:provider/provider.dart';

class UpdateBasicDetails extends StatefulWidget {
  const UpdateBasicDetails({super.key});

  @override
  State<UpdateBasicDetails> createState() => _UpdateBasicDetailsState();
}

class _UpdateBasicDetailsState extends State<UpdateBasicDetails> {
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
                    Provider.of<Salon>(context, listen: false)
                        .changeSalonBasicData(
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
                      ).updateSalonBasicDetials();
                    },
                    child: const Text('Update'),
                  ),
                )
              ],
            ),
          );
  }
}
