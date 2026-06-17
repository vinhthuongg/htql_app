import 'dart:io';

import 'package:dio/dio.dart';
import 'package:htql_app/data/api/api_constants.dart';
import 'package:htql_app/services/storage_service.dart';
import 'package:path_provider/path_provider.dart';

class AvatarStorageService {
  AvatarStorageService._();

  static final AvatarStorageService instance = AvatarStorageService._();

  static const String _avatarPathKey = 'auth_avatar_path';
  static const String _avatarFileNameKey = 'auth_avatar_file_name';
  static const String _avatarLastAttemptAtKey = 'auth_avatar_last_attempt_at';
  static const String _avatarLastAttemptFileNameKey =
      'auth_avatar_last_attempt_file_name';
  static const Duration _retryDelay = Duration(minutes: 5);

  final Dio _dio = Dio();
  Future<File?>? _downloadFuture;
  String? _downloadFileName;

  String get localAvatarPath {
    return StorageService.instance.getString(_avatarPathKey);
  }

  String get localAvatarFileName {
    return StorageService.instance.getString(_avatarFileNameKey);
  }

  File? getLocalAvatarFile(String? avatarFileName) {
    final cleanedFileName = avatarFileName?.trim();
    if (cleanedFileName == null || cleanedFileName.isEmpty) return null;
    if (cleanedFileName != localAvatarFileName) return null;

    final path = localAvatarPath;
    if (path.isEmpty) return null;

    final file = File(path);
    if (!file.existsSync()) return null;

    return file;
  }

  Future<File?> cacheAvatar(String? avatarFileName) async {
    final cleanedFileName = avatarFileName?.trim();
    if (cleanedFileName == null || cleanedFileName.isEmpty) {
      await clearAvatar();
      return null;
    }

    final cachedFile = getLocalAvatarFile(cleanedFileName);
    if (cachedFile != null) return cachedFile;

    if (_isWaitingForRetry(cleanedFileName)) return null;

    if (_downloadFuture != null && _downloadFileName == cleanedFileName) {
      return _downloadFuture;
    }

    _downloadFileName = cleanedFileName;
    _downloadFuture = _downloadAvatar(cleanedFileName);

    try {
      return await _downloadFuture;
    } finally {
      _downloadFuture = null;
      _downloadFileName = null;
    }
  }

  Future<File?> _downloadAvatar(String avatarFileName) async {
    final avatarDirectory = await _avatarDirectory;
    await _saveDownloadAttempt(avatarFileName);
    await _deleteCachedAvatarFile();
    await avatarDirectory.create(recursive: true);

    final file = File(
      '${avatarDirectory.path}/${_localFileName(avatarFileName)}',
    );

    try {
      await _dio.download(ApiConstants.avatarUrl(avatarFileName), file.path);
      await StorageService.instance.setString(_avatarPathKey, file.path);
      await StorageService.instance.setString(
        _avatarFileNameKey,
        avatarFileName,
      );

      return file;
    } catch (_) {
      if (await file.exists()) {
        await file.delete();
      }

      return null;
    }
  }

  Future<void> clearAvatar() async {
    await _deleteCachedAvatarFile();
    await StorageService.instance.remove(_avatarLastAttemptAtKey);
    await StorageService.instance.remove(_avatarLastAttemptFileNameKey);
  }

  Future<void> _deleteCachedAvatarFile() async {
    final path = localAvatarPath;
    if (path.isNotEmpty) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }

    await StorageService.instance.remove(_avatarPathKey);
    await StorageService.instance.remove(_avatarFileNameKey);
  }

  bool _isWaitingForRetry(String avatarFileName) {
    final lastAttemptFileName = StorageService.instance.getString(
      _avatarLastAttemptFileNameKey,
    );
    if (lastAttemptFileName != avatarFileName) return false;

    final lastAttemptAt = StorageService.instance.getInt(
      _avatarLastAttemptAtKey,
    );
    if (lastAttemptAt <= 0) return false;

    final elapsedMilliseconds =
        DateTime.now().millisecondsSinceEpoch - lastAttemptAt;

    return elapsedMilliseconds < _retryDelay.inMilliseconds;
  }

  Future<void> _saveDownloadAttempt(String avatarFileName) async {
    await StorageService.instance.setString(
      _avatarLastAttemptFileNameKey,
      avatarFileName,
    );
    await StorageService.instance.setInt(
      _avatarLastAttemptAtKey,
      DateTime.now().millisecondsSinceEpoch,
    );
  }

  String _localFileName(String avatarFileName) {
    if (!avatarFileName.startsWith('http')) return avatarFileName;

    final uri = Uri.tryParse(avatarFileName);
    final pathSegments = uri?.pathSegments;
    if (pathSegments == null || pathSegments.isEmpty) {
      return 'avatar.jpg';
    }

    return pathSegments.last;
  }

  Future<Directory> get _avatarDirectory async {
    final documentsDirectory = await getApplicationDocumentsDirectory();
    return Directory('${documentsDirectory.path}/avatars');
  }
}
