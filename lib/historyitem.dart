import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';

part 'historyitem.g.dart';

// class HistoryItem = _HistoryItem with _$HistoryItem;

// @HiveType(typeId: 0)
// class _HistoryItem extends HiveObject with Store {
//   @HiveField(0)
//   late String title;
//   @HiveField(1)
//   late String subtitle;
// }

@HiveType(typeId: 0)
class HistoryItem extends HiveObject {
  @HiveField(0)
  late String title;
  @HiveField(1)
  late String subtitle;
  // HistoryItem(this.title, this.subtitle);
}
