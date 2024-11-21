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
                            Image(systemName: "bell.fill")  
                                .foregroundColor(.blue)
                                .padding(.trailing, 10)

                            VStack(alignment: .leading) {
                                Text(notification)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                Text("Just now")
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
                            .foregroundColor(.gray)
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
        .navigationViewStyle(StackNavigationViewStyle())
    }

    private func fetchNotifications() {
        
        if let savedNotifications = UserDefaults.standard.stringArray(forKey: "notifications") {
            self.notifications = savedNotifications.isEmpty ? ["No notifications yet."] : savedNotifications
            print("Fetched notifications: \(self.notifications)")
        }
    }

    private func clearAllNotifications() {
        
        UserDefaults.standard.removeObject(forKey: "notifications")
        self.notifications = ["No notifications yet."]
        print("All notifications cleared.")
    }
}
