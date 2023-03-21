import 'package:flutter/material.dart';
import 'package:partner/providers/salon.dart';
import 'package:provider/provider.dart';

import '../widgets/nosaloninfo.dart';
import '../widgets/saloninfo.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Salon>(
      context,
      listen: false,
    ).getSalonInformation();
    return Scaffold(
      body: Consumer<Salon>(
        builder: (context, salon, _) => Container(
            child: salon.homepageLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : salon.salonInformation.isNotEmpty
                    ? const SalonInfo()
                    : const NoSalonInfo()
            // : FutureBuilder(
            //     future: salon.getSalonInformation(),
            //     builder: ((context, snapshot) =>
            //         snapshot.connectionState ==
            //                 ConnectionState.waiting
            //             ? const Center(
            //                 child: CircularProgressIndicator(),
            //               )
            //             : const NoSalonInfo()),
            //   ),
            ),
      ),
    );
  }
}
