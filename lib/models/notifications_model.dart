import 'dart:async';

class NotificationData {
  String? title, descripation; //fileds inside the class

  NotificationData({this.title, this.descripation});
}

List<NotificationData> notifyDetails = [
  NotificationData(
      title: 'Time to learn',
      descripation: 'You can start your next lesson in 10 more minutes'),
  NotificationData(
      title: 'Your friend has completed course',
      descripation:
          'Your friend Laurelle_Luian has completed Communication course in 20days only You can start your next lesson in 10 more minutes You can start your next lesson in 10 more minutes'),
  NotificationData(
      title: 'You have a new friend',
      descripation:
          'Mahamadou_Lovel has added you in his buddies list. You can check his profile now.'),
  NotificationData(
      title: 'Time to learn',
      descripation: 'You can start your next lesson in 10 more minute')
];
