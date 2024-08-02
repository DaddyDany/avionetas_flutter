import '../../data/models/avioneta_model.dart';

abstract class AvionetaState {}

class AvionetaInitial extends AvionetaState {}

class AvionetaLoading extends AvionetaState {}

class AvionetaLoaded extends AvionetaState {
  final List<Avioneta> avionetas;

  AvionetaLoaded(this.avionetas);
}

class AvionetaError extends AvionetaState {
  final String message;

  AvionetaError(this.message);
}
