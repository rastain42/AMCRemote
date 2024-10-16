import 'package:ledRemote/ui/bottom_sheets/notice/notice_sheet.dart';
import 'package:ledRemote/ui/dialogs/info_alert/info_alert_dialog.dart';
import 'package:ledRemote/ui/views/home/home_view.dart';
import 'package:ledRemote/ui/views/startup/startup_view.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:ledRemote/ui/views/authentification/authentification_view.dart';
import 'package:ledRemote/ui/views/time/time_view.dart';
import 'package:ledRemote/ui/views/temperature/temperature_view.dart';
import 'package:ledRemote/ui/views/message/message_view.dart';
import 'package:ledRemote/ui/views/audio_spectrum/audio_spectrum_view.dart';
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
