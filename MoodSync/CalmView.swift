import SwiftUI

struct CalmView: View {
    @Environment(\.presentationMode) var presentationMode // For dismissing the screen
    @State private var remainingTime = 180 // 3 minutes countdown
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack {
            // Background image
            Image("beach_background") // Replace with your image asset name
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            // Overlay content
            VStack {
                // Title and description
                VStack(alignment: .center, spacing: 8) {
                    Text("Deep Breathing")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    Text("A simple technique to calm your mind. Inhale deeply through your nose and exhale slowly.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.black)
                }
                .padding(.top, 20)

                Spacer()

                // Steps
                VStack(alignment: .leading, spacing: 8) {
                    Text("Steps:")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(.black)

                    Text("1. Inhale for 4 seconds.")
                        .foregroundColor(.black)
                    Text("2. Hold for 4 seconds.")
                        .foregroundColor(.black)
                    Text("3. Exhale for 4 seconds.")
                        .foregroundColor(.black)
                }
                .padding(.horizontal)
                .background(Color.white.opacity(0.7))
                .cornerRadius(10)

                Spacer()

                // Countdown timer
                Text(formatTime(remainingTime))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .padding(.bottom, 40)
                    .onReceive(timer) { _ in
                        if remainingTime > 0 {
                            remainingTime -= 1
                        }
                    }
            }
            .padding()

            // Close button
            VStack {
                HStack {
                    Spacer()
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.black)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .clipShape(Circle())
                    }
                    .padding()
                }
                Spacer()
            }
        }
    }

    // Helper function to format time
    private func formatTime(_ seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}

struct CalmView_Previews: PreviewProvider {
    static var previews: some View {
        CalmView()
    }
}
