import 'package:url_launcher/url_launcher.dart';

Future<void> downloadMovie(String url) async {
  final Uri uri = Uri.parse(url);

  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (e) {
    print("Error launching URL: $e");
  }
}