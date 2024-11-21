import SwiftUI

struct GetStarted: View {
    var body: some View {
        NavigationStack {
            ZStack {
                // Background Image
                Image("FirstImage")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)

                // Semi-transparent black overlay
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)

                // Content over the background
                VStack {
                    Spacer() // Pushes content upwards
                    
                    // Main Message
                    Text("Discover")
                        .font(.custom("Poppins-Bold", size: 36))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 12)
                    
                    // Subtitle
                    Text("Uncover new flavors and explore recipes from around the world.")
                        .font(.custom("Poppins", size: 20))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                    
                    // Get Started Button
                    NavigationLink(destination: HomeView()) {
                        HStack {
                            Text("Get Started")
                                .font(.custom("SF Pro", size: 22))
                                .fontWeight(.semibold)
                                .foregroundColor(Color(red: 3.0, green: 0.3, blue: 0.1))
                            Image(systemName: "chevron.right")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(Color(red: 3.0, green: 0.3, blue: 0.1))
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                    }
                    .padding(.bottom, 50)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct GetStarted_Previews: PreviewProvider {
    static var previews: some View {
        GetStarted()
    }
}
