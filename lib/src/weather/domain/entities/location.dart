import 'package:equatable/equatable.dart';

class Location extends Equatable {
  const Location({this.localTime, this.name});

  final String? name;
  final String? localTime;

  @override
  List<Object?> get props => [name, localTime];
}
