import SwiftUI

struct DeepBreathingView: View {
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

                    Text("Guided Meditation Session")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Immerse yourself in a calming guided meditation. This session is designed to help you find balance, reduce anxiety, and practice mindfulness, leaving you with a sense of clarity and inner peace.")
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

                    
                    NavigationLink(destination: MeditationPlayView()) {
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
                .padding(.horizontal, 20)
            }
            .navigationBarBackButtonHidden(false) 
        }
    }
}

struct DeepBreathingView_Previews: PreviewProvider {
    static var previews: some View {
        DeepBreathingView()
            .previewDevice("iPhone 14 Pro")
    }
}
