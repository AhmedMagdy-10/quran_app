    //  EasyContainer(
//                           borderRadius: 8,
//                           color: primaryColors[getValue("quranPageolorsIndex")]
//                               .withOpacity(.05),
//                           onTap: () async {
//                             Navigator.pop(context);
//                             // print(getValue("lastRead"));
//                             // print(quran.getAudioURLBySurah(
//                             //     surahNumber, reciters[2].identifier));
//                             // print(quran.getAudioURLByVerse(surahNumber,
//                             //     verseNumber, reciters[2].identifier));
//                             await downloadAndCacheSuraAudio(
//                                 quran.getSurahNameEnglish(surahNumber),
//                                 quran.getVerseCount(surahNumber),
//                                 surahNumber,
//                                 reciters[getValue("reciterIndex")].identifier);
//                             // print("lastt read ${getValue("lastRead")}");

  //   BlocBuilder<QuranPagePlayerBloc, QuranPagePlayerState>(
  //           bloc: qurapPagePlayerBloc,
  //           builder: (context, state) {
  //             if (state is QuranPagePlayerPlaying) {
  //               return Positioned(
  //                   bottom: 0,
  //                   width: screenSize.width,
  //                   child: Center(
  //                     child: Container(
  //                       width: screenSize.width,
  //                       decoration: BoxDecoration(
  //                           color: backgroundColors[
  //                               getValue("quranPageolorsIndex")],
  //                           boxShadow: [
  //                             BoxShadow(
  //                                 blurRadius: 1,
  //                                 color: primaryColors[
  //                                         getValue("quranPageolorsIndex")]
  //                                     .withOpacity(.7))
  //                           ],
  //                           borderRadius: BorderRadius.only(
  //                               topRight: Radius.circular(15.r),
  //                               topLeft: Radius.circular(15.r))),
  //                       child: Column(
  //                         mainAxisSize: MainAxisSize.min,
  //                         children: [
  //                           Directionality(
  //                             textDirection: m.TextDirection.rtl,
  //                             child: Row(
  //                               mainAxisAlignment: MainAxisAlignment.center,
  //                               children: [
  //                                 DropdownButton<int>(
  //                                   value: getValue("reciterIndex"),
  //                                   dropdownColor: backgroundColors[
  //                                       getValue("quranPageolorsIndex")],
  //                                   onChanged: (int? newIndex) async {
  //                                     updateValue("reciterIndex", newIndex);
  //                                     await downloadAndCacheSuraAudio(
  //                                         quran.getSurahNameEnglish(
  //                                             state.suraNumber),
  //                                         quran.getVerseCount(state.suraNumber),
  //                                         state.suraNumber,
  //                                         reciters[getValue("reciterIndex")]
  //                                             .identifier);
  //                                     state.player.dispose();
  //                                     // BlocProvider.of<QuranPagePlayerBloc>(context, listen: false)
  //                                     if (playerPageBloc.state
  //                                         is PlayerBlocPlaying) {
  //                                       await showDialog(
  //                                           context: context,
  //                                           builder: (a) {
  //                                             return AlertDialog(
  //                                               content: const Text(
  //                                                   "Close current player?"),
  //                                               actions: [
  //                                                 TextButton(
  //                                                     onPressed: () {
  //                                                       Navigator.pop(context);
  //                                                     },
  //                                                     child:
  //                                                         const Text("Back")),
  //                                                 TextButton(
  //                                                     onPressed: () {
  //                                                       playerPageBloc.add(
  //                                                           ClosePlayerEvent());
  //                                                       Navigator.pop(context);
  //                                                     },
  //                                                     child: const Text(
  //                                                         "close it")),
  //                                               ],
  //                                             );
  //                                           });
  //                                     }
  //                                     qurapPagePlayerBloc.add(PlayFromVerse(
  //                                         currentVersePlaying,
  //                                         reciters[getValue("reciterIndex")]
  //                                             .identifier,
  //                                         state.suraNumber,
  //                                         quran.getSurahNameEnglish(
  //                                             state.suraNumber)));
  //                                     setState(() {});

  //                                     // setstatee(() {});
  //                                   },
  //                                   items: reciters.map((reciter) {
  //                                     return DropdownMenuItem<int>(
  //                                       value: reciters.indexOf(reciter),
  //                                       child: Text(reciter.name,
  //                                           style: TextStyle(
  //                                               color: primaryColors[getValue(
  //                                                   "quranPageolorsIndex")])),
  //                                     );
  //                                   }).toList(),
  //                                 ),

  //                                 // Text(
  //                                 //   state.reciter["englishName"],
  //                                 //   style: TextStyle(
  //                                 //       color: primaryColors[
  //                                 //           getValue("quranPageolorsIndex")]),
  //                                 // ),
  //                                 IconButton(
  //                                     iconSize: 14.sp,
  //                                     onPressed: () {
  //                                       if (currentVersePlaying[
  //                                               "verseNumber"] !=
  //                                           1) {
  //                                         state.player.seek(Duration(
  //                                             milliseconds: state.durations
  //                                                 .where((element) =>
  //                                                     element["verseNumber"] ==
  //                                                     (currentVersePlaying[
  //                                                             "verseNumber"] -
  //                                                         1))
  //                                                 .first["startDuration"]
  //                                                 .toInt()));
  //                                       }
  //                                     },
  //                                     icon: const Icon(
  //                                         LineariconsFree.chevron_right)),
  //                                 GestureDetector(
  //                                   onTap: () async {
  //                                     // setState(() {});
  //                                     state.player.playing
  //                                         ? state.player.pause()
  //                                         : state.player.play();
  //                                     await Future.delayed(
  //                                         const Duration(milliseconds: 300));

  //                                     setState(() {}); // setState(() {});
  //                                   },
  //                                   child: Container(
  //                                     height: 28.h,
  //                                     width: 28.h,
  //                                     decoration: BoxDecoration(
  //                                       color: secondaryColors[
  //                                           getValue("quranPageolorsIndex")],
  //                                       borderRadius:
  //                                           BorderRadius.circular(5.r),
  //                                     ),
  //                                     child: Center(
  //                                       child: Icon(
  //                                         state.player.playing
  //                                             ? Icons.pause
  //                                             : Icons.play_arrow,
  //                                         color: Colors.white,
  //                                         size: 14.sp,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),
  //                                 SizedBox(
  //                                   width: 5.w,
  //                                 ),
  //                                 GestureDetector(
  //                                   onTap: () async {
  //                                     state.player.stop();
  //                                     qurapPagePlayerBloc.add(StopPlaying());
  //                                     setState(() {});
  //                                   },
  //                                   child: Container(
  //                                     height: 28.h,
  //                                     width: 28.h,
  //                                     decoration: BoxDecoration(
  //                                       color: Colors.redAccent,
  //                                       borderRadius:
  //                                           BorderRadius.circular(5.r),
  //                                     ),
  //                                     child: Center(
  //                                       child: Icon(
  //                                         Icons.stop,
  //                                         size: 14.sp,
  //                                         color: Colors.white,
  //                                       ),
  //                                     ),
  //                                   ),
  //                                 ),

  //                                 IconButton(
  //                                     iconSize: 14.sp,
  //                                     onPressed: () {
  //                                       if (currentVersePlaying["verseNumber"] <
  //                                           state.durations.length) {
  //                                         state.player.seek(Duration(
  //                                             milliseconds: state.durations
  //                                                 .where((element) =>
  //                                                     element["verseNumber"] ==
  //                                                     (currentVersePlaying[
  //                                                             "verseNumber"] +
  //                                                         1))
  //                                                 .first["startDuration"]
  //                                                 .toInt()));
  //                                       }
  //                                     },
  //                                     icon: const Icon(
  //                                         LineariconsFree.chevron_left)),
  //                               ],
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ));
  //             }
  //             return Container();
  //           },
  //         )
  //         //  if(isDownloading)
  //       ],
  //     ),
  //   );
  // }