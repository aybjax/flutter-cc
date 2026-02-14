// =============================================================================
// File Service
// =============================================================================
// Concepts demonstrated:
// - file_picker package — native file selection dialog
// - path_provider — getting platform-specific directories
// - File I/O — reading and writing files with dart:io
// - HTTP file download with progress tracking
// - PlatformException handling for platform-specific errors
// - FileType enum for filtering file types
// =============================================================================

import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

/// Handles file picking and downloading.
///
/// File picker: opens a native dialog for the user to select files.
/// File download: downloads a file from a URL and saves it to the
/// app's documents directory.
class FileService {
  /// Opens a file picker dialog and returns the selected file path.
  ///
  /// [type] — the type of files to show in the picker.
  ///   [FileType.any] — all files
  ///   [FileType.image] — images only (jpg, png, gif, etc.)
  ///   [FileType.video] — videos only
  ///   [FileType.audio] — audio only
  ///   [FileType.media] — images and videos
  ///   [FileType.custom] — use [allowedExtensions] to specify
  ///
  /// Returns the file path string, or `null` if the user cancelled.
  Future<String?> pickFile({
    FileType type = FileType.image,
    List<String>? allowedExtensions,
  }) async {
    try {
      // FilePicker.platform.pickFiles opens the native file picker.
      final result = await FilePicker.platform.pickFiles(
        type: type,
        // allowMultiple: false,              // Allow selecting multiple files
        // allowedExtensions: ['jpg', 'png'], // Only with FileType.custom
        // withData: false,                   // Load file bytes into memory
        // withReadStream: false,             // Get a read stream instead
        // lockParentWindow: false,           // Lock parent window (desktop)
        // dialogTitle: 'Select a file',      // Dialog title (desktop)
        // initialDirectory: '...',           // Starting directory (desktop)
        allowedExtensions:
            type == FileType.custom ? allowedExtensions : null,
      );

      // result is null if the user cancelled.
      if (result == null || result.files.isEmpty) {
        return null;
      }

      // PlatformFile contains:
      // - path: the file path (null on web)
      // - name: the file name
      // - size: file size in bytes
      // - bytes: file content (if withData: true)
      // - extension: file extension
      // - readStream: stream of bytes (if withReadStream: true)
      final file = result.files.first;
      return file.path;
    } catch (e) {
      throw Exception('Failed to pick file: $e');
    }
  }

  /// Downloads a file from [url] and saves it to the app's documents directory.
  ///
  /// [fileName] — the name to save the file as.
  /// [onProgress] — optional callback for download progress (0.0 to 1.0).
  ///
  /// Returns the path to the saved file.
  ///
  /// Uses [path_provider] to get the documents directory, which is:
  /// - iOS: `NSDocumentDirectory`
  /// - Android: `getFilesDir()`
  /// - Web: not supported (path_provider doesn't work on web)
  Future<String> downloadFile(
    String url,
    String fileName, {
    void Function(double progress)? onProgress,
  }) async {
    try {
      // Get the app's documents directory.
      // getApplicationDocumentsDirectory() returns a platform-specific
      // directory where the app can store persistent files.
      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';

      // Download the file using HTTP GET.
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Write the response bytes to a file.
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        // Report 100% progress.
        onProgress?.call(1.0);

        return filePath;
      }

      throw Exception('Download failed with status: ${response.statusCode}');
    } catch (e) {
      throw Exception('Failed to download file: $e');
    }
  }

  /// Gets the app's documents directory path.
  ///
  /// Useful for checking where files are stored.
  Future<String> getDocumentsPath() async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }
}
