import SwiftUI

struct RelaxingView: View {
    var body: some View {
        NavigationView {  // Make sure the NavigationLink is inside a NavigationView
            ZStack {
                // Background Image
                Image("IMG2") // Replace with your image asset name
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .overlay(Color.black.opacity(0.3))
                    .blur(radius: 10)

                // Content
                VStack {
                    Spacer()

                    Text("Soothing Music for Relaxation")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity) // Prevent overflow
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Listen to soothing melodies crafted to relax the mind and body. These peaceful tunes are scientifically proven to help reduce stress, enhance focus, and foster tranquility within.")
                            .font(.body)
                            .italic()
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 50)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true) // Ensures text wraps
                            .frame(maxWidth: .infinity) // Prevent overflow
                    }
                    .padding(.horizontal, 20) // To avoid text touching screen edges

                    // Ensure the NavigationLink is tappable
                    NavigationLink(destination: GroundingPlayView()) {
                        Text("Start")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .cornerRadius(25)
                            .padding(.bottom, 40)
                            .contentShape(Rectangle()) // Make the entire button area tappable
                    }
                    .buttonStyle(PlainButtonStyle()) // Remove default button styles that might interfere

                    Spacer()
                }
                .padding(.horizontal, 20) // Ensures overall content isn't too close to edges
            }
            .navigationBarBackButtonHidden(false) // Ensure the back button shows if you're navigating from here
        }
    }
}

struct DRelaxingView_Previews: PreviewProvider {
    static var previews: some View {
        RelaxingView()
            .previewDevice("iPhone 14 Pro")
    }
}
