class GetShoppingCartResponse {
  String? id;
  bool? hasCartOpen;
  bool? hasPaymentAwaiting;

  GetShoppingCartResponse({
    this.id,
    this.hasCartOpen,
    this.hasPaymentAwaiting,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'hasCartOpen': hasCartOpen,
      'hasPaymentAwaiting': hasPaymentAwaiting,
    };
  }

  factory GetShoppingCartResponse.fromJson(Map<String, dynamic> map) {
    return GetShoppingCartResponse(
      id: map['id'] != null ? map['id'] as String : null,
      hasPaymentAwaiting: map['hasPaymentAwaiting'] != null
          ? map['hasPaymentAwaiting'] as bool
          : null,
      hasCartOpen:
          map['hasCartOpen'] != null ? map['hasCartOpen'] as bool : null,
    );
  }
}
