import UIKit
import FirebaseMessaging
import Flutter

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      UNUserNotificationCenter.current().delegate = self
          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
              options: authOptions) { _, _ in }
          application.registerForRemoteNotifications()
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    override func userNotificationCenter(
            _ center: UNUserNotificationCenter,
            willPresent notification: UNNotification,
            withCompletionHandler completionHandler:
            @escaping (UNNotificationPresentationOptions) -> Void
            ) {
              if #available(iOS 14.0, *) {
                  completionHandler([[.banner, .sound]])
              } else {
                  // Fallback on earlier versions
              }
        }

    override func userNotificationCenter(
            _ center: UNUserNotificationCenter,
            didReceive response: UNNotificationResponse,
            withCompletionHandler completionHandler: @escaping () -> Void
          ) {
            completionHandler()
          }
    override func application(
          _ application: UIApplication,
          didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
        ) {
          Messaging.messaging().apnsToken = deviceToken
            Messaging.messaging().subscribe(toTopic: "new_events")
        }
}
