import SwiftUI

struct GetStartedOne: View {
    var body: some View {
        NavigationStack {
            ZStack {

                Image("IMG3")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)


                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)


                VStack {
                    Spacer()

                    Text("Mood Tracking")
                        .font(.custom("Poppins-Bold", size: 36))
                        .foregroundColor(Color(red: 0.82, green: 0.96, blue: 0.93))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 12)
                    
                    Text("Easily record and track your daily moods for a better understanding of your mental well-being.")
                        .font(.custom("Poppins", size: 20))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30)
                        .padding(.bottom, 30)
                    
                    NavigationLink(destination: GetStartedTwo()) {
                        HStack {
                            Text("Get Started")
                                .font(.custom("SF Pro", size: 22))
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                            Image(systemName: "chevron.right")
                                .font(.system(size: 22, weight: .semibold))
                                .foregroundColor(.blue)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.white)
                        .cornerRadius(12)
                        .padding(.horizontal, 40)
                    }
                    .padding(.bottom, 52)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
}

struct GetStartedOne_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedOne()
    }
}
