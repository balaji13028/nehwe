import 'package:flutter/material.dart';
import 'package:nehwe/courses/units_screen.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:nehwe/popup_messages/test_report_card.dart';
import 'package:nehwe/question_pages/test_module/listening_module/listenpage_1.dart';
import 'package:nehwe/question_pages/test_module/listening_module/listenpage_2.dart';
import 'package:nehwe/question_pages/test_module/listening_module/listenpage_3.dart';
import 'package:nehwe/question_pages/test_module/listening_module/listenpage_4.dart';
import 'package:nehwe/question_pages/test_module/listening_module/listenpage_5.dart';
import 'package:nehwe/question_pages/test_module/listening_module/listenpage_6.dart';
import 'package:nehwe/question_pages/test_module/listening_module/listenpage_7.dart';
import 'package:nehwe/question_pages/test_module/listening_module/listenpage_8.dart';
import 'package:nehwe/question_pages/test_module/reading_module/readpage_2.dart';
import 'package:nehwe/question_pages/test_module/reading_module/readpage_3.dart';
import 'package:nehwe/question_pages/test_module/reading_module/readpage_4.dart';
import 'package:nehwe/question_pages/test_module/reading_module/readpage_5.dart';
import 'package:nehwe/question_pages/test_module/reading_module/readpage_6.dart';
import 'package:nehwe/question_pages/test_module/reading_module/readpage_7.dart';
import 'package:nehwe/question_pages/test_module/reading_module/readpage_8.dart';
import 'package:nehwe/question_pages/test_module/speaking_module/speackpage_1.dart';
import 'package:nehwe/question_pages/test_module/speaking_module/speakpage_2.dart';
import 'package:nehwe/question_pages/test_module/speaking_module/speakpage_3.dart';
import 'package:nehwe/question_pages/test_module/speaking_module/speakpage_4.dart';
import 'package:nehwe/question_pages/test_module/writing_module/writepage_1.dart';
import 'package:nehwe/question_pages/test_module/writing_module/writepage_2.dart';
import 'package:nehwe/question_pages/test_module/writing_module/writepage_3.dart';

import '../../question_pages/test_module/reading_module/readpage_1.dart';

testModuleToNavigatetoScreen(
  context,
  idx,
) async {
  if (idx < screenlist.length) {
    ScreenData screen = screenlist[idx];
    if (screen.screenlkpId == '1') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestReading1(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '2') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestReading2(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '3') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestReading3(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '4') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestReading4(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '5') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestReading5(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '6') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestReading6(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '7') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestReading7(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '8') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestReading8(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '9') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestListening1(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '10') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestListening2(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '11') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestListening3(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '12') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestListening4(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '13') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestListening5(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '14') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestListening6(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '15') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestListening7(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '16') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestListening8(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '17') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestSpeaking1(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '18') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestSpeaking2(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '19') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestSpeaking3(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '20') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestSpeaking4(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '22') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestWriting1(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '23') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestWriting2(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    } else if (screen.screenlkpId == '24') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  TestWriting3(
                    screendata: screen,
                    index: idx,
                    length: screenlist.length,
                  ))));
    }
  } else {
    await testReport(context);
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: ((context, animation, secondaryAnimation) =>
                Units(course: newcourse))));
  }
}
