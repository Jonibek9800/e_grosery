import 'package:el_grocer/domain/blocs/themes/themes_model.dart';
import 'package:flutter/material.dart';

class LocationWidget extends StatelessWidget {
  const LocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Location'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Card(
            child: Column(
              children: [
                const Text("Select Your Delivery Location"),
                const Divider(
                  height: 1,
                ),
                TextButton(
                    onPressed: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.location_searching_sharp,
                          color: ThemeColor.greenColor,
                        ),
                        Text(
                          "Use my current location",
                          style: TextStyle(color: ThemeColor.greenColor),
                        ),
                      ],
                    )),
                const Row(children: [Divider(height: 1, endIndent: 5,), Text("or"), Divider(height: 1, indent:  5,)],)

              ],
            ),
          )
        ],
      ),
    );
  }
}
