class QuotationListItem {
  final int quotationId;
  final String quoteNo;
  final DateTime quoteDate;
  final double subTotal;
  final double taxTotal;
  final double grandTotal;
  final String status;

  final int customerId;
  final String customerName;
  final String? email;
  final String? mobile;

  QuotationListItem({
    required this.quotationId,
    required this.quoteNo,
    required this.quoteDate,
    required this.subTotal,
    required this.taxTotal,
    required this.grandTotal,
    required this.status,
    required this.customerId,
    required this.customerName,
    this.email,
    this.mobile,
  });
}
