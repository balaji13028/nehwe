import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nehwe/models/courses_model.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../constants/color_palettes.dart';

// ignore: must_be_immutable
class GlossaryDrawer extends StatelessWidget {
  ScreenData glossary;
  GlossaryDrawer({super.key, required this.glossary});
  PdfViewerController pdfViewerController = PdfViewerController();

  @override
  Widget build(BuildContext context) {
    ScreenProtector.preventScreenshotOn();
    Size size = MediaQuery.of(context).size;
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
      child: Container(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: size.height * 0.55,
                width: size.width * 0.78,
                child: Drawer(
                  backgroundColor: ColorPalette.backgroundcolor1,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                  )),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 15, bottom: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                Navigator.pop(context);
                                await ScreenProtector.preventScreenshotOff();
                              },
                              child: const Icon(
                                Icons.clear,
                                size: 28,
                                color: ColorPalette.whitetextcolor,
                              ),
                            ),
                            const Text(
                              'Glossary',
                              style: TextStyle(
                                  fontSize: 20,
                                  letterSpacing: 0.9,
                                  fontWeight: FontWeight.bold,
                                  color: ColorPalette.whitetextcolor),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: (() {
                                      pdfViewerController.previousPage();
                                    }),
                                    child: const Icon(
                                      Icons.arrow_back_ios,
                                      color: ColorPalette.whitetextcolor,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      pdfViewerController.nextPage();
                                    },
                                    child: const Icon(
                                      Icons.arrow_forward_ios,
                                      color: ColorPalette.whitetextcolor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                            child: SfPdfViewer.network(newscreen.gsHeading!,
                                controller: pdfViewerController,
                                enableTextSelection: false,
                                onDocumentLoadFailed: (details) {
                          const Icon(Icons.refresh_outlined);
                        }, pageLayoutMode: PdfPageLayoutMode.single)),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
