class Transaction {
  final int userId;
  final String companyName;
  final String companyImg;
  final double navRate;
  final String navDate;
  final String investDate;
  final int orderNo;
  final double units;
  final int folioNo;
  final String transactionStatus;
  final double amount;

  Transaction({
    required this.userId,
    required this.companyName,
    required this.companyImg,
    required this.navRate,
    required this.navDate,
    required this.investDate,
    required this.orderNo,
    required this.units,
    required this.folioNo,
    required this.transactionStatus,
    required this.amount,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "companyName": companyName,
      "companyImg": companyImg,
      "navRate": navRate,
      "navDate": navDate,
      "investDate": investDate,
      "orderNo": orderNo,
      "units": units,
      "folioNo": folioNo,
      "transactionStatus": transactionStatus,
      "amount": amount,
    };
  }
}
