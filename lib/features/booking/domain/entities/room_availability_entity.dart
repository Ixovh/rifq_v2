import 'package:equatable/equatable.dart';

class RoomAvailabilityIssueEntity extends Equatable {
  final String roomId;
  final String roomName;
  final int requestedQuantity;
  final int availableQuantity;

  const RoomAvailabilityIssueEntity({
    required this.roomId,
    required this.roomName,
    required this.requestedQuantity,
    required this.availableQuantity,
  });

  @override
  List<Object?> get props => [
    roomId,
    roomName,
    requestedQuantity,
    availableQuantity,
  ];
}
