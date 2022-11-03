class StatusOfCourses {
  String? courseId,
      courseStatus,
      unitId,
      unitStatus,
      lessonId,
      lessonStatus,
      conceptId,
      conceptStatus;
  StatusOfCourses(
      {this.courseId,
      this.conceptStatus,
      this.unitId,
      this.unitStatus,
      this.lessonId,
      this.lessonStatus,
      this.conceptId,
      this.courseStatus});

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'courseStatus': courseStatus,
      'unitId': unitId,
      'unitStatus': unitStatus,
      'lessonId': lessonId,
      'lessonStatus': lessonStatus,
      'conceptId': conceptId,
      'conceptStatus': conceptStatus
    };
  }

  @override
  String toString() {
    return 'coursesData{courseId: $courseId,courseStatus:$courseStatus,unitId:$unitId,unitStatus:$unitStatus,lessonId:$lessonId,lessonStatus:$lessonStatus,conceptId:$conceptId,conceptStatus:$conceptStatus}';
  }
}

List<StatusOfCourses> statuslist = [];
StatusOfCourses newstatus = StatusOfCourses();
