import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'This is testing project of language translation':
              'This is testing project of language translation',
          'change language tu other': 'change language tu other',
          'Testing': 'Testing',
        },
        'ar_AE': {
          'This is testing project of language translation':
              'هذا مشروع اختبار لترجمة اللغة',
          'change language tu other': 'تغيير اللغة إلى لغة أخرى',
          'Testing': 'اختبارات',
        },
      };
}
