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
  final List<DocumentItem> _documents = const [
    DocumentItem(
      id: 'doc_001',
      title: 'Quy định nghỉ phép năm',
      uploader: 'Phòng HCNS',
      type: 'Quy định',
      fileName: 'quy_dinh_nghi_phep_nam.pdf',
    ),
    DocumentItem(
      id: 'doc_002',
      title: 'Hướng dẫn chấm công',
      uploader: 'Nguyễn Văn B',
      type: 'Hướng dẫn',
      fileName: 'huong_dan_cham_cong.pdf',
    ),
    DocumentItem(
      id: 'doc_003',
      title: 'Mẫu đề nghị thanh toán',
      uploader: 'Phòng Kế toán',
      type: 'Biểu mẫu',
      fileName: 'mau_de_nghi_thanh_toan.pdf',
    ),
    DocumentItem(
      id: 'doc_004',
      title: 'Quy trình bổ nhiệm nhân sự',
      uploader: 'Phòng Nhân sự',
      type: 'Quy trình',
      fileName: 'quy_trinh_bo_nhiem_nhan_su.pdf',
    ),
    DocumentItem(
      id: 'doc_005',
      title: 'Chính sách khen thưởng',
      uploader: 'Toyota Kiên Giang',
      type: 'Chính sách',
      fileName: 'chinh_sach_khen_thuong.pdf',
    ),
  ];

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
