class CalendarEvent {
  final String uid;
  final DateTime day;
  final bool isLowCost;
  final double price;
  final bool? acceptDnn;

  CalendarEvent({
    required this.uid,
    required this.day,
    required this.isLowCost,
    required this.price,
    this.acceptDnn,
  });

  CalendarEvent.test1()
      : this(
          uid: 'aa',
          day: DateTime.now().add(const Duration(days: 1)),
          isLowCost: true,
          price: 65,
        );
  CalendarEvent.test2()
      : this(
          uid: 'bb',
          day: DateTime.now().add(const Duration(days: 4)),
          isLowCost: false,
          price: 100,
        );
  CalendarEvent.test3()
      : this(
          uid: 'cc',
          day: DateTime.now().add(const Duration(days: 7)),
          isLowCost: false,
          price: 100,
        );

  static get calendarList => [
        CalendarEvent.test1(),
        CalendarEvent.test2(),
        CalendarEvent.test3(),
      ];
}
