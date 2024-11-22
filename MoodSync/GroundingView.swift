import SwiftUI

struct GroundingView: View {
    var body: some View {
        NavigationView {
            ZStack {
               
                Image("IMG2")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                    .overlay(Color.black.opacity(0.3))
                    .blur(radius: 10)

                VStack {
                    Spacer()

                    Text("Mood-Boosting Exercise")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Energize your day with a simple, uplifting exercise routine. This routine will help you clear your mind, boost your mood, and leave you feeling refreshed and mentally sharp.")
                            .font(.body)
                            .italic()
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .padding(.vertical, 50)
                            .lineLimit(nil)
                            .fixedSize(horizontal: false, vertical: true)
                            .frame(maxWidth: .infinity)
                    }
                    .padding(.horizontal, 20)

                    
                    NavigationLink(destination: GroundingPlayView()) {
                        Text("Start")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .cornerRadius(25)
                            .padding(.bottom, 40)
                            .contentShape(Rectangle())
                    }
                    .buttonStyle(PlainButtonStyle())

                    Spacer()
                }
                .padding(.horizontal, 40)
            }
            .navigationBarBackButtonHidden(false) 
        }
    }
}

struct GroundingView_Previews: PreviewProvider {
    static var previews: some View {
        GroundingView()
    }
}
