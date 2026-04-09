import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_widgets/bloc/switch/switch_bloc.dart';
import 'package:flutter_widgets/bloc/switch/switch_events.dart';
import 'package:flutter_widgets/bloc/switch/switch_state.dart';

class SwitchScreen extends StatefulWidget {
  const SwitchScreen({super.key});

  @override
  State<SwitchScreen> createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Switch Example")),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Notification",
                  style: TextStyle(
                    color: Colors.black45,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                BlocBuilder<SwitchBloc, SwitchState>(
                  buildWhen: (previous, current) =>
                      previous.isSwitch != current.isSwitch,
                  builder: (context, state) {
                    return SizedBox(
                      width: 45, // Force a specific width
                      height: 35, // Force a specific height
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch(
                          value: state.isSwitch,
                          onChanged: (newValue) {
                            context.read<SwitchBloc>().add(
                              EnableorDisableNotification(),
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            SizedBox(height: 30),
            BlocBuilder<SwitchBloc, SwitchState>(
              builder: (context, state) {
                return Container(
                  height: 200,
                  color: Colors.green.withValues(alpha: state.slider),
                );
              },
            ),
            SizedBox(height: 50),
            BlocBuilder<SwitchBloc, SwitchState>(
              buildWhen: (previous, current) =>
                  previous.slider != current.slider,
              builder: (context, state) {
                return SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    trackHeight: 5.0, // Makes the bar thicker
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10),
                    overlayShape: RoundSliderOverlayShape(overlayRadius: 15),
                  ),
                  child: Slider(
                    value: state.slider,
                    activeColor: Colors.red, // Color of the bar on the left
                    inactiveColor: Colors.red.withValues(
                      alpha: 0.3,
                    ), // Bar on the right
                    thumbColor: Colors.white, // The draggable circle
                    onChanged: (value) {
                      context.read<SwitchBloc>().add(
                        SliderEvent(slider: value),
                      );
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
