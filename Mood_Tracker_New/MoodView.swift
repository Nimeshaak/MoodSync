import SwiftUI

struct MoodView: View {
    @State private var additionalNote: String = "" // State to store the additional note

    var body: some View {
        VStack {
            // Date Text - Centered
            Text("09-11-2024")
                .font(.title3)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding(.top, 20)
            
            // How are you feeling today? - Centered and bigger
            Text("How are you feeling today?")
                .font(.title2)
                .fontWeight(.medium)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 20)
            
            // Mood Tracker Section (Emojis)
            VStack(alignment: .leading, spacing: 20) {
                HStack(spacing: 20) {
                    Text("😊")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    Text("😢")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    Text("😡")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    Text("😱")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                    Text("😴")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
            }
            .padding()
            .background(Color.gray.opacity(0.1))
            .cornerRadius(15)
            .padding(.horizontal)
            
            // Additional Note Section
            VStack(alignment: .leading) {
                Text("Add Additional Note")
                    .font(.headline)
                    .padding(20)
                
                TextField("Enter your note here", text: $additionalNote)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(5)
                    .padding(.horizontal)
            }

            // Save Button
            Button(action: {
                // Save functionality will go here
            }) {
                Text("Save")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.top, 20)

                    .padding(80)
            }
            
            Spacer()  // To provide bottom padding and avoid sticking to the screen
        }
        .padding(.bottom, 20) // Bottom padding for the entire view
    }
}

struct MoodView_Previews: PreviewProvider {
    static var previews: some View {
        MoodView()
    }
}
