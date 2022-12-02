class BuddyProfileData {
  String? buddyId,
      buddyDisplayName,
      buddyFirstName,
      buddyLastName,
      buddyAvatar,
      buddyXp,
      status,
      buddyStreak,
      buddiescount,
      buddyCoins,
      onlineStatus,
      requestStatus;
  BuddyProfileData({
    this.buddyId,
    this.buddyDisplayName,
    this.buddyFirstName,
    this.buddyLastName,
    this.buddyXp,
    this.buddyStreak,
    this.buddyAvatar,
    this.buddiescount,
    this.buddyCoins,
    this.status,
    this.onlineStatus,
    this.requestStatus,
  });

  Map<String, dynamic> toMap() {
    return {
      'buddyId': buddyId,
      'buddyDisplayName': buddyDisplayName,
      'buddyFirstName': buddyFirstName,
      'buddyLastName': buddyLastName,
      'buddyAvatar': buddyAvatar,
      'buddyXp': buddyXp,
      'onlineStatus': onlineStatus,
      'requestStatus': status,
      'buddyStreak': buddyStreak,
      'buddiescount': buddiescount,
      'buddyCoins': buddyCoins,
      'requestsStatus': requestStatus
    };
  }

  @override
  String toString() {
    return 'Buddyprofile{buddyId:$buddyId,buddyDisplayName:$buddyDisplayName,buddyFirstName:$buddyFirstName,buddyLastName:$buddyLastName,requestStatus:$status,buddyAvatar:$buddyAvatar,buddyXp:$buddyXp,buddyStreak:$buddyStreak,onlineStatus:$onlineStatus,buddiescount:$buddiescount,buddyCoins:$buddyCoins,requestsStatus:$requestStatus}';
  }
}

List<BuddyProfileData> buddiesList = [];
List<BuddyProfileData> userBuddy = [];
List<BuddyProfileData> listofusers = [];
BuddyProfileData newBuddy = BuddyProfileData();

class FriendRequestsData {
  String? senderUesrId, requetsedUserId, friendStatus, suggestionId;
  FriendRequestsData(
      {this.senderUesrId,
      this.requetsedUserId,
      this.friendStatus,
      this.suggestionId});
  Map<String, dynamic> toMap() {
    return {
      'senderUesrId': senderUesrId,
      'requetsedUserId': requetsedUserId,
      'suggestionId': suggestionId,
      'friendStatus': friendStatus
    };
  }

  @override
  String toString() {
    return 'friend_requests{senderUesrId:$senderUesrId, requetsedUserId:$requetsedUserId,friendStatus:$friendStatus,suggestionId:$suggestionId}';
  }
}

List<FriendRequestsData> requestsList = [];
List<FriendRequestsData> suggestionsList = [];
