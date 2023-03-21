import 'package:flutter/material.dart';
import 'package:partner/widgets/UpdateSalon/updatebasicdetails.dart';
import 'package:partner/widgets/UpdateSalon/updatesalonaddress.dart';
import 'package:partner/widgets/UpdateSalon/updatesalonservices.dart';
import 'package:partner/widgets/UpdateSalon/updatesalontimings.dart';

class UpdateSalonInfoScreen extends StatefulWidget {
  static const routeName = '/updateSalonInfo';
  const UpdateSalonInfoScreen({super.key});

  @override
  State<UpdateSalonInfoScreen> createState() => _UpdateSalonInfoScreenState();
}

class _UpdateSalonInfoScreenState extends State<UpdateSalonInfoScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Salon Details'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(
              text: 'Basic',
            ),
            Tab(
              text: 'Address',
            ),
            Tab(
              text: 'Timing',
            ),
            Tab(
              text: 'Services',
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(32.0),
        child: TabBarView(
          controller: _tabController,
          children: const <Widget>[
            Center(
              child: UpdateBasicDetails(),
            ),
            Center(
              child: UpdateSalonAddress(),
            ),
            Center(
              child: UpdateAddTimings(),
            ),
            Center(
              child: UpdateAddServices(),
            ),
          ],
        ),
      ),
    );
  }
}
