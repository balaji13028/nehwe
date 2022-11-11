import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nehwe/models/subscriptions_model.dart';
import '../constants/text_const.dart';

Future subscriptionPlans() async {
  final response =
      await http.get(Uri.parse('${Consttext.ipAddress}/appgetusersublkp'));

  List<dynamic> maps = json.decode(response.body);

  //print('concepts list is ${maps.toString()}');

  List<SubscriptionData> panlist = List.generate(maps.length, (index) {
    return SubscriptionData(
      subId: (maps[index]['subid']).toString(),
      planName: (maps[index]['planname']).toString(),
      planDesc: (maps[index]['description']).toString(),
      planAmount: (maps[index]['amount']).toString(),
      planDuration: maps[index]['duration'].toString(),
    );
  });

  subscriptionPlanList = panlist;
  return panlist;
}

Future activePlan(subId, userId) async {
  final response = await http.get(Uri.parse(
      '${Consttext.ipAddress}/appgetusersubdetails?subId=$subId&userId=$userId'));
  print(
      '${Consttext.ipAddress}/appgetusersubdetails?subId=$subId&userId=$userId');

  List<dynamic> maps = json.decode(response.body);

  //print('concepts list is ${maps.toString()}');

  List<SubscriptionData> actived = List.generate(maps.length, (index) {
    return SubscriptionData(
      subId: (maps[index]['subId']).toString(),
      planName: (maps[index]['planname']).toString(),
      planDesc: (maps[index]['description']).toString(),
      planAmount: (maps[index]['amount']).toString(),
      planDuration: maps[index]['duration'].toString(),
    );
  });

  subscriptionPlanList = actived;
  return actived;
}
