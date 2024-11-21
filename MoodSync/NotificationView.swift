import SwiftUI
import UserNotifications

struct NotificationView: View {
    @State private var notifications: [String] = []

    var body: some View {
        NavigationView {
            VStack {
                List(notifications, id: \.self) { notification in
                    if notification != "No notifications yet." {
                        HStack {
                            Image(systemName: "bell.fill")  // Icon for notification
                                .foregroundColor(.blue)
                                .padding(.trailing, 10)

                            VStack(alignment: .leading) {
                                Text(notification)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                Text("Just now")  // Placeholder for time; you could use the actual time of notification here
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 5)
                    } else {
                        Text(notification)
                            .foregroundColor(.gray)  // Just show the message without styling
                            .padding()
                    }
                }

                Button(action: clearAllNotifications) {
                    Text("Clear All Notifications")
                        .foregroundColor(.red)
                        .padding()
                        .background(Capsule().strokeBorder(Color.red, lineWidth: 2))
                }
                .padding()
            }
            .navigationTitle("Notifications")
            .onAppear {
                fetchNotifications()
            }
        }
        .navigationViewStyle(StackNavigationViewStyle()) // Ensures better behavior on iPad
    }

    private func fetchNotifications() {
        // Retrieve saved notifications from UserDefaults
        if let savedNotifications = UserDefaults.standard.stringArray(forKey: "notifications") {
            self.notifications = savedNotifications.isEmpty ? ["No notifications yet."] : savedNotifications
            print("Fetched notifications: \(self.notifications)") // Debugging log
        }
    }

    private func clearAllNotifications() {
        // Clear notifications from UserDefaults
        UserDefaults.standard.removeObject(forKey: "notifications")
        self.notifications = ["No notifications yet."]
        print("All notifications cleared.")
    }
}
