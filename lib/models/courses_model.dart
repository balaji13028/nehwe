class CoursesData {
  String? courseId, courseName, courseImage, courseStatus;

  CoursesData(
      {this.courseId, this.courseName, this.courseImage, this.courseStatus});

  Map<String, dynamic> toMap() {
    return {
      'courseId': courseId,
      'courseName': courseName,
      'courseStatus': courseStatus,
      'courseImage': courseImage
    };
  }

  @override
  String toString() {
    return 'coursesData{courseId: $courseId, courseName: $courseName,courseStatus:$courseStatus,courseImage:$courseImage}';
  }
}

List<CoursesData> courseList = [];

///THIS IS FOR UNIT MODEL..
class UnitData {
  String? unitId, unitName, unitXP, unitStatus;
  int? compcount, completedXP, status;
  List<LessonData>? lessons;
  UnitData(
      {this.unitId,
      this.unitName,
      this.compcount,
      this.unitXP,
      this.completedXP,
      this.lessons,
      this.status,
      this.unitStatus});
  Map<String, dynamic> toMap() {
    return {
      'unitId': unitId,
      'unitName': unitName,
      'unitXP': unitXP,
      'unitStatus': unitStatus,
      'lessonList': lessons,
    };
  }

  @override
  String toString() {
    return 'BasedOnCourseID{unitId: $unitId, unitName: $unitName,unitXP:$unitXP,unitStatus:$unitStatus,lessons:$lessons}';
  }
}

List<UnitData> unitlist = [];

///This is for lesson model class....
class LessonData {
  String? lessonId, lessonName, lessonStatus, unitId, lessonXP;
  var glossary;
  int? xp;
  LessonData(
      {this.lessonId,
      this.lessonName,
      this.unitId,
      this.lessonXP,
      this.xp,
      this.glossary,
      this.lessonStatus});

  Map<String, dynamic> toMap() {
    return {
      'lessonId': lessonId,
      'lessonName': lessonName,
      'lessonStatus': lessonStatus,
      'unitId': unitId,
      'lessonXP': lessonXP,
      'glossary': glossary
    };
  }

  @override
  String toString() {
    return 'lessonsData{lessonId: $lessonId, lessonName: $lessonName,unitId:$unitId,lessonXP:$lessonXP,lessonStatus:$lessonStatus,glossary:$glossary}';
  }
}

List<LessonData> lessonlist = [];

///THIS IS FOR CONCEPT MODEL..
class ConceptData {
  String? conceptId, conceptName, xp, conceptstatus;

  ConceptData({this.conceptId, this.conceptName, this.xp, this.conceptstatus});

  Map<String, dynamic> toMap() {
    return {
      'conceptId': conceptId,
      'conceptName': conceptName,
      'xp': xp,
      'conceptstatus': conceptstatus
    };
  }

  @override
  String toString() {
    return 'conceptData{conceptId: $conceptId, conceptName: $conceptName,xp:$xp,conceptstatus:$conceptstatus}';
  }
}

List<ConceptData> conceptlist = [];

///THIS IS FOR SCREENS MODEL...
class ScreenData {
  String? screenId,
      testId,
      status,
      screenName,
      screenlkpId,
      question,
      audiofile,
      imagefile,
      text,
      answertype,
      textStatus,
      gsHeading,
      imageStatus,
      audioStatus,
      answer,
      hint;

  List<String>? optionset1, optionset2;

  ScreenData(
      {this.screenId,
      this.screenlkpId,
      this.screenName,
      this.question,
      this.audiofile,
      this.imagefile,
      this.optionset1,
      this.optionset2,
      this.answer,
      this.gsHeading,
      this.imageStatus,
      this.audioStatus,
      this.text,
      this.answertype,
      this.textStatus,
      this.testId,
      this.status,
      this.hint});

  Map<String, dynamic> toMap() {
    return {
      'screenId': screenId,
      'testId': testId,
      'screenlkpId': screenlkpId,
      'screenName': screenName,
      'question': question,
      'audiofile': audiofile,
      'imagefile': imagefile,
      'optionset1': optionset1,
      'optionset2': optionset2,
      'text': text,
      'answertype': answertype,
      'textStatus': textStatus,
      'answer': answer,
      'gsHeading': gsHeading,
      'gsDescription': imageStatus,
      'gsExample': audioStatus,
      'hint': hint,
      'status': status
    };
  }

  @override
  String toString() {
    return 'screenData{screenId: $screenId,screenlkpId:$screenlkpId,testId:$testId screenName: $screenName,question:$question,optionset1:$optionset1,optionset2:$optionset2,answer:$answer,text:$text,audiofile:$audiofile,imagefile:$imagefile,answertype:$answertype,gsHeading:$gsHeading,textStatus:$textStatus,imageStatus:$imageStatus,audioStatus:$audioStatus,hint:$hint,status:$status}';
  }
}

List<ScreenData> screenlist = [];
UnitData newunit = UnitData();
LessonData newlesson = LessonData();
CoursesData newcourse = CoursesData();
ConceptData newconpt = ConceptData();
ScreenData newscreen = ScreenData();
int herotag = 0;
