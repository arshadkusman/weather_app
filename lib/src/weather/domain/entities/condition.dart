import 'package:equatable/equatable.dart';

class Condition extends Equatable {
  const Condition({
    this.text,
    this.icon,
    this.code,
  });
  final String? text;
  final String? icon;
  final int? code;

  @override
  List<Object?> get props => [text, icon, code];
}
