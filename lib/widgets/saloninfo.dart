import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:partner/providers/salon.dart';
import 'package:provider/provider.dart';
import 'package:colorize_text_avatar/colorize_text_avatar.dart';

class SalonInfo extends StatelessWidget {
  const SalonInfo({super.key});
  @override
  Widget build(BuildContext context) {
    List bookings = Provider.of<Salon>(context).bookings;
    bookings.sort((a, b) => a['selectedTiming'].compareTo(b['selectedTiming']));
    return bookings.isEmpty
        ? ListView(children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Text(
                'What A Fine Day It Is. And Of Course, There Is A Lot To Be Done.',
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center,
              ),
            ),
            Image.asset(
              'assets/images/home.png',
              fit: BoxFit.contain,
              height: 150,
            ),
            const SizedBox(
              height: 50.0,
            ),
            Text(
              'Bookings For The Day',
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 16,
            ),
            const Center(
              child: Text('Sorry. No Bookings For The day'),
            )
          ])
        : Card(
            elevation: 0,
            child: ListView.separated(
              itemCount: bookings.length,
              itemBuilder: ((context, index) => BookingCard(
                    title: bookings[index]['name'],
                    subtitle: bookings[index]['selectedTiming'],
                    data: bookings[index],
                  )),
              separatorBuilder: (BuildContext context, int index) {
                return const Divider(
                  height: 2.0,
                );
              },
            ),
          );
  }
}

class BookingCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String title;
  final String subtitle;
  const BookingCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _dialogBuilder(context, data);
      },
      child: Card(
        elevation: 0,
        child: ListTile(
          leading: TextAvatar(
            numberLetters: 2,
            text: title,
          ),
          title: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          subtitle: Text(subtitle),
          trailing: const Icon(Icons.navigate_next),
        ),
      ),
    );
  }
}

Future<void> _dialogBuilder(
  BuildContext context,
  Map<String, dynamic> data,
) {
  if (kDebugMode) {
    print(data);
  }
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      final services = data['services'];
      return AlertDialog(
        title: Text(data['name']),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Timing: ${data['selectedTiming']}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Services',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 100,
              width: 300,
              child: ListView.builder(
                itemBuilder: ((context, index) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 4.0),
                      child: Text('${index + 1}. ${data['services'][index]}'),
                    )),
                itemCount: services.length,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Total Service Time: ${data['serviceTime']} Minutes',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Total Service Amount: ${data['serviceAmount']} Rupees',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Cancel'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.labelLarge,
            ),
            child: const Text('Okay'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
