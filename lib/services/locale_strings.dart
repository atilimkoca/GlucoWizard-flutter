import 'package:get/get.dart';

class LocaleStrings extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'tr_TR': {
          'Takip Çizelgesi': 'Takip Çizelgesi',
          'Eğitim Kılavuzu': 'Eğitim Kılavuzu',
          'Kan Şekeri Tahmini': 'Kan Şekeri Tahmini',
          'Diyabet Teşhisi': 'Diyabet Teşhisi'
        },
        'en_US': {
          'Takip Çizelgesi': 'Tracking Schedule',
          'Eğitim Kılavuzu': 'Training Guide',
          'Kan Şekeri Tahmini': 'Blood Sugar Prediction',
          'Diyabet Teşhisi': 'Diabetes Diagnosis'
        },
      };
}
