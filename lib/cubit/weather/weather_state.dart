part of 'weather_cubit.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherSuccess extends WeatherState{
  final String data;
  WeatherSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class WeatherError extends WeatherState{

  final String error;
  WeatherError({required this.error});
  @override
  List<Object?> get props => [error];
}


