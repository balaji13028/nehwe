class SubscriptionData {
  String? subId, planName, planDuration, planDesc, planAmount;
  SubscriptionData({
    this.subId,
    this.planName,
    this.planDuration,
    this.planDesc,
    this.planAmount,
  });

  Map<String, dynamic> toMap() {
    return {
      'subId': subId,
      'planName': planName,
      'planDuration': planDuration,
      'planDesc': planDesc,
      'planAmount': planAmount
    };
  }

  @override
  String toString() {
    return 'coursesData{subId: $subId, planName: $planName,planDuration:$planDuration,planAmount:$planAmount}';
  }
}

List<SubscriptionData> subscriptionPlanList = [];
SubscriptionData newplan = SubscriptionData();
