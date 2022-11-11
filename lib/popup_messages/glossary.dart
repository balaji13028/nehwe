import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:screen_protector/screen_protector.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../constants/color_palettes.dart';
import '../loadings/loader.dart';

glossaryPopUP(BuildContext context, path) async {
  final GlobalKey<SfPdfViewerState> pdfViewerKey = GlobalKey();
  Size size = MediaQuery.of(context).size;

  await ScreenProtector.preventScreenshotOn();

  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return GlobalLoaderOverlay(
            useDefaultLoading: false,
            overlayWidget: const Loader(),
            child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, bottom: size.height * 0.04),
                    margin: EdgeInsets.symmetric(
                        horizontal: size.height * 0.03, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: ColorPalette.backgroundcolor1),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: size.height * 0.06,
                          width: size.width,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: ColorPalette.backgroundcolor1),
                          child: Row(
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
                              const Visibility(
                                visible: false,
                                maintainAnimation: true,
                                maintainSize: true,
                                maintainState: true,
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: ColorPalette.primarycolor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                            child: SfPdfViewer.network(path, key: pdfViewerKey,
                                onDocumentLoadFailed: (details) {
                          const Icon(Icons.refresh_outlined);
                        }, pageLayoutMode: PdfPageLayoutMode.continuous)),
                      ],
                    ))));
      });
}
