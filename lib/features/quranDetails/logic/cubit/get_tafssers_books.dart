// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:quran_app/features/quranDetails/logic/cubit/get_tafssers_books_states.dart';

// class GetTafssersBookCubit extends Cubit<GetTafssersBooksStates> {
//   GetTafssersBookCubit() : super(InitialGetTafssersBookState());

//   bool isDownloading = false;
//   Future<void> downloadAndCacheSuraAudio(
//       String suraName, int totalVerses, suraNumber, reciterIdentifier) async {
//     final audioPlayer = AudioPlayer();

//     setState(() {
//       isDownloading = true;
//     });

//     final dio = Dio();
//     final appDir = await getTemporaryDirectory();
//     final ffmpeg = FlutterFFmpeg();

//     final fullSuraFilePath =
//         "${appDir.path}-$reciterIdentifier-${suraName.replaceAll(" ", "")}.mp3";

//     // Check if the full sura file already exists
//     if (File(fullSuraFilePath).existsSync()) {
//       // print('Full sura audio file already cached: $fullSuraFilePath');
//     } else {
//       Fluttertoast.showToast(msg: "Downloading..");
//       final List<String> audioFilePaths = [];
//       List verseNumberAndDuration = [];
//       var startDuration = 0.0;

//       for (int verse = 1; verse <= totalVerses; verse++) {
//         final fileName =
//             '$reciterIdentifier-${suraName.replaceAll(" ", "")}-$verse.mp3';
//         final filePath = '${appDir.path}/$fileName';
//         // print(filePath);
//         // Check if the file already exists in the cache
//         if (File(filePath).existsSync()) {
//           // print('Audio file already cached: $filePath');
//         } else {
//           final audioUrl = quran.getAudioURLByVerse(suraNumber, verse,
//               reciterIdentifier); // Replace with the actual audio URL
//           try {
//             await dio.download(audioUrl, filePath);
//             // print('Audio file downloaded and cached: $filePath');
//             final metadata = await MetadataRetriever.fromFile(File(filePath));
//             verseNumberAndDuration.add({
//               "verseNumber": verse,
//               "startDuration": startDuration,
//               "endDuration": startDuration + ((metadata.trackDuration!))
//             });
//             startDuration = startDuration + ((metadata.trackDuration!));
//           } catch (e) {
//             // print('Error downloading and caching audio: $e');
//           }
//         }

//         audioFilePaths.add(filePath);
//       }
//       // print(verseNumberAndDuration);
//       String jsonString = json.encode(verseNumberAndDuration);

//       updateValue(
//           "$reciterIdentifier-${suraName.replaceAll(" ", "")}-durations",
//           jsonString.toString());

//       String inputOptions =
//           audioFilePaths.map((filePath) => "-i $filePath").join(" ");
//       String cmd =
//           "$inputOptions -filter_complex 'concat=n=${audioFilePaths.length}:v=0:a=1[a]' -map '[a]' -codec:a libmp3lame -qscale:a 2 $fullSuraFilePath";

//       final int resultCode = await ffmpeg.execute(cmd);

//       if (resultCode == 0) {
//         // print('Full sura audio file combined successfully: $fullSuraFilePath');
//         Fluttertoast.showToast(msg: "Done...");
//       } else {
//         // print(
//         // 'Error combining audio files: FFmpeg returned error code $resultCode');
//       }
//     }
//   }
// }
