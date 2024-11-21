import SwiftUI
import CoreData

struct MoodView: View {
    @State private var selectedMood: String? = nil
    @State private var note: String = ""
    @State private var currentDate = Date()
    @Environment(\.managedObjectContext) private var viewContext

    let moods = [
        ("Great", "😄"),
        ("Okay", "🙂"),
        ("Meh", "😐"),
        ("Bad", "☹️"),
        ("Terrible", "😞")
    ]

    init() {
        // Fetch existing mood for the current day
        let calendar = Calendar.current
        let fetchRequest: NSFetchRequest<Mood> = Mood.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@",
            calendar.startOfDay(for: Date()) as CVarArg,
            calendar.startOfDay(for: calendar.date(byAdding: .day, value: 1, to: Date())!) as CVarArg
        )

        do {
            let existingMoods = try PersistenceController.shared.container.viewContext.fetch(fetchRequest)
            if let existingMood = existingMoods.first {
                _selectedMood = State(initialValue: existingMood.selectedEmoji) // Store emoji directly
                _note = State(initialValue: existingMood.note ?? "")
            }
        } catch {
            print("Failed to fetch today's mood: \(error.localizedDescription)")
        }
    }

    var body: some View {
        
        VStack(spacing: 20) {
            // Title
            Text("How are you feeling today?")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 40)

            // Date
            Text(dateFormatted())
                .foregroundColor(.gray)
                .font(.subheadline)

            // Mood selection
            HStack(spacing: 15) {
                ForEach(moods, id: \.1) { mood in
                    VStack {
                        Text(mood.1)
                            .font(.largeTitle)
                            .padding()
                            .background(
                                Circle()
                                    .fill(selectedMood == mood.1 ? Color.blue.opacity(0.2) : Color.clear)
                                    .frame(width: 60, height: 60)
                            )
                            .onTapGesture {
                                selectedMood = mood.1 // Save emoji directly
                            }

                        Text(mood.0)
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                }
            }

            // Add note
            VStack(alignment: .leading, spacing: 5) {
                Text("Add a little Note")
                    .font(.headline)

                TextField("Add Note Here...", text: $note)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .foregroundColor(.black)  // Ensures the text is visible
            }
            .padding(.horizontal)

            // Save button
            Button(action: saveMood) {
                Text("Save")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }

            Spacer()
        }
        
        .background(
            ZStack {
                Image("FirstImage") // Replace with your image name from assets
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea() // Ensures the image fills the entire screen
                    .blur(radius: 10)
            }
        )

    }

    private func saveMood() {
        guard let mood = selectedMood else {
            print("No mood selected")
            return
        }

        // Check if a mood already exists for the current day
        let calendar = Calendar.current
        let startOfToday = calendar.startOfDay(for: Date())
        let endOfToday = calendar.date(byAdding: .day, value: 1, to: startOfToday)!

        let fetchRequest: NSFetchRequest<Mood> = Mood.fetchRequest()
        fetchRequest.predicate = NSPredicate(
            format: "timestamp >= %@ AND timestamp < %@",
            startOfToday as CVarArg,
            endOfToday as CVarArg
        )

        do {
            let existingMoods = try viewContext.fetch(fetchRequest)

            if let existingMood = existingMoods.first {
                // Update existing mood
                existingMood.selectedEmoji = mood
                existingMood.note = note
                existingMood.timestamp = Date() // Update timestamp to current date
                existingMood.lastUpdated = Date() // Optionally update last updated timestamp
            } else {
                // Create a new mood
                let newMood = Mood(context: viewContext)
                newMood.selectedEmoji = mood
                newMood.note = note
                newMood.timestamp = Date()  // Set timestamp when creating new mood
                newMood.lastUpdated = Date() // Set last updated
            }

            try viewContext.save()
        } catch {
            print("Failed to save mood: \(error)")
        }
    }

    private func dateFormatted() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: currentDate)
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
