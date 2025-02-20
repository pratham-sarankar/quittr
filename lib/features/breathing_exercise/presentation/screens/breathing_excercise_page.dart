import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quittr/features/breathing_exercise/presentation/bloc/breathing_bloc.dart';
import 'package:quittr/features/breathing_exercise/presentation/widgets/breathing_path_painter.dart';

class BreathingExcercisePage extends StatefulWidget {
  const BreathingExcercisePage({super.key});

  @override
  State<BreathingExcercisePage> createState() => _BreathingExcercisePageState();
}

class _BreathingExcercisePageState extends State<BreathingExcercisePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..addListener(() {
        context.read<BreathingBloc>().add(
              UpdateBreathingProgress(_controller.value),
            );
      });
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    BreathingBloc().close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height * 0.6;
    return BlocBuilder<BreathingBloc, BreathingState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFF1A1B2E),
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              // mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  state.breathingText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: width,
                  height: height,
                  child: CustomPaint(
                    painter: BreathingPathPainter(progress: state.progress),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _controller.stop();
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'Finish Exercise',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
