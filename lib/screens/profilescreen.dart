import 'package:flutter/material.dart';
import 'package:partner/providers/auth.dart';
import 'package:partner/screens/firstscreen.dart';
import 'package:partner/screens/helpcenterscreen.dart';
import 'package:partner/screens/settingsscreen.dart';
import 'package:partner/screens/updateSalonInfo.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = '/profile';
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const SizedBox(
              height: 64,
            ),
            Stack(
              alignment: AlignmentDirectional.center,
              children: [
                CircleAvatar(
                  maxRadius: 80,
                  child: Text(
                    Provider.of<Auth>(context).username[0],
                    style: const TextStyle(
                      fontSize: 90,
                    ),
                  ),
                ),
                // Positioned(
                //   bottom: 5,
                //   right: 110,
                //   child: FloatingActionButton(
                //     onPressed: () {},
                //     child: const Icon(Icons.edit),
                //   ),
                // )
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Text(
              Provider.of<Auth>(context).username,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16.0,
            ),
            Card(
              child: Column(
                children: [
                  ProfileCard(
                    leadingIcon: const Icon(Icons.details),
                    titleText: 'Salon Details',
                    callbackFunction: () {
                      Navigator.of(context).pushNamed(
                        UpdateSalonInfoScreen.routeName,
                      );
                    },
                  ),
                  const Divider(
                    height: 1.5,
                  ),
                  ProfileCard(
                    leadingIcon: const Icon(Icons.settings),
                    titleText: 'Settings',
                    callbackFunction: () {
                      Navigator.of(context).pushNamed(SettingsScreen.routeName);
                    },
                  ),
                  const Divider(
                    height: 1.5,
                  ),
                  ProfileCard(
                    leadingIcon: const Icon(Icons.help_center),
                    titleText: 'Help Center',
                    callbackFunction: () {
                      Navigator.of(context)
                          .pushNamed(HelpCenterScreen.routeName);
                    },
                  ),
                  const Divider(
                    height: 1.5,
                  ),
                  // ProfileCard(
                  //   leadingIcon: const Icon(Icons.qr_code_2_rounded),
                  //   titleText: 'QR Code Generator',
                  //   callbackFunction: () {},
                  // ),
                  // ProfileCard(
                  //   leadingIcon: const Icon(Icons.currency_rupee),
                  //   titleText: 'Refer And Earn',
                  //   callbackFunction: () {},
                  // ),
                  ProfileCard(
                    leadingIcon: const Icon(Icons.logout),
                    titleText: 'Logout',
                    callbackFunction: ([bool mounted = true]) async {
                      await Provider.of<Auth>(context, listen: false).logout();
                      if (!mounted) return;
                      Navigator.of(context)
                          .pushReplacementNamed(FirstScreen.routeName);
                    },
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final String titleText;
  final Icon leadingIcon;
  final VoidCallback callbackFunction;
  const ProfileCard({
    Key? key,
    required this.titleText,
    required this.leadingIcon,
    required this.callbackFunction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callbackFunction,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            leading: leadingIcon,
            title: Text(
              titleText,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            trailing: const Icon(Icons.navigate_next),
          ),
        ),
      ),
    );
  }
}
