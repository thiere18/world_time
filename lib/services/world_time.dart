import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {
  late String location;
  late String time;
  late String flag;
  late String url;
  late  bool? isDayTime;
  WorldTime({ required this.url, required this.location, required this.flag });

  Future<void> getTime() async {
    try {
      Response res =
          await get(Uri.parse('http://worldtimeapi.org/api/timezone/$url'));
      Map data = jsonDecode(res.body);
      String dateTime = data['datetime'];
      String offset = data['utc_offset'].substring(1, 3);

      //   print(dateTime);
      print(offset);
      // print(data);
      // convert to datetime
      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));
      isDayTime=now.hour > 6 && now.hour < 20 ?true : false;
      time = DateFormat.jm().format(now);
    
    } catch (e) {
      print("could not get the time");
    }
  }
}
