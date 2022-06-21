import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:fluttertraining/GoogleMapModule/location_decode.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

String googleAPiKey = "AIzaSyDt4NdceQbBpNM-6ufQdfYzPxd_BEDcOUQ";

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({Key? key}) : super(key: key);

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
  GoogleMapController? controller;
  Location location = Location();
  LocationData? locationData;

  ///Markers
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  ///Polyline
  Map<PolylineId, Polyline> polylines = <PolylineId, Polyline>{};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    location.onLocationChanged.listen((event) {
      print(event.longitude);
      print(event.latitude);
      print(event.heading);
      addMarker(
          markerID: "My Location", latLng: LatLng(event.latitude!, event.longitude!));
    });

    ///Address decode
    fetchLocationName(LatLng(28.4212, 70.2989));

    addMarker(markerID: "from", latLng: LatLng(28.4212, 70.2989));
    addMarker(
      markerID: "to",
      latLng: LatLng(30.1575, 71.5249),
    );
    createPolyline(
      polylineID: "poly",
      fromLoc: LatLng(28.4212, 70.2989),
      toLoc: LatLng(30.1575, 71.5249),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            initCurrentLocation();
          },
          child: Icon(Icons.my_location_rounded)),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polylines.values),
          onMapCreated: (controller) {
            this.controller = controller;
          },
          initialCameraPosition:
              const CameraPosition(target: LatLng(28.4212, 70.2989), zoom: 30),
          onTap: (location) {
            print(location);
            addMarker(
                markerID: "${location.latitude}",
                latLng: LatLng(location.latitude, location.longitude));
          },
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
        ),
      ),
    );
  }

  initCurrentLocation() async {
    PermissionStatus status = await location.requestPermission();
    if (status == PermissionStatus.granted) {
      locationData = await location.getLocation();
      if (locationData != null) {
        print(locationData!.longitude);
        print(locationData!.latitude);
        print(locationData!.heading);
        addMarker(
            markerID: "My Location",
            latLng: LatLng(locationData!.latitude!, locationData!.longitude!));
        moveToCameraLocation(
            latLng: LatLng(locationData!.latitude!, locationData!.longitude!));
      } else {
        print("not fetched");
      }
    }
  }

  moveToCameraLocation({required LatLng latLng}) {
    controller!.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(latLng.latitude, latLng.longitude), zoom: 30)));
  }

  addMarker({required String markerID, required LatLng latLng}) async {
    final MarkerId markerId = MarkerId(markerID);
    BitmapDescriptor image = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(48, 48)), "assets/test.PNG");

    final Marker marker = Marker(
        position: latLng,
        markerId: markerId,
        icon: image,

        // icon: BitmapDescriptor.defaultMarker,
        infoWindow:
            const InfoWindow(title: "Test", snippet: "this is testing"));
    setState(() {
      markers[markerId] = marker;
    });
    print("markers");
    print(markers);
  }

  createPolyline(
      {required String polylineID,
      required LatLng fromLoc,
      required LatLng toLoc}) async {
    try {
      print("result");
      final PolylineId polylineId = PolylineId(polylineID);

      PolylinePoints polylinePoints = PolylinePoints();
      print("result1");
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          googleAPiKey,
          PointLatLng(fromLoc.latitude, fromLoc.longitude),
          PointLatLng(toLoc.latitude, toLoc.longitude),
          travelMode: TravelMode.driving);
      print("result2");
      print(result.points);

      List<LatLng> pointsData = result.points
          .map((e) => LatLng(
                e.latitude,
                e.longitude,
              ))
          .toList();

      final Polyline polyline = Polyline(
          polylineId: polylineId,
          color: Colors.black,
          width: 4,
          points: pointsData
          // points: [fromLoc, toLoc]
          );
      setState(() {
        polylines[polylineId] = polyline;
      });
    } catch (e) {
      print("e");
      print(e);
    }
  }
// createPolyline(
//     {required String polylineID,
//     required LatLng fromLoc,
//     required LatLng toLoc}) async {
//   final PolylineId polylineId = PolylineId(polylineID);
//
//   final Polyline polyline = Polyline(
//       polylineId: polylineId,
//       color: Colors.black,
//       width: 4,
//       points: [fromLoc, toLoc]);
//   setState(() {
//     polylines[polylineId] = polyline;
//   });
// }
}
