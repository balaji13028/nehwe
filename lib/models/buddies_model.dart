class BuddyProfileData {
  String? buddyId,
      buddyName,
      buddyAvatar,
      buddyXp,
      buddyStreak,
      buddiescount,
      buddyCourses;
  BuddyProfileData({
    this.buddyId,
    this.buddyName,
    this.buddyXp,
    this.buddyStreak,
    this.buddyAvatar,
    this.buddiescount,
    this.buddyCourses,
  });

  Map<String, dynamic> toMap() {
    return {
      'buddyId': buddyId,
      'buddyName': buddyName,
      'buddyAvatar': buddyAvatar,
      'buddyXp': buddyXp,
      'buddyStreak': buddyStreak,
      'buddiescount': buddiescount,
      'buddyCourses': buddyCourses
    };
  }

  @override
  String toString() {
    return 'Buddyprofile{buddyId:$buddyId,buddyName:$buddyName,buddyAvatar:$buddyAvatar,buddyXp:$buddyXp,buddyStreak:$buddyStreak,buddiescount:$buddiescount,buddyCourses:$buddyCourses}';
  }
}

List<BuddyProfileData> buddiesList = [];
BuddyProfileData newBuddy = BuddyProfileData();
