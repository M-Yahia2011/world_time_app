import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data = {}; //initial data for some place
  @override
  Widget build(BuildContext context) {
    //we passed the data in the build so it is ready to be used after loading
    //when we remove the loading from the stack

    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    // ? prevent overwriting after choosing a different location
    String bgImage = data['isDayTime'] ? 'day.jpg' : 'night.jpg';
    return Scaffold(
        body: SafeArea(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/$bgImage'),
                fit: BoxFit.cover // cover the entire screen
                )),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                label: Text(
                  "Edit Location",
                  style: TextStyle(color: Colors.white),
                ),
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.white,
                ),
                onPressed: () async {
                  dynamic result =
                      await Navigator.pushNamed(context, '/location');

                  setState(() {
                    data = result;
                  });
                },
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'],
                    style: TextStyle(
                        fontSize: 20, letterSpacing: 2, color: Colors.white),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                data['time'],
                style: TextStyle(fontSize: 65, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
