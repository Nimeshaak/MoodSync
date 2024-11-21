import SwiftUI
import AVFoundation

struct GroundingPlayView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var timerValue: Int = 60
    @State private var timeRemaining: Int = 60
    @State private var isTimerRunning = false
    @State private var breathingInstruction: String = "Stretch In"
    @State private var isFading = false
    @State private var showCompletionText = false
    @State private var audioPlayer: AVAudioPlayer?
    private let fadeDuration: Double = 1.0
    private let displayDuration: Double = 6.0

    var body: some View {
        NavigationStack {
            ZStack {
                
                Image("IMG2")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)

                
                VStack {
                    if !showCompletionText {
                      
                        VStack(alignment: .center, spacing: 8) {
                            Text("Energy Flow")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.white)

                            Text("A guided exercise to help you relax.")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.white)
                        }
                        .padding(.top, 20)

                        Spacer()

                      
                        VStack {
                            Text(breathingInstruction)
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .opacity(isFading ? 0 : 1)
                                .animation(.easeInOut(duration: fadeDuration), value: isFading)
                        }
                        .onAppear {
                            startBreathingCycle()
                        }

                        Spacer()

                        
                        Text(formatTime(timeRemaining))
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.bottom, 40)
                            .onReceive(Timer.publish(every: 1, on: .main, in: .common).autoconnect()) { _ in
                                if timeRemaining > 0 {
                                    timeRemaining -= 1
                                } else {
                                    stopMusic()
                                    showCompletionText = true
                                }
                            }
                    }

                   
                    if showCompletionText {
                        VStack {
                            Text("You have completed your exercise!")
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                                .padding(.bottom, 20)
                                .multilineTextAlignment(.center)
                                .frame(maxWidth: .infinity, alignment: .center)

                           
                            NavigationLink(destination: HomeView()) {
                                Text("Continue")
                                    .fontWeight(.bold)
                                    .padding()
                                    .background(Color.black.opacity(0.3))
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                                    .frame(width: 200)
                            }
                            .padding(.top, 20)
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                }
                .padding()

                
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
            .onAppear {
                startMeditation()
            }
        }
    }

  
    private func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    
    private func startMeditation() {
        isTimerRunning = true
        setupAudioPlayer()
        playMusic()
    }

   
    private func startBreathingCycle() {
        Timer.scheduledTimer(withTimeInterval: displayDuration, repeats: true) { timer in
            if timeRemaining <= 0 {
                timer.invalidate()
                return
            }
            toggleBreathingInstruction()
        }
    }

  
    private func toggleBreathingInstruction() {
        isFading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + fadeDuration) {
          
            breathingInstruction = (breathingInstruction == "Stretch In") ? "Stretch Out" : "Stretch In"
            isFading = false
        }
    }

   
    private func setupAudioPlayer() {
        guard let path = Bundle.main.path(forResource: "Thoughtful", ofType: "mp3") else {
            print("Error: Audio file not found")
            return
        }
        let url = URL(fileURLWithPath: path)

        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.numberOfLoops = -1
        } catch {
            print("Error loading audio file: \(error.localizedDescription)")
        }
    }

  
    private func playMusic() {
        audioPlayer?.play()
    }

   
    private func stopMusic() {
        audioPlayer?.stop()
    }
}
struct GroundingPlayView_Previews: PreviewProvider {
    static var previews: some View {
        GroundingPlayView()
            .previewDevice("iPhone 14 Pro")
    }
}
