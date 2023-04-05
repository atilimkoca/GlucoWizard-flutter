import 'package:flutter/material.dart';
import 'package:glucowizard_flutter/providers/language_provider.dart';
import 'package:popup_banner/popup_banner.dart';

import 'package:provider/provider.dart';
import 'package:vertical_card_pager/vertical_card_pager.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../providers/health_page_provider.dart';

class HealthGridView extends StatelessWidget {
  final List<Widget> images = [
    ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.asset('assets/images/glucose_measurement.jpg',
          fit: BoxFit.cover),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.asset('assets/images/insulin.jpg', fit: BoxFit.cover),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.asset('assets/images/foot.jpg', fit: BoxFit.cover),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.asset('assets/images/nutrition.jpg', fit: BoxFit.cover),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.asset('assets/images/exercise.jpg', fit: BoxFit.cover),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.asset('assets/images/hipoglisemi.jpg', fit: BoxFit.cover),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.asset('assets/images/hiperglisemi.jpg', fit: BoxFit.cover),
    ),
    ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Image.asset('assets/images/drugs2.jpg', fit: BoxFit.cover),
    ),
  ];
  HealthGridView({super.key});

  @override
  Widget build(BuildContext context) {
    var p = Provider.of<LanguageProvider>(context, listen: false);
    final List<String> titles = [
      AppLocalizations.of(context)!.glucose_measurement,
      AppLocalizations.of(context)!.insulin,
      AppLocalizations.of(context)!.foot_care,
      AppLocalizations.of(context)!.nutrition,
      AppLocalizations.of(context)!.exercise,
      AppLocalizations.of(context)!.hypoglycemia,
      AppLocalizations.of(context)!.hyperglycemia,
      AppLocalizations.of(context)!.oral_drugs,
    ];
    var pageNumber = context.watch<HealtPageProvider>().initialPage;
    List<String> returnImages() {
      if (pageNumber == 0) {
        if (p.locale.toString() == "tr" || p.locale == null) {
          return [
            'assets/images/bloodSugarMeasurement/Slayt1.JPG',
            'assets/images/bloodSugarMeasurement/Slayt2.JPG',
            'assets/images/bloodSugarMeasurement/Slayt3.JPG',
            'assets/images/bloodSugarMeasurement/Slayt4.JPG',
          ];
        } else if (p.locale.toString() == "en") {
          return [
            'assets/images/bloodSugarMeasurement/Slayt5.JPG',
            'assets/images/bloodSugarMeasurement/Slayt6.JPG',
            'assets/images/bloodSugarMeasurement/Slayt7.JPG',
            'assets/images/bloodSugarMeasurement/Slayt8.JPG',
          ];
        } else {
          return [
            'assets/images/bloodSugarMeasurement/Slayt1.JPG',
            'assets/images/bloodSugarMeasurement/Slayt2.JPG',
            'assets/images/bloodSugarMeasurement/Slayt3.JPG',
            'assets/images/bloodSugarMeasurement/Slayt4.JPG',
          ];
        }
      } else if (pageNumber == 1) {
        if (p.locale.toString() == "tr" || p.locale == null) {
          return [
            'assets/images/insulin/Slayt1.JPG',
            'assets/images/insulin/Slayt2.JPG',
            'assets/images/insulin/Slayt3.JPG',
            'assets/images/insulin/Slayt4.JPG',
            'assets/images/insulin/Slayt5.JPG',
            'assets/images/insulin/Slayt6.JPG',
            'assets/images/insulin/Slayt7.JPG',
            'assets/images/insulin/Slayt8.JPG',
            'assets/images/insulin/Slayt9.JPG',
          ];
        } else if (p.locale.toString() == "en") {
          return [
            'assets/images/insulin/Slayt10.JPG',
            'assets/images/insulin/Slayt11.JPG',
            'assets/images/insulin/Slayt12.JPG',
            'assets/images/insulin/Slayt13.JPG',
            'assets/images/insulin/Slayt14.JPG',
            'assets/images/insulin/Slayt15.JPG',
            'assets/images/insulin/Slayt16.JPG',
            'assets/images/insulin/Slayt17.JPG',
            'assets/images/insulin/Slayt18.JPG',
          ];
        } else {
          return [
            'assets/images/insulin/Slayt1.JPG',
            'assets/images/insulin/Slayt2.JPG',
            'assets/images/insulin/Slayt3.JPG',
            'assets/images/insulin/Slayt4.JPG',
            'assets/images/insulin/Slayt5.JPG',
            'assets/images/insulin/Slayt6.JPG',
            'assets/images/insulin/Slayt7.JPG',
            'assets/images/insulin/Slayt8.JPG',
            'assets/images/insulin/Slayt9.JPG',
          ];
        }
      } else if (pageNumber == 2) {
        if (p.locale.toString() == "tr" || p.locale == null) {
          return [
            'assets/images/foot_care/Slayt1.JPG',
            'assets/images/foot_care/Slayt3.JPG',
            'assets/images/foot_care/Slayt5.JPG',
            'assets/images/foot_care/Slayt7.JPG',
            'assets/images/foot_care/Slayt9.JPG',
            'assets/images/foot_care/Slayt11.JPG',
            'assets/images/foot_care/Slayt13.JPG',
          ];
        } else if (p.locale.toString() == "en") {
          return [
            'assets/images/foot_care/Slayt2.JPG',
            'assets/images/foot_care/Slayt4.JPG',
            'assets/images/foot_care/Slayt6.JPG',
            'assets/images/foot_care/Slayt8.JPG',
            'assets/images/foot_care/Slayt10.JPG',
            'assets/images/foot_care/Slayt12.JPG',
            'assets/images/foot_care/Slayt14.JPG',
          ];
        } else {
          return [
            'assets/images/foot_care/Slayt1.JPG',
            'assets/images/foot_care/Slayt3.JPG',
            'assets/images/foot_care/Slayt5.JPG',
            'assets/images/foot_care/Slayt7.JPG',
            'assets/images/foot_care/Slayt9.JPG',
            'assets/images/foot_care/Slayt11.JPG',
            'assets/images/foot_care/Slayt13.JPG',
          ];
        }
      } else if (pageNumber == 3) {
        if (p.locale.toString() == "tr" || p.locale == null) {
          return [
            'assets/images/nutrition/Slayt1.JPG',
            'assets/images/nutrition/Slayt2.JPG',
            'assets/images/nutrition/Slayt3.JPG',
            'assets/images/nutrition/Slayt4.JPG',
            'assets/images/nutrition/Slayt5.JPG',
            'assets/images/nutrition/Slayt6.JPG',
            'assets/images/nutrition/Slayt7.JPG',
            'assets/images/nutrition/Slayt8.JPG',
            'assets/images/nutrition/Slayt9.JPG',
            'assets/images/nutrition/Slayt10.JPG',
            'assets/images/nutrition/Slayt11.JPG',
          ];
        } else if (p.locale.toString() == "en") {
          return [
            'assets/images/nutrition/Slayt12.JPG',
            'assets/images/nutrition/Slayt13.JPG',
            'assets/images/nutrition/Slayt14.JPG',
            'assets/images/nutrition/Slayt15.JPG',
            'assets/images/nutrition/Slayt16.JPG',
            'assets/images/nutrition/Slayt17.JPG',
            'assets/images/nutrition/Slayt18.JPG',
            'assets/images/nutrition/Slayt19.JPG',
            'assets/images/nutrition/Slayt20.JPG',
            'assets/images/nutrition/Slayt21.JPG',
            'assets/images/nutrition/Slayt22.JPG',
          ];
        } else {
          return [
            'assets/images/nutrition/Slayt1.JPG',
            'assets/images/nutrition/Slayt2.JPG',
            'assets/images/nutrition/Slayt3.JPG',
            'assets/images/nutrition/Slayt4.JPG',
            'assets/images/nutrition/Slayt5.JPG',
            'assets/images/nutrition/Slayt6.JPG',
            'assets/images/nutrition/Slayt7.JPG',
            'assets/images/nutrition/Slayt8.JPG',
            'assets/images/nutrition/Slayt9.JPG',
            'assets/images/nutrition/Slayt10.JPG',
            'assets/images/nutrition/Slayt11.JPG',
          ];
        }
      } else if (pageNumber == 4) {
        if (p.locale.toString() == "tr" || p.locale == null) {
          return [
            'assets/images/exercise/Slayt1.JPG',
            'assets/images/exercise/Slayt2.JPG',
            'assets/images/exercise/Slayt3.JPG',
            'assets/images/exercise/Slayt4.JPG',
            'assets/images/exercise/Slayt5.JPG',
            'assets/images/exercise/Slayt6.JPG',
            'assets/images/exercise/Slayt7.JPG',
          ];
        } else if (p.locale.toString() == "en") {
          return [
            'assets/images/exercise/Slayt8.JPG',
            'assets/images/exercise/Slayt9.JPG',
            'assets/images/exercise/Slayt10.JPG',
            'assets/images/exercise/Slayt11.JPG',
            'assets/images/exercise/Slayt12.JPG',
            'assets/images/exercise/Slayt13.JPG',
            'assets/images/exercise/Slayt14.JPG',
          ];
        } else {
          return [
            'assets/images/exercise/Slayt1.JPG',
            'assets/images/exercise/Slayt2.JPG',
            'assets/images/exercise/Slayt3.JPG',
            'assets/images/exercise/Slayt4.JPG',
            'assets/images/exercise/Slayt5.JPG',
            'assets/images/exercise/Slayt6.JPG',
            'assets/images/exercise/Slayt7.JPG',
          ];
        }
      } else if (pageNumber == 5) {
        if (p.locale.toString() == "tr" || p.locale == null) {
          return [
            'assets/images/hypoglycemia/Slayt1.JPG',
            'assets/images/hypoglycemia/Slayt2.JPG',
            'assets/images/hypoglycemia/Slayt3.JPG',
            'assets/images/hypoglycemia/Slayt4.JPG',
            'assets/images/hypoglycemia/Slayt5.JPG',
            'assets/images/hypoglycemia/Slayt6.JPG',
            'assets/images/hypoglycemia/Slayt7.JPG',
            'assets/images/hypoglycemia/Slayt8.JPG',
            'assets/images/hypoglycemia/Slayt9.JPG',
            'assets/images/hypoglycemia/Slayt10.JPG',
            'assets/images/hypoglycemia/Slayt11.JPG',
            'assets/images/hypoglycemia/Slayt12.JPG',
            'assets/images/hypoglycemia/Slayt13.JPG',
          ];
        } else if (p.locale.toString() == "en") {
          return [
            'assets/images/hypoglycemia/Slayt14.JPG',
            'assets/images/hypoglycemia/Slayt15.JPG',
            'assets/images/hypoglycemia/Slayt16.JPG',
            'assets/images/hypoglycemia/Slayt17.JPG',
            'assets/images/hypoglycemia/Slayt18.JPG',
            'assets/images/hypoglycemia/Slayt19.JPG',
            'assets/images/hypoglycemia/Slayt20.JPG',
            'assets/images/hypoglycemia/Slayt21.JPG',
            'assets/images/hypoglycemia/Slayt22.JPG',
            'assets/images/hypoglycemia/Slayt23.JPG',
            'assets/images/hypoglycemia/Slayt24.JPG',
            'assets/images/hypoglycemia/Slayt25.JPG',
            'assets/images/hypoglycemia/Slayt26.JPG',
          ];
        } else {
          return [
            'assets/images/hypoglycemia/Slayt1.JPG',
            'assets/images/hypoglycemia/Slayt2.JPG',
            'assets/images/hypoglycemia/Slayt3.JPG',
            'assets/images/hypoglycemia/Slayt4.JPG',
            'assets/images/hypoglycemia/Slayt5.JPG',
            'assets/images/hypoglycemia/Slayt6.JPG',
            'assets/images/hypoglycemia/Slayt7.JPG',
            'assets/images/hypoglycemia/Slayt8.JPG',
            'assets/images/hypoglycemia/Slayt9.JPG',
            'assets/images/hypoglycemia/Slayt10.JPG',
            'assets/images/hypoglycemia/Slayt11.JPG',
            'assets/images/hypoglycemia/Slayt12.JPG',
            'assets/images/hypoglycemia/Slayt13.JPG',
          ];
        }
      } else if (pageNumber == 6) {
        if (p.locale.toString() == "tr" || p.locale == null) {
          return [
            'assets/images/hyperglycemia/Slayt1.JPG',
            'assets/images/hyperglycemia/Slayt2.JPG',
            'assets/images/hyperglycemia/Slayt3.JPG',
            'assets/images/hyperglycemia/Slayt4.JPG',
            'assets/images/hyperglycemia/Slayt5.JPG',
            'assets/images/hyperglycemia/Slayt6.JPG',
            'assets/images/hyperglycemia/Slayt7.JPG',
            'assets/images/hyperglycemia/Slayt8.JPG',
            'assets/images/hyperglycemia/Slayt9.JPG',
            'assets/images/hyperglycemia/Slayt10.JPG',
          ];
        } else if (p.locale.toString() == "en") {
          return [
            'assets/images/hyperglycemia/Slayt11.JPG',
            'assets/images/hyperglycemia/Slayt12.JPG',
            'assets/images/hyperglycemia/Slayt13.JPG',
            'assets/images/hyperglycemia/Slayt14.JPG',
            'assets/images/hyperglycemia/Slayt15.JPG',
            'assets/images/hyperglycemia/Slayt16.JPG',
            'assets/images/hyperglycemia/Slayt17.JPG',
            'assets/images/hyperglycemia/Slayt18.JPG',
            'assets/images/hyperglycemia/Slayt19.JPG',
            'assets/images/hyperglycemia/Slayt20.JPG',
          ];
        } else {
          return [
            'assets/images/hyperglycemia/Slayt1.JPG',
            'assets/images/hyperglycemia/Slayt2.JPG',
            'assets/images/hyperglycemia/Slayt3.JPG',
            'assets/images/hyperglycemia/Slayt4.JPG',
            'assets/images/hyperglycemia/Slayt5.JPG',
            'assets/images/hyperglycemia/Slayt6.JPG',
            'assets/images/hyperglycemia/Slayt7.JPG',
            'assets/images/hyperglycemia/Slayt8.JPG',
            'assets/images/hyperglycemia/Slayt9.JPG',
            'assets/images/hyperglycemia/Slayt10.JPG',
          ];
        }
      } else if (pageNumber == 7) {
        if (p.locale.toString() == "tr" || p.locale == null) {
          return [
            'assets/images/drugs/Slayt1.JPG',
          ];
        } else if (p.locale.toString() == "en") {
          return [
            'assets/images/drugs/Slayt2.JPG',
          ];
        } else {
          return [
            'assets/images/drugs/Slayt1.JPG',
          ];
        }
      } else {
        return [
          'assets/images/footcare2.JPG',
          'assets/images/footcare4.JPG',
          'assets/images/footcare6.JPG',
          'assets/images/footcare8.JPG',
          'assets/images/footcare10.JPG',
          'assets/images/footcare12.JPG',
        ];
      }
    }

    return VerticalCardPager(
        onPageChanged: (page) {
          context.read<HealtPageProvider>().setinitialPage = (page)!;

          print(p.locale);
        },
        onSelectedItem: (index) {
          PopupBanner(
            context: context,
            autoSlide: false,
            images: returnImages(),
            fromNetwork: false,
            onClick: (index) {},
          ).show();
        },
        initialPage: context.watch<HealtPageProvider>().initialPage,
        textStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        titles: titles,
        images: images);
  }
}
