import SwiftUI

struct ContentView: View {

    @State private var isActive = false
    
    var body: some View {
        if isActive {
            GetStartedOne()
        } else {
            VStack {
                Image("Logo") // Add your image named "Logo" from the assets
                    .resizable()  // Make the image resizable
                    .scaledToFit() // Scale the image to fit within the available space
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // Make the image fill the screen
            }
            .background(Color(red: 0.82, green: 0.96, blue: 0.93)) // Background color
            .edgesIgnoringSafeArea(.all) // Extend the background to the edges
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation(.easeOut(duration: 0.5)) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
