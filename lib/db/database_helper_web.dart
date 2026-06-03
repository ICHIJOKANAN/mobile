import 'dart:convert';
import 'dart:html' as html;
import '../models/record.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  List<Record> _records = [];

  DatabaseHelper._privateConstructor() {
    try {
      _loadFromStorage();
    } catch (e) {
      print('Error loading records from localStorage: $e');
      _records = [];
    }
  }

  void _loadFromStorage() {
    try {
      final jsonStr = html.window.localStorage['household_records'];
      if (jsonStr != null && jsonStr.isNotEmpty) {
        final list = json.decode(jsonStr) as List<dynamic>;
        _records = list.map((e) => Record.fromMap(Map<String, dynamic>.from(e))).toList();
        print('Loaded ${_records.length} records from localStorage');
      }
    } catch (e) {
      print('Error parsing localStorage: $e');
      _records = [];
    }
  }

  void _saveToStorage() {
    try {
      final list = _records.map((r) => r.toMap()).toList();
      html.window.localStorage['household_records'] = json.encode(list);
      print('Saved ${_records.length} records to localStorage');
    } catch (e) {
      print('Error saving to localStorage: $e');
    }
  }

  Future<Record> insertRecord(Record record) async {
    final nextId = (_records.isEmpty) ? 1 : (_records.map((r) => r.id ?? 0).reduce((a, b) => a > b ? a : b) + 1);
    record.id = nextId;
    _records.insert(0, record);
    _saveToStorage();
    return record;
  }

  Future<List<Record>> getRecords() async {
    return List<Record>.from(_records);
  }

  Future<void> close() async {}
}
