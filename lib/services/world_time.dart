import 'package:http/http.dart' as http;
import 'dart:convert'; //convert string repr of json
import 'package:intl/intl.dart' as intl;

class WorldTime {
  String location; //UI Text location
  String? time;
  String flagIcon;
  String url;
  bool? isDayTime;
  WorldTime(
      {required this.location, required this.flagIcon, required this.url});

  Future<void> getTime() async {
    try {
      http.Response response = await http
          .get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);
      String datetime = data['datetime'];
      String offsetHour = data['utc_offset'].substring(1, 3);
      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offsetHour)));
      isDayTime = now.hour < 12 ? true : false;
      // set the time property
      time = intl.DateFormat.jm().format(now); // 6:25 PM

    } catch (e) {
      print('<<<<<{{Api Error}}>>>> $time $e');
      time = '00:00 AM';
    }
  }
}
