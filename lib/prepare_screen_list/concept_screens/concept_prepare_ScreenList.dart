import 'package:flutter/material.dart';
import '../../courses/concpets_screen.dart';
import '../../popup_messages/concept_report_card.dart';
import '../../question_pages/concept_screens/listening_module/listenpage_1.dart';
import '../../question_pages/concept_screens/listening_module/listenpage_2.dart';
import '../../question_pages/concept_screens/listening_module/listenpage_3.dart';
import '../../question_pages/concept_screens/listening_module/listenpage_4.dart';
import '../../question_pages/concept_screens/listening_module/listenpage_5.dart';
import '../../question_pages/concept_screens/listening_module/listenpage_6.dart';
import '../../question_pages/concept_screens/listening_module/listenpage_7.dart';
import '../../question_pages/concept_screens/listening_module/listenpage_8.dart';
import '../../question_pages/concept_screens/reading_module/readpage_1.dart';
import '../../question_pages/concept_screens/reading_module/readpage_2.dart';
import '../../question_pages/concept_screens/reading_module/readpage_3.dart';
import '../../question_pages/concept_screens/reading_module/readpage_4.dart';
import '../../question_pages/concept_screens/reading_module/readpage_5.dart';
import '../../question_pages/concept_screens/reading_module/readpage_6.dart';
import '../../question_pages/concept_screens/reading_module/readpage_7.dart';
import '../../question_pages/concept_screens/reading_module/readpage_8.dart';
import '../../question_pages/concept_screens/speaking_module/speackpage_1.dart';
import '../../question_pages/concept_screens/speaking_module/speakpage_2.dart';
import '../../question_pages/concept_screens/speaking_module/speakpage_3.dart';
import '../../question_pages/concept_screens/speaking_module/speakpage_4.dart';
import '../../question_pages/concept_screens/writing_module/writepage_1.dart';
import '../../question_pages/concept_screens/writing_module/writepage_2.dart';
import '../../question_pages/concept_screens/writing_module/writepage_3.dart';
import '../../models/courses_model.dart';

navigatetoScreen(
  context,
  idx,
) async {
  if (idx < 6) {
    ScreenData screen = screenlist[idx];
    if (screen.screenlkpId == '1') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ReadingModule1(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '2') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ReadingModule2(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '3') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ReadingModule3(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '4') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ReadingModule4(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '5') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ReadingModule5(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '6') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ReadingModule6(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '7') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ReadingModule7(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '8') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ReadingModule8(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '9') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ListeningModule1(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '10') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ListeningModule2(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '11') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ListeningModule3(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '12') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ListeningModule4(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '13') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ListeningModule5(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '14') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ListeningModule6(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '15') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ListeningModule7(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '16') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  ListeningModule8(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '17') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  SpeakingModule1(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '18') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  SpeakingModule2(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '19') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  SpeakingModule3(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '20') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  SpeakingModule4(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '22') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  WritingModule1(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '23') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  WritingModule2(screendata: screen, index: idx))));
    } else if (screen.screenlkpId == '24') {
      Navigator.push(
          context,
          PageRouteBuilder(
              pageBuilder: ((context, animation, secondaryAnimation) =>
                  WritingModule3(screendata: screen, index: idx))));
    }
  } else {
    await conceptReport(context);
    Navigator.push(
        context,
        PageRouteBuilder(
            pageBuilder: ((context, animation, secondaryAnimation) => Lessons(
                  unit: newunit,
                  lesson: newlesson,
                  course: newcourse,
                ))));
  }
}
