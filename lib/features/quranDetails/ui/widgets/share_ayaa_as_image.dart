import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quran/quran.dart';
import 'package:quran_app/constant/colors.dart';
import 'package:quran_app/constant/style.dart';
import 'package:quran_app/core/helper/build_tafseer_spans.dart';
import 'package:quran_app/core/helper/build_verse_spans.dart';
import 'package:quran_app/core/helper/hive_helper.dart';
import 'package:quran_app/core/helper/saved_and%20shared%20image.dart';
import 'package:quran_app/core/helper/show_toast_state.dart';
import 'package:quran_app/features/quranDetails/logic/translation/translationdata.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/basmala.dart';
import 'package:quran_app/features/quranDetails/ui/widgets/header_widget.dart';
import 'package:screenshot/screenshot.dart';

class ShareAyaaAsImagepPage extends StatefulWidget {
  const ShareAyaaAsImagepPage({
    super.key,
    required this.firstVerse,
    required this.lastVerse,
    required this.surahNumber,
    required this.verseNumber,
    required this.pageNumber,
  });

  final int firstVerse;
  final int lastVerse;
  final int surahNumber;
  final int verseNumber;
  final int pageNumber;

  @override
  State<ShareAyaaAsImagepPage> createState() => _ShareAyaaAsImagepPageState();
}

class _ShareAyaaAsImagepPageState extends State<ShareAyaaAsImagepPage> {
  late int firstVerse;
  late int lastVerse;
  ScreenshotController screenshotController = ScreenshotController();

  var dataOfCurrentTranslation;

  var isDownloading = "";

  getTranslationData() async {
    if (getHiveSavedData("indexOfTranslationInVerseByVerse") > 1) {
      File file = File(
          "${appDir!.path}/${translationDataList[getHiveSavedData("indexOfTranslationInVerseByVerse")].typeText}.json");

      String jsonData = await file.readAsString();
      dataOfCurrentTranslation = json.decode(jsonData);
    }
    setState(() {});
  }

  bool isShooting = false;

  Directory? appDir;
  initializeDirectory() async {
    appDir = await getTemporaryDirectory();
    getTranslationData();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    getTranslationData();
    firstVerse = widget.firstVerse;
    lastVerse = widget.lastVerse;
    super.initState();
    initializeDirectory();
  }

  int? indexOfTheme;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'تفاصيل الصورة',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'من الايه',
                  style: TextStyle(
                    fontFamily: 'taha',
                    fontSize: 18,
                    color: fiveColor,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                customBuildDropdown(
                  value: firstVerse,
                  onChanged: (newValue) {
                    if (newValue != null && newValue > lastVerse) {
                      setState(() {
                        lastVerse = newValue;
                      });
                    }
                    setState(() {
                      firstVerse = newValue!;
                    });
                    print(firstVerse);
                  },
                ),
                SizedBox(
                  width: 10.w,
                ),
                Text(
                  'الي الايه',
                  style: TextStyle(
                    fontFamily: 'taha',
                    fontSize: 18,
                    color: fiveColor,
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                customBuildDropdown(
                    value: lastVerse,
                    onChanged: (newValue) {
                      setState(() {
                        lastVerse = newValue!;
                      });
                      print(lastVerse);
                    }),
              ],
            ),
            SizedBox(
              height: 20.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Checkbox(
                    side: const BorderSide(width: 0.5),
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity:
                        const VisualDensity(horizontal: -4, vertical: -4),
                    fillColor: const WidgetStatePropertyAll(Colors.blue),
                    activeColor: Colors.white,
                    checkColor: Colors.white,
                    value: getHiveSavedDataBool('addTafseerImage'),
                    onChanged: (newValue) {
                      setState(
                        () {
                          updateHiveSavedData('addTafseerImage', newValue);
                          print(getHiveSavedDataBool('addTafseerIamge'));
                        },
                      );
                    },
                  ),
                  SizedBox(
                    width: 5.w,
                  ),
                  Text(
                    'اضافه تفسير',
                    style: TextStyle(
                      fontSize: 22.sp,
                      color: fiveColor,
                      fontFamily: 'Cairo',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            if (getHiveSavedData('addTafseerImage') == true)
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  InkWell(
                    onTap: () {
                      showMaterialModalBottomSheet(
                        enableDrag: true,
                        animationCurve: Curves.easeInOutQuart,
                        elevation: 0,
                        bounce: true,
                        duration: const Duration(milliseconds: 150),
                        backgroundColor: Colors.white,
                        context: context,
                        builder: (context) {
                          return SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.8,
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    " كتب التفسير",
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10.h,
                                  ),
                                  Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: index ==
                                                      getHiveSavedData(
                                                          "addTafseerValue")
                                                  ? specialColor
                                                      .withOpacity(0.5)
                                                  : Colors.transparent,
                                            ),
                                            child: InkWell(
                                              onTap: () async {
                                                if (isDownloading !=
                                                    translationDataList[index]
                                                        .url) {
                                                  if (File("${appDir!.path}/${translationDataList[index].typeText}.json")
                                                          .existsSync() ||
                                                      index == 0 ||
                                                      index == 10) {
                                                    updateHiveSavedData(
                                                        'addTafseerValue',
                                                        index);
                                                    setState(() {});
                                                  } else {
                                                    PermissionStatus status =
                                                        await Permission.storage
                                                            .request();

                                                    await Permission
                                                        .accessMediaLocation
                                                        .request();
                                                    PermissionStatus status2 =
                                                        await Permission
                                                            .manageExternalStorage
                                                            .request();
                                                    print(
                                                        'status $status   -> $status2');
                                                    if (status.isGranted &&
                                                        status2.isGranted) {
                                                      print(true);
                                                    } else if (status
                                                            .isPermanentlyDenied &&
                                                        status2
                                                            .isPermanentlyDenied) {
                                                      await openAppSettings();
                                                    } else if (status
                                                        .isDenied) {
                                                      print(
                                                          'Premission is denied');
                                                    }
                                                    Dio()
                                                        .download(
                                                            translationDataList[
                                                                    index]
                                                                .url,
                                                            "${appDir!.path}/${translationDataList[index].typeText}.json")
                                                        .then((e) {
                                                      showToast(
                                                          text:
                                                              'تم تنزيل الكتاب بنجح',
                                                          state: ToastStates
                                                              .success);
                                                      updateHiveSavedData(
                                                          'addTafseerValue',
                                                          index);
                                                    }).catchError((e) {
                                                      showToast(
                                                          text:
                                                              'تحقق من اتصالك بنترنت',
                                                          state: ToastStates
                                                              .error);
                                                    });
                                                  }
                                                  setState(() {});

                                                  getTranslationData();
                                                }
                                                setState(() {});

                                                if (mounted) {
                                                  Navigator.pop(context);
                                                }
                                              },
                                              child: Padding(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20.w,
                                                    vertical: 8.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        translationDataList[
                                                                index]
                                                            .typeTextInRelatedLanguage,
                                                        textDirection:
                                                            TextDirection.rtl,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                          fontFamily: 'Cairo',
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ),
                                                    isDownloading !=
                                                            translationDataList[
                                                                    index]
                                                                .url
                                                        ? Icon(index == 0 ||
                                                                index == 10
                                                            ? Icons
                                                                .storage_rounded
                                                            : File("${appDir!.path}/${translationDataList[index].typeText}.json")
                                                                    .existsSync()
                                                                ? Icons.done_all
                                                                : Icons
                                                                    .cloud_download_rounded)
                                                        : const SpinKitWaveSpinner(
                                                            color: Colors.white,
                                                            size: 30,
                                                          )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                        separatorBuilder: (context, index) =>
                                            Divider(
                                              color: fiveColor,
                                            ),
                                        itemCount: translationDataList.length),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      height: 45.h,
                      width: MediaQuery.sizeOf(context).width * 0.9,
                      decoration: BoxDecoration(
                          color: specialColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              translationDataList[
                                      getHiveSavedData("addTafseerValue") ?? 0]
                                  .typeTextInRelatedLanguage,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.sp,
                                  fontFamily: translationDataList[
                                                  getHiveSavedData(
                                                          "addTafseerValue") ??
                                                      0]
                                              .typeInNativeLanguage ==
                                          "العربية"
                                      ? "cairo"
                                      : "roboto"),
                            ),
                            Icon(
                              Icons.more_horiz_outlined,
                              size: 24.sp,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            SizedBox(
              height: 15.w,
            ),
            //colors pickers
            InkWell(
              onTap: () {
                showGeneralDialog(
                  context: context,
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return Container();
                  },
                  transitionBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return ScaleTransition(
                      scale: Tween<double>(begin: 0.7, end: 1.0)
                          .animate(animation),
                      child: FadeTransition(
                        opacity: Tween<double>(begin: 0.5, end: 1.0)
                            .animate(animation),
                        child: CupertinoAlertDialog(
                          content: SizedBox(
                            height: 300,
                            child: GridView.builder(
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                mainAxisExtent: 70,
                                mainAxisSpacing: 15,
                                crossAxisSpacing: 10,
                              ),
                              itemCount: primaryColors.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      indexOfTheme = index;
                                    });

                                    Navigator.pop(context);
                                  },
                                  child: Stack(
                                    children: [
                                      Center(
                                        child: Container(
                                          clipBehavior: Clip.hardEdge,
                                          decoration: BoxDecoration(
                                              color: backgroundColors[index],
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                        ),
                                      ),
                                      Center(
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor: primaryColors[index],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 2.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'تعديل اللوان',
                      style: TextStyle(
                        fontSize: 22.sp,
                        color: fiveColor,
                        fontFamily: 'Cairo',
                      ),
                    ),
                    CircleAvatar(
                      radius: 15,
                      backgroundColor: specialColor,
                      child: const Icon(
                        Icons.color_lens,
                        size: 19,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
              ),
            ),

            SizedBox(
              height: 30.h,
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                    color: indexOfTheme != null
                        ? backgroundColors[indexOfTheme!]
                        : kprimaryColor,
                    boxShadow: [
                      BoxShadow(
                        color: indexOfTheme != null
                            ? primaryColors[indexOfTheme!].withOpacity(.2)
                            : kprimaryColor,
                        blurRadius: 4,
                        spreadRadius: 4,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: RepaintBoundary(
                    child: Screenshot(
                      controller: screenshotController,
                      child: Container(
                        color: indexOfTheme != null
                            ? backgroundColors[indexOfTheme!]
                            : kprimaryColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8),
                          child: Column(
                            children: [
                              SizedBox(height: 10.h),
                              HeaderWidget(
                                e: {"surah": widget.surahNumber},
                                jsonData: '',
                                indexOfTheme: indexOfTheme,
                              ),
                              if ((widget.firstVerse == 1 &&
                                  widget.pageNumber != 1 &&
                                  widget.pageNumber != 187))
                                Basmala(
                                  index: indexOfTheme ?? 50,
                                ),
                              SizedBox(height: 10.h),
                              SizedBox(
                                width: MediaQuery.sizeOf(context).width,
                                child: RichText(
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  textWidthBasis: TextWidthBasis.longestLine,
                                  locale: const Locale("ar"),
                                  text: TextSpan(
                                    style: TextStyle(
                                      color: indexOfTheme != null
                                          ? primaryColors[indexOfTheme!]
                                          : Colors.black,
                                    ),
                                    children: buildVerseSpans(
                                        widget.surahNumber,
                                        firstVerse,
                                        lastVerse,
                                        widget.verseNumber,
                                        indexOfTheme),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 15.h,
                              ),
                              if (getHiveSavedData('addTafseerImage') == true)
                                Padding(
                                  padding: EdgeInsets.all(6.w),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        translationDataList[getHiveSavedData(
                                                    "addTafseerValue") ??
                                                0]
                                            .typeTextInRelatedLanguage,
                                        style: TextStyle(
                                          color: threeColor,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5.h,
                                      ),
                                      FutureBuilder(
                                        future: buildTafseerSpans(
                                            widget.surahNumber,
                                            widget.firstVerse,
                                            widget.lastVerse,
                                            translationDataList[
                                                getHiveSavedData(
                                                    "addTafseerValue")],
                                            indexOfTheme),
                                        initialData: [],
                                        builder:
                                            (context, AsyncSnapshot snapshot) =>
                                                Container(
                                          width:
                                              MediaQuery.sizeOf(context).width,
                                          decoration: BoxDecoration(
                                            color: secondColor,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(8.w),
                                            child: RichText(
                                                textDirection:
                                                    TextDirection.rtl,
                                                text: TextSpan(
                                                    style: TextStyle(
                                                      color: fiveColor,
                                                    ),
                                                    children: snapshot.hasData
                                                        ? snapshot.data
                                                        : null)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'بواسطه تطبيق نوري',
                                    style: TextStyle(
                                        color: threeColor,
                                        fontSize: 10,
                                        fontFamily: 'taha'),
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  CircleAvatar(
                                    backgroundImage: const AssetImage(
                                      'assets/image/ic_launcher.png',
                                    ),
                                    radius: 10,
                                    backgroundColor: secondColor,
                                    foregroundColor: Colors.grey,
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(right: 28.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () async {
                setState(() {
                  isShooting = true;
                });

                await screenshotController
                    .capture(delay: const Duration(milliseconds: 100))
                    .then((downloadImage) {
                  saveImageToMobile(downloadImage!);
                });

                setState(() {
                  isShooting = false;
                });
              },
              backgroundColor: fiveColor,
              child: const Icon(
                Icons.image_outlined,
                color: Colors.white,
              ),
            ),
            FloatingActionButton(
              shape: const CircleBorder(),
              onPressed: () async {
                setState(() {
                  isShooting = true;
                });
                await screenshotController
                    .capture(delay: const Duration(milliseconds: 100))
                    .then((screenImage) {
                  shareImage(screenImage!);
                });
                setState(() {
                  isShooting = false;
                });
              },
              backgroundColor: fiveColor,
              child: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget customBuildDropdown(
      {required int value, required Function(int?)? onChanged}) {
    return Material(
      child: DropdownButton<int>(
        dropdownColor: Colors.grey[300],
        items: List.generate(
          getVerseCount(widget.surahNumber),
          (index) => DropdownMenuItem<int>(
            value: index + 1,
            child: Text("${index + 1}"),
          ),
        ),
        value: value,
        onChanged: onChanged,
      ),
    );
  }
}
