import 'package:logger/logger.dart';

//Logger que exibe as respostas http em um formato humanizado.
class Logs {
  Logs._internal();

  final Logger _logger = Logger();

  static final Logs _instance = Logs._internal();
  static Logger get p => _instance._logger;
}
