class UserProfileData {
  String? firstName,
      lastName,
      displayName,
      emailId,
      dob,
      address,
      city,
      gender,
      zipcode,
      id,
      phoneNumber,
      state,
      country,
      avatar,
      subId,
      xp,
      coins,
      lastused,
      onlineStatus,
      lifes;

  UserProfileData({
    this.id,
    this.displayName,
    this.firstName,
    this.avatar,
    this.lastName,
    this.emailId,
    this.dob,
    this.address,
    this.city,
    this.phoneNumber,
    this.state,
    this.gender,
    this.zipcode,
    this.subId,
    this.country,
    this.xp,
    this.coins,
    this.lastused,
    onlineStatus,
    this.lifes,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'firstName': firstName,
      'lastName': lastName,
      'displayName': displayName,
      'phoneNumber': phoneNumber,
      'avatar': avatar,
      'zipcode': zipcode,
      'email': emailId,
      'dateOfBirth': dob,
      'state': state,
      'city': city,
      'address': address,
      'gender': gender,
      'country': country,
      'subscription': subId,
      'xp': xp,
      'coins': coins,
      'lifes': lifes,
      'onlineStatus': onlineStatus,
      "lastused": lastused
    };
  }

  @override
  String toString() {
    return 'UserProfileData{id: $id, firstName: $firstName,lastName:$lastName,displayName:$displayName,phoneNumber: $phoneNumber,avatar:$avatar,gender:$gender,zipcode:$zipcode,email:$emailId,dateOfBirth:$dob,state:$state,city:$city,address:$address,country:$country,lifes:$lifes,coins:$coins,xp:$xp,subscription:$subId,onlineStatus:$onlineStatus,lastused:$lastused}';
  }
}

// ignore: unnecessary_new
UserProfileData newUser = UserProfileData();
List<UserProfileData> localUserList = [];
//List<UserProfileData> listofusers = [];
UserProfileData encodeedavatr = UserProfileData();
