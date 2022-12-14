import 'dart:async';

const int fourthFloor = 4;

class FloorManager {
  final StreamController<FloorModel> _streamController = StreamController();

  Stream<FloorModel> get currentFloor => _streamController.stream;

  static const int _maxFloor = 6;
  static const int _firstFloor = 1;

  static const Duration _elevatorSpeed = Duration(seconds: 2);
  static const Duration _waitingOnFloor = Duration(seconds: 4);
  int _floor = _firstFloor;
  ElevatorState _floorState = ElevatorState.rises;

  Future<void> start() async {
    _streamController.add(FloorModel(floor: _floor, doorState: ElevatorDoorState.closed));
    while (true) {
      await Future.delayed(_elevatorSpeed).then((_) async {
        if (_floor <= _firstFloor) {
          _floorState = ElevatorState.rises;
        } else if (_floor == fourthFloor) {
          _streamController.add(FloorModel(floor: _floor, doorState: ElevatorDoorState.isOpening));
          await Future.delayed(_waitingOnFloor);
          _streamController.add(FloorModel(floor: _floor, doorState: ElevatorDoorState.isClosing));
          await Future.delayed(_waitingOnFloor);
        } else if (_floor >= _maxFloor) {
          _floorState = ElevatorState.descends;
        }

        switch (_floorState) {
          case ElevatorState.rises:
            _floor++;
            break;
          case ElevatorState.descends:
            _floor--;
            break;
          case ElevatorState.stands:
            break;
        }

        _streamController.add(FloorModel(floor: _floor, doorState: ElevatorDoorState.closed));
      });
    }
  }
}

class FloorModel {
  final int floor;
  final ElevatorDoorState doorState;

  const FloorModel({
    required this.floor,
    required this.doorState,
  });

  @override
  String toString() => 'FloorModel(floor: $floor, doorState: $doorState)';
}

enum ElevatorState {
  rises,
  descends,
  stands,
}

enum ElevatorDoorState {
  isOpening,
  isClosing,
  closed,
  opened,
}
