import 'package:wondrous_opentelemetry/common_libs.dart';
import 'package:wondrous_opentelemetry/logic/data/wonder_data.dart';
import 'package:wondrous_opentelemetry/logic/data/wonders_data/chichen_itza_data.dart';
import 'package:wondrous_opentelemetry/logic/data/wonders_data/christ_redeemer_data.dart';
import 'package:wondrous_opentelemetry/logic/data/wonders_data/colosseum_data.dart';
import 'package:wondrous_opentelemetry/logic/data/wonders_data/great_wall_data.dart';
import 'package:wondrous_opentelemetry/logic/data/wonders_data/machu_picchu_data.dart';
import 'package:wondrous_opentelemetry/logic/data/wonders_data/petra_data.dart';
import 'package:wondrous_opentelemetry/logic/data/wonders_data/pyramids_giza_data.dart';
import 'package:wondrous_opentelemetry/logic/data/wonders_data/taj_mahal_data.dart';

class WondersLogic {
  List<WonderData> all = [];

  final int timelineStartYear = -3000;
  final int timelineEndYear = 2200;

  WonderData getData(WonderType value) {
    WonderData? result = all.firstWhereOrNull((w) => w.type == value);
    if (result == null) throw ('Could not find data for wonder type $value');
    return result;
  }

  void init() {
    all = [
      GreatWallData(),
      PetraData(),
      ColosseumData(),
      ChichenItzaData(),
      MachuPicchuData(),
      TajMahalData(),
      ChristRedeemerData(),
      PyramidsGizaData(),
    ];
  }
}
