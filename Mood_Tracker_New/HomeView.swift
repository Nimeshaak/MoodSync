import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // Header Section (Minimalist, typical header)
                HStack {
                    Text("Home")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                    NavigationLink(destination: Text("Notifications Page")) {
                        Image(systemName: "bell")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 20)
                
                // Mood Tracker Section as a Card
                VStack(alignment: .leading, spacing: 20) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("09-11-2024")
                            .font(.title3)
                            .fontWeight(.medium)
                        Text("How are you feeling today?")
                            .font(.title2)
                            .fontWeight(.medium)
                    }
                    HStack(spacing: 20) {
                        MoodButton(emoji: "😊")
                        MoodButton(emoji: "😢")
                        MoodButton(emoji: "😡")
                        MoodButton(emoji: "😱")
                        MoodButton(emoji: "😴")
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
                
                // Notification Bar Section as a Card
                HStack {
                    Image(systemName: "bell.fill")
                        .foregroundColor(.orange)
                    Text("You have 3 new notifications")
                        .font(.body)
                        .foregroundColor(.primary)
                    Spacer()
                    NavigationLink(destination: Text("Notifications Page")) {
                        Text("View All")
                            .font(.body)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
                
                // Motivational Quotes Section as a Card
                VStack(alignment: .leading, spacing: 10) {
                    Text("Motivational Quotes")
                        .font(.title2)
                        .fontWeight(.medium)
                    Text("“The only way to do great work is to love what you do.” – Steve Jobs")
                        .font(.body)
                        .italic()
                        .foregroundColor(.secondary)
                        .padding(.top, 5)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
                
                // 5 Boxes Section with Horizontal Scrolling
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        BoxView(title: "Box 1")
                        BoxView(title: "Box 2")
                        BoxView(title: "Box 3")
                        BoxView(title: "Box 4")
                        BoxView(title: "Box 5")
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(15)
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationBarHidden(true)
        }
    }
}

// Button for each Mood that Navigates to a Single Detail View
struct MoodButton: View {
    let emoji: String

    var body: some View {
        NavigationLink(destination: MoodView()) {
            Text(emoji)
                .font(.largeTitle)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
        }
    }
}

// Box View for 5 Boxes (No Rating, just Rectangle with Overlaying Text)
struct BoxView: View {
    let title: String
    
    var body: some View {
        VStack {
            // Rectangle Box
            Rectangle()
                .fill(Color.blue.opacity(0.2))
                .frame(width: 120, height: 120)
                .cornerRadius(10)
                .overlay(
                    Text(title)
                        .font(.headline)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                )
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}


// Preview for SwiftUI
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
