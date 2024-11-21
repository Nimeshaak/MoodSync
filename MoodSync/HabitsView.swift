import SwiftUI
import CoreData

struct HabitsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        entity: Habit.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Habit.name, ascending: true)]
    ) private var habits: FetchedResults<Habit>

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("My Habits")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    NavigationLink(destination: HabitFormView()) {
                        Text("Add New +")
                            .font(.callout)
                            .foregroundColor(Color.blue)
                            .padding(.trailing)
                    }
                }
                .padding(.top)

                ScrollView {
                    ForEach(habits, id: \.self) { habit in
                        HabitCardView(habit: habit) {
                            deleteHabit(habit: habit)
                        }
                    }
                }
                .padding(.horizontal)
            }
            .background(Color(red: 0.9, green: 0.96, blue: 1))
            .navigationBarHidden(true)
        }
    }

    /// Function to delete a habit from Core Data
    private func deleteHabit(habit: Habit) {
        viewContext.delete(habit)
        do {
            try viewContext.save()
        } catch {
            print("Error deleting habit: \(error.localizedDescription)")
        }
    }
}

struct HabitCardView: View {
    let habit: Habit
    let onDelete: () -> Void // Callback for deleting the habit

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(habit.name ?? "Unknown Habit")
                    .font(.headline)
                    .foregroundColor(.black)
                
                Text(habit.desc ?? "No description")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                if let reminderTime = habit.reminderTime {
                    Text("Reminder: \(reminderTime, formatter: dateFormatter)")
                        .font(.caption)
                        .foregroundColor(.blue)
                }
            }
            Spacer()

            Button(action: {
                onDelete()
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(red: 0.86, green: 0.94, blue: 0.96))
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 5)
        .padding(.vertical, 5)
    }
}

// Formatter for displaying the reminder time
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()

struct HabitsView_Previews: PreviewProvider {
    static var previews: some View {
        HabitsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
