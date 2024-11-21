import SwiftUI

struct ContentView: View {

    @State private var isActive = false
    
    var body: some View {
        if isActive {
            GetStartedOne()
        } else {
            VStack {
                Image("Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(Color(red: 0.82, green: 0.96, blue: 0.93))
            .edgesIgnoringSafeArea(.all) 
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
