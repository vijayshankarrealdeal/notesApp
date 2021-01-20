
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm:ss");

String getdate(String date)
{
  DateTime dateTime = dateFormat.parse(date);
  String string = dateFormat.format(dateTime);
  string = Jiffy(string).fromNow();
  return string;
}
String dateXX(String date)
{
  DateTime dateTime = dateFormat.parse(date);
  String string = dateFormat.format(dateTime);
  return string;
}