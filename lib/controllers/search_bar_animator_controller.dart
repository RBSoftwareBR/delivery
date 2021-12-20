import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';
class SearchBarAnimatorController extends BlocBase{
  BehaviorSubject<double> topController = BehaviorSubject<double>();
  Stream<double> get outTop => topController.stream;
  Sink<double> get inTop => topController.sink;
double top;
  SearchBarAnimatorController(this.top){
    inTop.add(top);
  }
}