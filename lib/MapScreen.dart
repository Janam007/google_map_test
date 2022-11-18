import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static const _initialCameraPosition = CameraPosition(
      target: LatLng(27.6667, 85.3167), zoom: 15);
  Completer<GoogleMapController>_mapController = Completer();
  Marker _markerOrigin = Marker(markerId: MarkerId('default'));
  Marker _markerDestination = Marker(markerId: MarkerId('default'));
  Marker _markerDefault = Marker(markerId: MarkerId('default'));
  Set<Polygon> _polygone = HashSet<Polygon>();
  List<LatLng>points = [
    LatLng(27.6667, 85.3167),
    //LatLng(27.712028,85.299403),
    //LatLng(27.718432,85.317396),
    LatLng(27.6667, 85.3167),
  ];
  //final GoogleMapController _googleMapController = GoogleMapController();


  @override
  void dispose() {
    _mapController.complete();
    super.dispose();
  }

  @override void initState() {
    super.initState();
    _polygone.add(
      Polygon(polygonId:PolygonId('1') ,points: points,
        fillColor: Colors.red,
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.deepPurple,
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          height: 800,
          child: GoogleMap(
            zoomGesturesEnabled: true,
            mapType: MapType.normal,
            markers: {
              if(_markerOrigin != null)_markerOrigin,
              if(_markerDestination != null)_markerDestination,
            },
            onLongPress: _addMarkerOrigin,
            polygons: _polygone,
            //marker},
            //myLocationEnabled: true,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _mapController.complete(controller);
            },
          )
      ),);
  }

  void _addMarkerOrigin(LatLng pos) {
    if(_markerOrigin.markerId==_markerDefault.markerId&&_markerDestination.markerId==_markerDefault.markerId){
      setState(() {
        _markerOrigin = Marker(
          markerId: const MarkerId('origin'),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        points.add(_markerOrigin.position);
      });
    }else {
      setState(() {
        _markerDestination = Marker(
          markerId: const MarkerId('Destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
        points.add(_markerDestination.position);
      });


    }

  }
}
