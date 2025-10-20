abstract class PaymentStatus {
  static const String APROVVED = 'approved';
  static const String IN_PROCESS = 'in_process';
  static const String REJECTED = 'rejected';
  static const String PENDING = 'pending';
  static const String REFUNDED = 'refunded';
  static const String EXPIRED = 'expired';
  static const String CANCELLED = 'cancelled';
  static const String PAID = 'paid';
}

abstract class PaymentEnum {
  static const int PURCHASE = 1;
  static const int RENEWAL = 2;
  static const int SCHEDULE = 3;
}
