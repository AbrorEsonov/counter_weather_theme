part of 'theme_cubit.dart';

class ThemeState extends Equatable {

  bool isDark;

  ThemeState({required this.isDark});
  @override
  List<Object?> get props => [isDark];

}

