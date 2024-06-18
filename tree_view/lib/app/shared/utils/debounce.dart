import 'dart:async';

Function debounce(Function func,
    {Duration delay = const Duration(milliseconds: 500)}) {
  Timer? timer;
  return (Map<String, dynamic> args) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(delay, () => func(args));
  };
}
