import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:partner/providers/salon.dart';
import 'package:provider/provider.dart';

import '../../providers/location.dart';

class SalonAddress extends StatefulWidget {
  const SalonAddress({super.key});

  @override
  State<SalonAddress> createState() => _SalonAddressState();
}

class _SalonAddressState extends State<SalonAddress> {
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
    landmarkTextController.text = address.thoroughfare!;
    districtTextController.text = address.locality!;
    pincodeTextController.text = address.postalCode!;
    stateTextController.text = address.administrativeArea!;
    areaTextController.text = address.subLocality!;
    cityTextController.text = address.subLocality!;
    latitudeTextController.text = currentPosition.latitude.toString();
    longitudeTextController.text = currentPosition.longitude.toString();
    return Column(
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
            Provider.of<Salon>(context, listen: false)
                .changeSalonData('streetAddress', value!);
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
            Provider.of<Salon>(context, listen: false)
                .changeSalonData('landmark', value!);
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
                  Provider.of<Salon>(context, listen: false)
                      .changeSalonData('city', value!);
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
                  Provider.of<Salon>(context, listen: false)
                      .changeSalonData('pincode', value!);
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
                  Provider.of<Salon>(context, listen: false)
                      .changeSalonData('district', value!);
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
                  Provider.of<Salon>(context, listen: false)
                      .changeSalonData('state', value!);
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
                  Provider.of<Salon>(context, listen: false)
                      .changeSalonData('latitude', value!);
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
                  Provider.of<Salon>(context, listen: false)
                      .changeSalonData('longitude', value!);
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
      ],
    );
  }
}
