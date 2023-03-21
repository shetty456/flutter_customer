import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:partner/providers/location.dart';
import 'package:partner/providers/salon.dart';
import 'package:provider/provider.dart';

class UpdateSalonAddress extends StatefulWidget {
  const UpdateSalonAddress({super.key});

  @override
  State<UpdateSalonAddress> createState() => _UpdateSalonAddressState();
}

class _UpdateSalonAddressState extends State<UpdateSalonAddress> {
  final _formKey = GlobalKey<FormState>();
  final landmarkTextController = TextEditingController();
  final districtTextController = TextEditingController();
  final pincodeTextController = TextEditingController();
  final stateTextController = TextEditingController();
  final areaTextController = TextEditingController();
  final cityTextController = TextEditingController();
  final latitudeTextController = TextEditingController();
  final longitudeTextController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    landmarkTextController.dispose();
    districtTextController.dispose();
    pincodeTextController.dispose();
    stateTextController.dispose();
    areaTextController.dispose();
    cityTextController.dispose();
    latitudeTextController.dispose();
    longitudeTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Placemark address =
        Provider.of<LocationState>(context).currentAddress;
    final Position currentPosition =
        Provider.of<LocationState>(context).currentPosition;
    landmarkTextController.text =
        address.thoroughfare != null ? address.thoroughfare as String : "";
    districtTextController.text =
        address.locality != null ? address.locality as String : "";
    pincodeTextController.text =
        address.postalCode != null ? address.postalCode as String : "";
    stateTextController.text = address.administrativeArea != null
        ? address.administrativeArea as String
        : "";
    areaTextController.text =
        address.subLocality != null ? address.subLocality as String : "";
    cityTextController.text =
        address.subLocality != null ? address.subLocality as String : "";
    latitudeTextController.text = currentPosition.latitude.toString();
    longitudeTextController.text = currentPosition.longitude.toString();

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
                  'Salon Address',
                  style: Theme.of(context).textTheme.headline6,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 32,
                ),
                ElevatedButton(
                  onPressed: () {
                    Provider.of<LocationState>(
                      context,
                      listen: false,
                    ).getCurrentLocation();
                  },
                  child: const Text('Use current location'),
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: areaTextController,
                  decoration: const InputDecoration(
                    labelText: 'Area',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    Provider.of<Salon>(
                      context,
                      listen: false,
                    ).changeSalonAddressData(
                      'streetAddress',
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
                TextFormField(
                  controller: landmarkTextController,
                  decoration: const InputDecoration(
                    labelText: 'Landmark',
                    border: OutlineInputBorder(),
                  ),
                  onSaved: (value) {
                    Provider.of<Salon>(
                      context,
                      listen: false,
                    ).changeSalonAddressData(
                      'landmark',
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
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: cityTextController,
                        decoration: const InputDecoration(
                          labelText: 'City / Village',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          Provider.of<Salon>(
                            context,
                            listen: false,
                          ).changeSalonAddressData(
                            'city',
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
                        controller: pincodeTextController,
                        decoration: const InputDecoration(
                          labelText: 'Pincode',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          Provider.of<Salon>(
                            context,
                            listen: false,
                          ).changeSalonAddressData(
                            'pincode',
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
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: districtTextController,
                        decoration: const InputDecoration(
                          labelText: 'District',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          Provider.of<Salon>(
                            context,
                            listen: false,
                          ).changeSalonAddressData(
                            'district',
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
                        controller: stateTextController,
                        decoration: const InputDecoration(
                          labelText: 'State',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          Provider.of<Salon>(
                            context,
                            listen: false,
                          ).changeSalonAddressData(
                            'state',
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
                ),
                const SizedBox(
                  height: 16.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: latitudeTextController,
                        decoration: const InputDecoration(
                          labelText: 'Latitude',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          Provider.of<Salon>(
                            context,
                            listen: false,
                          ).changeSalonAddressData(
                            'latitude',
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
                        controller: longitudeTextController,
                        decoration: const InputDecoration(
                          labelText: 'Longitude',
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (value) {
                          Provider.of<Salon>(
                            context,
                            listen: false,
                          ).changeSalonAddressData(
                            'longitude',
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
                      ).updateSalonAddressDetails();
                    },
                    child: const Text('Update'),
                  ),
                )
              ],
            ),
          );
  }
}
