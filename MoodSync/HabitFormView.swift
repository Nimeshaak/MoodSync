import SwiftUI
import CoreData

struct HabitFormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var habitName: String = ""
    @State private var habitDescription: String = ""
    @State private var selectedDays: [Bool] = Array(repeating: false, count: 7)
    @State private var reminderTime: Date = Date()
    @State private var reminderNote: String = ""
    
    // New state variables for navigation
    @State private var isHabitSaved: Bool = false
    @State private var savedHabit: Habit? = nil
    
    // New state variables for the alert
    @State private var isAlertPresented: Bool = false
    @State private var alertMessage: String = ""
    @State private var alertTitle: String = ""

    var body: some View {
        VStack(spacing: 20) {
            // Add Habit Icon
            Button(action: {
                // Action for adding an icon
            }) {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 100, height: 100)
                        .shadow(radius: 5)
                    
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                }
            }
            
            // Habit Name Field
            TextField("Add Habit Name Here...", text: $habitName)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 5)
            
            // Habit Description Field
            TextField("Add Habit Description Here...", text: $habitDescription)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 5)
            
            // Repeat On Section
            VStack(alignment: .leading) {
                Text("Repeat On")
                    .font(.headline)
                
                HStack(spacing: 10) {
                    ForEach(0..<7, id: \.self) { index in
                        Button(action: {
                            selectedDays[index].toggle()
                        }) {
                            Text(["S", "M", "T", "W", "T", "F", "S"][index])
                                .frame(width: 40, height: 40)
                                .background(selectedDays[index] ? Color.blue : Color.gray.opacity(0.2))
                                .foregroundColor(.black)
                                .cornerRadius(8)
                        }
                    }
                }
            }
            
            // Reminder Section
            VStack(alignment: .leading) {
                Text("Reminder On")
                    .font(.headline)
                
                DatePicker("", selection: $reminderTime, displayedComponents: .hourAndMinute)
                    .labelsHidden()
            }
            
            // Reminder Note Field
            TextField("Add Note Here...", text: $reminderNote)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 5)
            
            // Save Button
            Button(action: {
                saveHabit()
            }) {
                Text("Save")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
        .padding()
        .background(Color(red: 0.82, green: 0.96, blue: 0.93))
        .edgesIgnoringSafeArea(.bottom)
        .alert(isPresented: $isAlertPresented) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }
    }
    
    // Function to save the habit to Core Data
    private func saveHabit() {
        let newHabit = Habit(context: viewContext)
        newHabit.name = habitName
        newHabit.desc = habitDescription
        newHabit.reminderTime = reminderTime
        newHabit.reminderNote = reminderNote
        newHabit.selectedDays = selectedDays.map { $0 ? "1" : "0" }.joined(separator: ",")
        
        do {
            try viewContext.save()
            alertTitle = "Success"
            alertMessage = "Habit saved successfully!"
            isAlertPresented = true
        } catch {
            alertTitle = "Error"
            alertMessage = "Failed to save habit: \(error.localizedDescription)"
            isAlertPresented = true
        }
    }
}

// Formatter for displaying the reminder time
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.timeStyle = .short
    return formatter
}()

struct HabitFormView_Previews: PreviewProvider {
    static var previews: some View {
        HabitFormView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
