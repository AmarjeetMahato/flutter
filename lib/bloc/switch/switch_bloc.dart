import 'package:bloc/bloc.dart';
import 'package:flutter_widgets/bloc/switch/switch_events.dart';
import 'package:flutter_widgets/bloc/switch/switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvents, SwitchState> {
  SwitchBloc() : super(SwitchState()) {
    on<EnableorDisableNotification>(_enableOrDisableNotification);
    on<SliderEvent>(_slider);
  }

  void _enableOrDisableNotification(
    EnableorDisableNotification event,
    Emitter<SwitchState> emit,
  ) {
    emit(state.copyWith(isSwitch: !state.isSwitch));
  }

  void _slider(SliderEvent event, Emitter<SwitchState> emit) {
    emit(state.copyWith(slider: event.slider));
  }
}
