import 'package:etourism_app/Utils/customColors.dart';
import 'package:etourism_app/components/custom_Appbar.dart';
import 'package:etourism_app/models/room.model.dart';
import 'package:etourism_app/provider/booking.provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

enum BookingStep { booking, payment }

class RoomBookingScreen extends StatefulWidget {
  final RoomModel roomDetails;
  RoomBookingScreen({super.key, required this.roomDetails});

  @override
  State<RoomBookingScreen> createState() => _RoomBookingScreenState();
}

class _RoomBookingScreenState extends State<RoomBookingScreen> {
  BookingStep currentStep = BookingStep.booking;
  DateTimeRange? dateRange;
  int adults = 2;
  int children = 1;
  int babies = 0;

  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    if (args.value is PickerDateRange) {
      final start = args.value.startDate;
      final end = args.value.endDate ?? args.value.startDate;
      setState(() {
        dateRange = DateTimeRange(start: start, end: end);
      });
    }
  }

  void _goToPayment() {
    setState(() {
      currentStep = BookingStep.payment;
    });
  }

  void _goBackToBooking() {
    setState(() {
      currentStep = BookingStep.booking;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Room Booking", showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: switch (currentStep) {
          BookingStep.booking => BookingComponent(
              dateRange: dateRange,
              adults: adults,
              children: children,
              babies: babies,
              onSelectionChanged: _onSelectionChanged,
              onAdultsChanged: (value) => setState(() => adults = value),
              onChildrenChanged: (value) => setState(() => children = value),
              onBabiesChanged: (value) => setState(() => babies = value),
              onConfirm: _goToPayment,
            ),
          BookingStep.payment => PaymentComponent(
              onBack: _goBackToBooking,
              onConfirm: (double totalPayment) {
                Provider.of<BookingProvider>(context, listen: false)
                    .requestBooking(context, {
                  'roomId': widget.roomDetails.id,
                  'checkInDate': dateRange!.start.toIso8601String(),
                  'checkOutDate': dateRange!.end.toIso8601String(),
                  'totalPrice': totalPayment,
                  'paymentMethod':
                      'CreditCard', // You might want to make this dynamic
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Payment Confirmed!')),
                );
              },
              dateRange: dateRange!,
              roomDetails: widget.roomDetails,
              adults: adults,
              children: children,
              babies: babies,
            ),
        },
      ),
    );
  }
}

class BookingComponent extends StatelessWidget {
  final DateTimeRange? dateRange;
  final int adults;
  final int children;
  final int babies;
  final Function(DateRangePickerSelectionChangedArgs) onSelectionChanged;
  final Function(int) onAdultsChanged;
  final Function(int) onChildrenChanged;
  final Function(int) onBabiesChanged;
  final VoidCallback onConfirm;

  const BookingComponent({
    Key? key,
    required this.dateRange,
    required this.adults,
    required this.children,
    required this.babies,
    required this.onSelectionChanged,
    required this.onAdultsChanged,
    required this.onChildrenChanged,
    required this.onBabiesChanged,
    required this.onConfirm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String rangeText = dateRange == null
        ? 'Select Date Range'
        : '${DateFormat('dd MMM yyyy').format(dateRange!.start)} - ${DateFormat('dd MMM yyyy').format(dateRange!.end)}';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: CustomColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            rangeText,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: CustomColors.primaryColor),
          ),
        ),
        SizedBox(height: 16.0),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border:
                Border.all(color: CustomColors.primaryColor.withOpacity(0.3)),
          ),
          child: SfDateRangePicker(
            onSelectionChanged: onSelectionChanged,
            selectionMode: DateRangePickerSelectionMode.range,
            selectionColor: CustomColors.primaryColor,
            startRangeSelectionColor: CustomColors.primaryColor,
            endRangeSelectionColor: CustomColors.primaryColor,
            rangeSelectionColor: CustomColors.primaryColor.withOpacity(0.1),
            todayHighlightColor: CustomColors.primaryColor,
            backgroundColor: Colors.grey[100],
            allowViewNavigation: true,
            enablePastDates: false,
            headerHeight: 50,
            viewSpacing: 20,
            monthViewSettings: DateRangePickerMonthViewSettings(
              viewHeaderStyle: DateRangePickerViewHeaderStyle(
                textStyle: TextStyle(
                    fontSize: 16,
                    color: CustomColors.primaryColor,
                    fontWeight: FontWeight.w500),
              ),
              dayFormat: 'EEE',
            ),
            yearCellStyle: DateRangePickerYearCellStyle(
              textStyle: TextStyle(fontSize: 16, color: Colors.black),
              todayTextStyle:
                  TextStyle(fontSize: 16, color: CustomColors.primaryColor),
            ),
            monthCellStyle: DateRangePickerMonthCellStyle(
              textStyle: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w500),
              todayTextStyle: TextStyle(
                  fontSize: 16,
                  color: CustomColors.primaryColor,
                  fontWeight: FontWeight.w500),
            ),
            headerStyle: DateRangePickerHeaderStyle(
              textStyle: TextStyle(
                  color: CustomColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
          ),
        ),
        SizedBox(height: 16.0),
        buildGuestSelector('Adult', adults, () => onAdultsChanged(adults - 1),
            () => onAdultsChanged(adults + 1)),
        buildGuestSelector(
            'Children',
            children,
            () => onChildrenChanged(children - 1),
            () => onChildrenChanged(children + 1)),
        buildGuestSelector(
            'Kids (Baby)',
            babies,
            () => onBabiesChanged(babies - 1),
            () => onBabiesChanged(babies + 1)),
        Spacer(),
        ElevatedButton(
          onPressed: dateRange != null ? onConfirm : null,
          child: Text('Proceed to Payment'),
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomColors.primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.symmetric(vertical: 16.0),
            minimumSize: Size(double.infinity, 50),
          ),
        ),
      ],
    );
  }

  Widget buildGuestSelector(String label, int count, VoidCallback onDecrement,
      VoidCallback onIncrement) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: TextStyle(fontWeight: FontWeight.w500, fontSize: 20)),
          Row(
            children: [
              IconButton(
                onPressed: onDecrement,
                icon: Icon(Icons.remove_circle_outline,
                    color: CustomColors.primaryColor),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: CustomColors.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  count.toString(),
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: CustomColors.primaryColor),
                ),
              ),
              IconButton(
                onPressed: onIncrement,
                icon: Icon(Icons.add_circle_outline,
                    color: CustomColors.primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PaymentComponent extends StatelessWidget {
  final VoidCallback onBack;
  final Function(double totalPayment) onConfirm;
  final DateTimeRange dateRange;
  final RoomModel roomDetails;
  final int adults;
  final int children;
  final int babies;

  const PaymentComponent({
    Key? key,
    required this.onBack,
    required this.onConfirm,
    required this.dateRange,
    required this.roomDetails,
    required this.adults,
    required this.children,
    required this.babies,
  }) : super(key: key);

  int get numberOfDays => dateRange.duration.inDays + 1;
  double get totalRentalPrice => roomDetails.price * numberOfDays;
  double get serviceFee => totalRentalPrice * 0.1; // 10% service fee
  double get tax => totalRentalPrice * 0.05; // 5% tax
  double get totalPayment => totalRentalPrice + serviceFee + tax;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Choice Of Destination',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 4),
        Text(
          '${DateFormat('dd MMM yyyy').format(dateRange.start)} - ${DateFormat('dd MMM yyyy').format(dateRange.end)}',
          style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w400),
        ),
        SizedBox(height: 25),
        Row(
          children: [
            Image.network(
              roomDetails.photos!.first,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${roomDetails.roomNumber}",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    roomDetails.description ?? '',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        Divider(height: 32, thickness: 1),
        Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 16),
        Row(
          children: [
            Icon(Icons.credit_card, size: 40, color: Colors.orange),
            SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '5543 9929 0013 9925',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'a.n Bessie Cooper',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: () {
                // Add your change payment method action here
              },
              child: Text(
                'Change',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        Divider(height: 32, thickness: 1),
        Text(
          'Price Details',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 16),
        _buildPriceDetailRow('Rental Price ($numberOfDays Days)',
            '\$${totalRentalPrice.toStringAsFixed(2)}'),
        _buildPriceDetailRow(
            'Service Fee', '\$${serviceFee.toStringAsFixed(2)}'),
        _buildPriceDetailRow('Tax', '\$${tax.toStringAsFixed(2)}'),
        SizedBox(height: 8),
        Divider(height: 32, thickness: 1),
        _buildPriceDetailRow(
          'Total Payment',
          '\$${totalPayment.toStringAsFixed(2)}',
          isBold: true,
        ),
        Spacer(),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: onBack,
                child: Text('Back'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => onConfirm(totalPayment),
                child: Text('Purchase'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: CustomColors.primaryColor,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 16.0),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPriceDetailRow(String label, String value,
      {bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
