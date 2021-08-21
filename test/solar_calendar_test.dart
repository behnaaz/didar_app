import 'package:didar_app/services/calendar/solar_calendar.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shamsi_date/extensions.dart';

void main() async {
  group('Solar Calendar methods test', () {
    test('solarCalendar.now() method should be equal to local time and Date',
        () {
      Jalali solarDate = SolarCalendar().now();
      expect(solarDate, Jalali.now());
    });
  });
}
