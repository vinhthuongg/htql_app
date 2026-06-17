import 'package:flutter/material.dart';

class RewardRecord {
  const RewardRecord({
    required this.year,
    required this.date,
    required this.type,
    required this.content,
    required this.points,
    required this.note,
  });

  final int year;
  final String date;
  final String type;
  final String content;
  final int points;
  final String note;
}

class RewardGift {
  const RewardGift({
    required this.name,
    required this.description,
    required this.points,
    required this.stock,
  });

  final String name;
  final String description;
  final int points;
  final int stock;
}

class RewardProvider extends ChangeNotifier {
  final List<int> years = const [2026, 2025, 2024, 2023];
  final List<String> tabs = const [
    'Khen thưởng',
    'Kỷ luật',
    'Đổi quà',
    'Lịch sử đổi quà',
  ];

  int _selectedYear = 2026;
  int _selectedTabIndex = 0;
  String _searchKeyword = '';

  final List<RewardRecord> _rewardRecords = const [];
  final List<RewardRecord> _disciplineRecords = const [];
  final List<RewardRecord> _exchangeHistories = const [];
  final List<RewardGift> _gifts = const [];

  int get selectedYear => _selectedYear;
  int get selectedTabIndex => _selectedTabIndex;
  String get selectedTab => tabs[_selectedTabIndex];
  String get searchKeyword => _searchKeyword;
  bool get isGiftTab => _selectedTabIndex == 2;
  int get rewardCount => _recordsByYear(_rewardRecords).length;
  int get disciplineCount => _recordsByYear(_disciplineRecords).length;
  int get yearPoints {
    final rewardPoints = _recordsByYear(
      _rewardRecords,
    ).fold<int>(0, (total, record) => total + record.points);
    final exchangedPoints = _recordsByYear(
      _exchangeHistories,
    ).fold<int>(0, (total, record) => total + record.points);

    return rewardPoints - exchangedPoints;
  }

  int get totalPoints {
    final rewardPoints = _rewardRecords.fold<int>(
      0,
      (total, record) => total + record.points,
    );
    final exchangedPoints = _exchangeHistories.fold<int>(
      0,
      (total, record) => total + record.points,
    );

    return rewardPoints - exchangedPoints;
  }

  int get remainingGiftPoints => totalPoints;

  List<RewardRecord> get filteredRecords {
    final records = _recordsByYear(switch (_selectedTabIndex) {
      1 => _disciplineRecords,
      3 => _exchangeHistories,
      _ => _rewardRecords,
    });

    final keyword = _searchKeyword.trim().toLowerCase();
    if (keyword.isEmpty) return records;

    return records.where((record) {
      return record.date.toLowerCase().contains(keyword) ||
          record.type.toLowerCase().contains(keyword) ||
          record.content.toLowerCase().contains(keyword) ||
          record.note.toLowerCase().contains(keyword);
    }).toList();
  }

  List<RewardRecord> _recordsByYear(List<RewardRecord> records) {
    return records.where((record) => record.year == _selectedYear).toList();
  }

  List<RewardGift> get filteredGifts {
    final keyword = _searchKeyword.trim().toLowerCase();
    if (keyword.isEmpty) return _gifts;

    return _gifts.where((gift) {
      return gift.name.toLowerCase().contains(keyword) ||
          gift.description.toLowerCase().contains(keyword);
    }).toList();
  }

  void setSelectedYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }

  void setSelectedTabIndex(int index) {
    _selectedTabIndex = index;
    _searchKeyword = '';
    notifyListeners();
  }

  void setSearchKeyword(String keyword) {
    _searchKeyword = keyword;
    notifyListeners();
  }

  String get searchHint {
    switch (_selectedTabIndex) {
      case 1:
        return 'Tìm kiếm kỷ luật...';
      case 2:
        return 'Tìm kiếm quà...';
      case 3:
        return 'Tìm kiếm lịch sử đổi quà...';
      default:
        return 'Tìm kiếm khen thưởng...';
    }
  }

  String get emptyMessage {
    switch (_selectedTabIndex) {
      case 1:
        return 'Chưa có dữ liệu kỷ luật';
      case 2:
        return 'Chưa có quà phù hợp';
      case 3:
        return 'Chưa có lịch sử đổi quà';
      default:
        return 'Chưa có dữ liệu khen thưởng';
    }
  }
}
