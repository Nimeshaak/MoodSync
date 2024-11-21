import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct ProfileView: View {
    @State private var username: String? = nil
    @State private var isCrisisModeEnabled: Bool = false
    @State private var isLoading = true
    @State private var isSignedIn = Auth.auth().currentUser != nil

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack {
                   
                    Circle()
                        .fill(Color.white)
                        .frame(width: 80, height: 80)
                        .overlay(
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .foregroundColor(.gray)
                                .frame(width: 60, height: 60)
                        )
                    
                   
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle())
                    } else if let username = username {
                        Text(username)
                            .font(.headline)
                            .foregroundColor(.black)
                    } else {
                        Text("No Username Found")
                            .font(.subheadline)
                            .foregroundColor(.red)
                    }
                }
                .padding(.top, 20)
                
              
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
                        .transition(.opacity)                         .animation(.easeInOut, value: isCrisisModeEnabled)
                    }
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(16)

               
                VStack(spacing: 10) {
                    if isSignedIn {
                        Button(action: signOutUser) {
                            Text("Sign Out")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(8)
                        }
                    } else {
                        HStack {
                            NavigationLink(destination: SignInView()) {
                                Text("Log In")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .underline()
                            }
                            
                            Spacer()
                            
                            NavigationLink(destination: SignUpView()) {
                                Text("Sign Up")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .underline()
                            }
                        }
                        .padding()
                    }
                }
                
                Spacer()
            }
            .padding()
            .background(Color(red: 0.82, green: 0.96, blue: 0.93).edgesIgnoringSafeArea(.all))
            .onAppear(perform: loadUserProfile)
            .navigationBarTitle("Profile", displayMode: .inline)
        }
    }
    
    private func loadUserProfile() {
        guard let userId = Auth.auth().currentUser?.uid else {
            self.isLoading = false
            return
        }
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).getDocument { snapshot, error in
            self.isLoading = false
            if let data = snapshot?.data(), let fetchedUsername = data["username"] as? String {
                self.username = fetchedUsername
            } else {
                print("Failed to fetch user data: \(error?.localizedDescription ?? "No error description")")
            }
        }
    }
    
    private func signOutUser() {
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
            self.username = nil
            print("User signed out successfully.")
        } catch {
            print("Failed to sign out: \(error.localizedDescription)")
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
