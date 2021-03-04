import '../repositories/times_repository.dart';
import '../models/time.dart';
import '../models/titulo.dart';

class HomeController {
  TimesRepository timesRepository;

  List<Time> get tabela => timesRepository.times;

  HomeController() {
    timesRepository = TimesRepository();
  }
}
