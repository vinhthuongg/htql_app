import 'package:flutter/material.dart';

class DocumentItem {
  const DocumentItem({
    required this.id,
    required this.title,
    required this.uploader,
    required this.type,
    required this.fileName,
  });

  final String id;
  final String title;
  final String uploader;
  final String type;
  final String fileName;
}

class DocsProvider extends ChangeNotifier {
  final List<DocumentItem> _documents = const [];

  String _searchKeyword = '';
  String? _expandedDocumentId;

  String get searchKeyword => _searchKeyword;
  String? get expandedDocumentId => _expandedDocumentId;

  List<DocumentItem> get filteredDocuments {
    final keyword = _searchKeyword.trim().toLowerCase();
    if (keyword.isEmpty) return _documents;

    return _documents.where((document) {
      return document.title.toLowerCase().contains(keyword) ||
          document.uploader.toLowerCase().contains(keyword) ||
          document.type.toLowerCase().contains(keyword) ||
          document.fileName.toLowerCase().contains(keyword);
    }).toList();
  }

  void setSearchKeyword(String keyword) {
    _searchKeyword = keyword;
    notifyListeners();
  }

  void toggleDocument(String documentId) {
    _expandedDocumentId = _expandedDocumentId == documentId ? null : documentId;
    notifyListeners();
  }
}
