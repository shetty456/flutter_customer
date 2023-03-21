import 'package:flutter/material.dart';

// stores ExpansionPanel state information
class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> _data = [
  Item(
    expandedValue:
        'Provide a link to change the Password or change the password in this section itself',
    headerValue: 'How to update my phone number',
  ),
  Item(
    expandedValue:
        'Provide a link to change the Phone number or change the phonenumber in this section itself',
    headerValue: 'How to change the password',
  ),
  Item(
    expandedValue:
        'Provide a link to change the Phone number or change the phonenumber in this section itself',
    headerValue: 'How to use the site effectively',
  ),
];

class HelpCenterScreen extends StatefulWidget {
  static const routeName = '/helpcenter';
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            elevation: 1,
            expansionCallback: (panelIndex, isExpanded) => setState(() {
              _data[panelIndex].isExpanded = !isExpanded;
            }),
            children: _data
                .map<ExpansionPanel>(
                  (Item item) => ExpansionPanel(
                    headerBuilder: ((context, isExpanded) => ListTile(
                          title: Text(item.headerValue),
                        )),
                    body: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16.0,
                        horizontal: 0.0,
                      ),
                      child: ListTile(
                        title: Text(item.expandedValue),
                      ),
                    ),
                    isExpanded: item.isExpanded,
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
