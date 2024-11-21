import SwiftUI

struct ProfileView: View {
    @State private var isCrisisModeEnabled: Bool = false
    @State private var showMapView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // Profile Image and Actions
                VStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "plus")
                                .foregroundColor(.gray)
                                .font(.system(size: 24))
                        )
                    
                    // NavigationLink for Create Account (Sign Up)
                    NavigationLink(destination: SignUpView()) {
                        Text("Create an account")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .cornerRadius(8)
                    }
                    
                    // Instead of concatenating Text and NavigationLink, wrap them correctly
                    HStack {
                        Text("Already Have an account? ")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        NavigationLink(destination: SignInView()) {
                            Text("Log In")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                                .underline()
                        }
                    }
                }
                .padding(.top, 20)
                
                // Crisis Mode Section
                VStack(alignment: .leading, spacing: 16) {
                    Toggle(isOn: $isCrisisModeEnabled) {
                        Text("Crisis Mode")
                            .font(.headline)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
                    
                    if isCrisisModeEnabled {
                        VStack(alignment: .leading, spacing: 16) {
                            Text("If you’re feeling overwhelmed, don’t hesitate to click this button. We’re here to support you and help you through the process of nurturing your mental health.")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            
                            NavigationLink(destination: MapView(locationManager: LocationManager())) {
                                HStack {
                                    Text("Find Hospitals/Clinics Near Me")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                        .foregroundColor(.white)
                                }
                                .padding()
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.blue))
                            }
                            
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Hotline Numbers")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                
                                Text("Hotline 01 : 011-111 111 111 / 011-111 111")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Hotline 02 : 011-111 111 111 / 011-111 111")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                                Text("Hotline 03 : 011-111 111 111 / 011-111 111")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 12).fill(Color(UIColor.systemGray6)))
                        }
                        .transition(.opacity) // Smooth toggle transition
                        .animation(.easeInOut, value: isCrisisModeEnabled)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(16)
                
                Spacer()
            }
            .padding()
            .background(Color(red: 0.82, green: 0.96, blue: 0.93).edgesIgnoringSafeArea(.all))
            .navigationBarTitle("Profile", displayMode: .inline)
            .navigationBarBackButtonHidden(false)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
