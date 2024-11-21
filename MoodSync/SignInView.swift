import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignInView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage: String? = nil
    @State private var isSignedIn = false

    var body: some View {
        VStack {
          
            Text("Log In")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
        
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
          
            if let errorMessage = errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
            
         
            Button(action: {
                signInUser()
            }) {
                Text("Log In")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 20)
        }
        .padding()
        .navigationTitle("Log In")
        .fullScreenCover(isPresented: $isSignedIn) {
            ProfileView()
        }
    }
    
    private func signInUser() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else {
                errorMessage = nil
                saveUsername(for: result?.user)
                isSignedIn = true
                print("User logged in successfully: \(result?.user.email ?? "No Email")")
            }
        }
    }
    
    private func saveUsername(for user: User?) {
        guard let userId = user?.uid else { return }
        let db = Firestore.firestore()
        
        
        db.collection("users").document(userId).getDocument { snapshot, error in
            if let snapshot = snapshot, snapshot.exists {
                print("Username already exists.")
            } else {
                let defaultUsername = "User_\(UUID().uuidString.prefix(6))"
                db.collection("users").document(userId).setData(["username": defaultUsername]) { error in
                    if let error = error {
                        print("Error saving username: \(error.localizedDescription)")
                    } else {
                        print("Username saved successfully as \(defaultUsername).")
                    }
                }
            }
        }
    }
}
