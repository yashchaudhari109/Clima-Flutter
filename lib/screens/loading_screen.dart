import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:clima/services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getlocation() async {
    try {
      somethingThatExpectsLessThan10(12);
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print(position);
    } catch (e) {
      print(e);
    }
  }

  void somethingThatExpectsLessThan10(int n) {
    if (n > 10) {
      throw 'n is greater than 10, n should always be less than 10 ';
    }
  }

  @override
  void initState() {
    super.initState();
    getlocation();
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivated");
  }

  void getData() async {
    http.Response response = await http.get(
        'https://samples.openweathermap.org/data/2.5/weather?lat=35&lon=139&appid=b6907d289e10d714a6e88b30761fae22');
    if (response.statusCode == 200) {
      String data = response.body;
      print(data);

      var longitude = jsonDecode(data)['coord']['lon'];
      print(longitude);
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
          },
          child: Text('Get me Location'),
        ),
      ),
    );
  }
}
