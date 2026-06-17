class ApiConstants {
  ApiConstants._();

  static const String baseUrl = 'https://htql.toyotakiengiang.vn/api';
  static const String avatarBaseUrl =
      'https://htql.toyotakiengiang.vn/public/upload/avatars';

  static String avatarUrl(String fileName) {
    final cleanedFileName = fileName.trim();
    if (cleanedFileName.isEmpty) return '';
    if (cleanedFileName.startsWith('http')) return cleanedFileName;

    return '$avatarBaseUrl/$cleanedFileName';
  }
}
