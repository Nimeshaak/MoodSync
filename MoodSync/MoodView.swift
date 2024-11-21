import SwiftUI
import CoreData

struct MoodView: View {
    @State private var selectedMood: String? = nil
    @State private var note: String = ""
    @State private var currentDate = Date()
    @State private var showAlert = false 
    @Environment(\.managedObjectContext) private var viewContext

    let moods = [
        ("Great", "😄"),
        ("Okay", "🙂"),
        ("Meh", "😐"),
        ("Bad", "☹️"),
        ("Terrible", "😞")
    ]

    init() {
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
                _selectedMood = State(initialValue: existingMood.selectedEmoji)
                _note = State(initialValue: existingMood.note ?? "")
            }
        } catch {
            print("Failed to fetch today's mood: \(error.localizedDescription)")
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            Text("How are you feeling today?")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.top, 40)

            Text(dateFormatted())
                .foregroundColor(.gray)
                .font(.subheadline)

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
                                selectedMood = mood.1
                            }

                        Text(mood.0)
                            .font(.caption)
                            .foregroundColor(.black)
                    }
                }
            }

            VStack(alignment: .leading, spacing: 5) {
                Text("Add a little Note")
                    .font(.headline)

                TextField("Add Note Here...", text: $note)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .foregroundColor(.black)
            }
            .padding(.horizontal)

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
                Image("FirstImage")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .blur(radius: 10)
            }
        )
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Success"),
                message: Text("Your mood is successfully updated!"),
                dismissButton: .default(Text("OK"))
            )
        }
    }

    private func saveMood() {
        guard let mood = selectedMood else {
            print("No mood selected")
            return
        }

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
                existingMood.selectedEmoji = mood
                existingMood.note = note
                existingMood.timestamp = Date()
                existingMood.lastUpdated = Date()
            } else {
                let newMood = Mood(context: viewContext)
                newMood.selectedEmoji = mood
                newMood.note = note
                newMood.timestamp = Date()
                newMood.lastUpdated = Date()
            }

            try viewContext.save()
            showAlert = true // Trigger the alert
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
