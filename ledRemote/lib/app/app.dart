import 'package:led_remote/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:led_remote/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:led_remote/ui/views/home/home_view.dart';
import 'package:led_remote/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:led_remote/ui/views/authentification/authentification_view.dart';
import 'package:led_remote/ui/views/time/time_view.dart';
import 'package:led_remote/ui/views/temperature/temperature_view.dart';
import 'package:led_remote/ui/views/message/message_view.dart';
import 'package:led_remote/ui/views/audio_spectrum/audio_spectrum_view.dart';
// @stacked-import

@StackedApp(
  routes: [
    MaterialRoute(page: HomeView),
    MaterialRoute(page: StartupView),
    MaterialRoute(page: AuthentificationView),
    MaterialRoute(page: TimeView),
    MaterialRoute(page: TemperatureView),
    MaterialRoute(page: MessageView),
    MaterialRoute(page: AudioSpectrumView),
// @stacked-route
  ],
  dependencies: [
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: NavigationService),
    // @stacked-service
  ],
  bottomsheets: [
    StackedBottomsheet(classType: NoticeSheet),
    // @stacked-bottom-sheet
  ],
  dialogs: [
    StackedDialog(classType: InfoAlertDialog),
    // @stacked-dialog
  ],
)
class App {}
