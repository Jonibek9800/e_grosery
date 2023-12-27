import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class ConfirmLocationWidget extends StatelessWidget {
  const ConfirmLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Confirm location"), centerTitle: true,),
      body: Column(
        children: [
          Expanded(child: Stack(children: [
            YandexMap(
            onMapCreated: (YandexMapController controller) {
              controller.moveCamera(
                  CameraUpdate.newCameraPosition(const CameraPosition(
                      target: Point(latitude: 38.53575, longitude: 68.77905), zoom: 12)),
                  animation: const MapAnimation(
                      type: MapAnimationType.smooth, duration: 1));
            },
          ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FloatingActionButton.small(
                    onPressed: () {},
                    child: const Icon(Icons.add),
                  ),
                  FloatingActionButton.small(
                    onPressed: () {},
                    child: const Icon(Icons.remove),
                  )
                ],
              ),
            ),
          ])),
        Text("Hello")
        ],
      ),

    );
  }
}
