import SwiftUI

struct RelaxingView: View {
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

                    Text("Soothing Music for Relaxation")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                        .frame(maxWidth: .infinity)
                    
                    VStack(alignment: .center, spacing: 10) {
                        Text("Listen to soothing melodies crafted to relax the mind and body. These peaceful tunes are scientifically proven to help reduce stress, enhance focus, and foster tranquility within.")
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

                    
                    NavigationLink(destination: RelaxingPlayView()) {
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

struct DRelaxingView_Previews: PreviewProvider {
    static var previews: some View {
        RelaxingView()
            .previewDevice("iPhone 14 Pro")
    }
}
