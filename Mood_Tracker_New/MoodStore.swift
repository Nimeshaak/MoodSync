import Foundation
import SwiftUI

class MoodViewModel: ObservableObject {
    @Published var selectedMood: String? {
        didSet {
            // Save the selected mood to UserDefaults whenever it is updated
            UserDefaults.standard.set(selectedMood, forKey: "selectedMood")
        }
    }
    
    init() {
        // Load the selected mood from UserDefaults when the app starts
        self.selectedMood = UserDefaults.standard.string(forKey: "selectedMood")
        
        // Schedule a reset of the mood at midnight
        resetMoodAtMidnight()
    }
    
    // Function to reset the mood at midnight
    private func resetMoodAtMidnight() {
        let now = Date()
        let calendar = Calendar.current
        let midnight = calendar.startOfDay(for: now).addingTimeInterval(24 * 60 * 60) // Midnight
        
        let timeInterval = midnight.timeIntervalSince(now)
        
        // Schedule the reset for midnight
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval) {
            self.selectedMood = nil
            // Call this function again for the next day
            self.resetMoodAtMidnight()
        }
    }
}
