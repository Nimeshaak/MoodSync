import SwiftUI
import UserNotifications

@main
struct MoodSyncApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    let persistenceController = PersistenceController.shared

    init() {
        requestNotificationPermission()
        scheduleHourlyNotification()
    }

    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()  // Replace this with your HomeView
                    .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
        }
    }

    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied: \(error?.localizedDescription ?? "No error information")")
            }
        }
    }

    private func scheduleHourlyNotification() {
        let content = UNMutableNotificationContent()
        content.title = "MoodSync Reminder"
        content.body = "Don't forget to update your mood!"
        content.sound = .default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 60, repeats: true)

        let request = UNNotificationRequest(
            identifier: "singleReminder",
            content: content,
            trigger: trigger
        )

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error scheduling notification: \(error.localizedDescription)")
            } else {
                print("Notification scheduled with message: \(content.body)")
                saveNotification(content.body)
            }
        }
    }

    private func saveNotification(_ message: String) {
        var savedNotifications = UserDefaults.standard.stringArray(forKey: "notifications") ?? []
        savedNotifications.append(message)
        UserDefaults.standard.set(savedNotifications, forKey: "notifications")
    }
}

class AppDelegate: NSObject, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication, didReceive notification: UNNotification) {
        print("Received notification while app is in the foreground: \(notification.request.content.body)")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        UNUserNotificationCenter.current().delegate = self
        return true
    }
}
