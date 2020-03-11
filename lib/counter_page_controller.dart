import 'package:mobx/mobx.dart';
part 'counter_page_controller.g.dart';

class CounterPageoController = _CounterPageoControllerBase
    with _$CounterPageoController;

abstract class _CounterPageoControllerBase with Store {
  @observable
  int counter = 0;

  @action
  increment() => counter++;
}
