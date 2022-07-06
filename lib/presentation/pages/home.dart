import 'package:counter_weather_theme/cubit/counter/counter_cubit.dart';
import 'package:counter_weather_theme/cubit/weather/weather_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title, this.onIncrement})
      : super(key: key);

  final String title;
  Function()? onIncrement;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void _incrementCounter() {
    widget.onIncrement!();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocBuilder<WeatherCubit, WeatherState>(
              builder: (context, state) {
                if(state is WeatherLoading){
                  return const CircularProgressIndicator();
                }
                if(state is WeatherSuccess){
                  return Text(state.data.toString());
                }
                if(state is WeatherError){
                  return Text("Error: ${state.error}");
                }
                return const Text("get current location using cloud button");
              },
            ),
            Center(
              child: BlocBuilder<CounterCubit, CounterState>(
                builder: (context, state) {
                  return Text(
                    state.counterValue.toString(),
                    style: Theme.of(context).textTheme.headline4,
                  );
                },
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(
                    onPressed: (){
                      BlocProvider.of<WeatherCubit>(context)
                          .getCurrentWeather();
        },
                    child: const Icon(Icons.cloud),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FloatingActionButton(
                    onPressed: _incrementCounter,
                    child: const Icon(Icons.extension),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<CounterCubit, CounterState>(
                    builder: (context, state) {
                      return AnimatedOpacity(
                        curve: Curves.easeInOutCubic,
                        opacity: state.counterValue == 10 ? 0 : 1,
                        duration: const Duration(milliseconds: 600),
                        child: FloatingActionButton(
                          onPressed: () =>
                              BlocProvider.of<CounterCubit>(context)
                                  .increment(),
                          child: const Icon(Icons.add),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  BlocBuilder<CounterCubit, CounterState>(
                    builder: (context, state) {
                      return AnimatedOpacity(
                        curve: Curves.easeInOutCubic,
                        duration: const Duration(milliseconds: 600),
                        opacity: state.counterValue == 0 ? 0 : 1,
                        child: FloatingActionButton(
                          onPressed: () =>
                              BlocProvider.of<CounterCubit>(context)
                                  .decrement(),
                          child: const Icon(Icons.remove),
                        ),
                      );
                    },
                  )
                ],
              )
            ],
          ),
        ));
  }
}
