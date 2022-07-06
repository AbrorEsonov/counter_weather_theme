part of 'counter_cubit.dart';

class CounterState extends Equatable {
  int counterValue;
  bool? isDark;
  CounterState({required this.counterValue, this.isDark});
  @override
  List<Object?> get props => [counterValue];
}

