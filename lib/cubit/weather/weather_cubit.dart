import 'package:bloc/bloc.dart';
import 'package:counter_weather_theme/repository/weather_repo.dart';
import 'package:equatable/equatable.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this.weatherRepository) : super(WeatherInitial());

  WeatherRepository weatherRepository;

   getCurrentWeather(){
    emit(WeatherLoading());
    weatherRepository.getAll().then((value){
      print("object");
      emit(WeatherSuccess(data: value));
    }).onError((error, stackTrace) {
      emit(WeatherError(error: error.toString()));
    });
  }
}
