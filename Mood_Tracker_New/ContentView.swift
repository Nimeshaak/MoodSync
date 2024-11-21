import SwiftUI

struct SplashScreenView: View {
    // State to manage the transition
    @State private var isActive = false
    
    var body: some View {
        if isActive {
            // Navigate to GetStarted_1View after the splash screen
            GetStarted()
        } else {
            // Splash Screen Content
            VStack(spacing: 20) {
                // Blue smile emoji in the middle
                Text("😊")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                
                // App Name
                Text("MoodSync")
                    .font(.custom("Poppins-Bold", size: 40))
                    .foregroundColor(.blue)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                // Trigger the transition after 2 seconds
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
