import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class EventMap extends StatefulWidget {
  const EventMap({Key? key}) : super(key: key);

  @override
  _EventMapState createState() => _EventMapState();
}

class _EventMapState extends State<EventMap> {
  late GoogleMapController mapscontroller;
  List<Marker> _markers = [];
  bool showmaps = true;

  void initState() {
    super.initState();
    _markers.add(const Marker(
      markerId: MarkerId("myLoc"),
      position: LatLng(19.42571875724674, -99.1691701113251),
    ));

    _markers.add(const Marker(
      markerId: MarkerId("myLoc2"),
      position: LatLng(19.42013032645477, -99.15884727558037),
    ));

    _markers.add(const Marker(
      markerId: MarkerId("myLoc3"),
      position: LatLng(19.379688166809245, -99.17933417642996),
    ));

    _markers.add(const Marker(
      markerId: MarkerId("myLoc4"),
      position: LatLng(20.673884463859185, -103.36879114674295),
    ));

    if (_markers.isNotEmpty) {
      setState(() {
        showmaps = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: showmaps
          ? Container(
              height: 300,
              width: MediaQuery.of(context).size.width-40,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(12)),
              child: GoogleMap(
                markers: Set<Marker>.of(_markers),
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(19.42571875724674, -99.1691701113251),
                  zoom: 13,
                ),
                onMapCreated: (controller) {
                  setState(() {
                    mapscontroller = controller;
                  });
                },
                
              ),
            )
          : SizedBox(),
    );
  }
}
