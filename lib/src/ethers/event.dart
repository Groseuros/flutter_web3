part of 'ethers.dart';

class Event extends Log<_EventImpl> {
  const Event._(_EventImpl super.impl) : super._();

  factory Event.fromJS(dynamic jsObject) => Event._(jsObject as _EventImpl);

  String get event => impl.event;

  String get eventSignature => impl.eventSignature;

  List<dynamic> get args => impl.args;

  @override
  String toString() => 'Event: $event $eventSignature with args $args';
}
