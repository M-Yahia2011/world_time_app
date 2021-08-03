import 'package:flutter/material.dart';
import 'package:world_time_app/services/world_time.dart';

class ChooseLocation extends StatefulWidget {
   static const routeName = '/choose-location';
  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<WorldTime> locations = [
    WorldTime(location: 'Cairo', flagIcon: 'egypt.png', url: 'Africa/Cairo'),
    WorldTime(location: 'Tokyo', flagIcon: 'japan.png', url: 'Asia/Tokyo1'),
    WorldTime(
        location: 'kuala lumpur',
        flagIcon: 'malaysia.png',
        url: 'Asia/Kuala_Lumpur'),
  ];
  
  void chooseLocation(index) async{
    WorldTime chosedLoc = locations[index]; //pointer not a new instance
    await chosedLoc.getTime();
    Navigator.pop(context, {
      'location': chosedLoc.location,
      'flag': chosedLoc.flagIcon,
      'time': chosedLoc.time,
      'isDayTime': chosedLoc.isDayTime
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text("Choose Your Location"),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        itemCount: locations.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 4),
            //padding: EdgeInsets.fromLTRB(4, 1, 4, 0),
            child: Card(
              child: ListTile(
                onTap: () => {
                  chooseLocation(index)
                },
                title: Text(locations[index].location),
                leading: CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/${locations[index].flagIcon}'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
