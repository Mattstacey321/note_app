import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'private.g.dart';

@HiveType(typeId: 3)
class Private {
  @HiveField(0)
  String id;
  @HiveField(1)
  String type;
  @HiveField(2)
  String password;
  Private({@required this.id, this.type = "note", @required this.password});
}
