import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' as spinKit;

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  void setupWorldTime() async {
    WorldTime instance = WorldTime(
        location: 'Cairo', flagIcon: 'egypt.png', url: 'africa/cairo');
    await instance.getTime();
    //we wait here because getTime is async fn
    //and the assign below will return without await here
    // but we need getTime to return Future (promise like in js)
    Navigator.pushReplacementNamed(context, '/home', arguments: {
      'location': instance.location,
      'flag': instance.flagIcon,
      'time': instance.time,
      'isDayTime': instance.isDayTime
    }); // navigate to home after loading
  }

  @override
  void initState() {
    super.initState();
    setupWorldTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: spinKit.SpinKitFadingCircle(
        color: Colors.blue,
        size: 50,
      ),
    ));
  }
}
