import 'package:dnn_shared/dnn_shared.dart';

class OffersModelMock {
  late String cardText;
  late String path;
  late String imagePath;

  OffersModelMock({
    required this.cardText,
    required this.path,
    required this.imagePath,
  });

  static List<OffersModelMock> get offerMockList => [
        OffersModelMock(
          cardText: 'Show\nde Prêmios\nsorteios Mensal',
          path: 'categoria/premios/',
          imagePath: MediaRes.cardMedical,
        ),
        OffersModelMock(
          cardText: 'Filmes\npor streaming\nGrátis',
          path: 'categoria/gratuitos/',
          imagePath: MediaRes.cardCine,
        ),
        OffersModelMock(
          cardText: 'Cursos\nprofissionalizantes\nGrátis',
          path: 'categoria/gratuitos/',
          imagePath: MediaRes.cardLab,
        ),
        OffersModelMock(
          cardText: 'Curso\nde Inglês\nGrátis',
          path: 'categoria/educacao/',
          imagePath: MediaRes.cardCine,
        ),
        OffersModelMock(
          cardText: 'Ganhe\nDesconto de até 14%\nem aluguel de veículos',
          path: 'categoria/automotivo/',
          imagePath: MediaRes.cardLab,
        ),
      ];
}
