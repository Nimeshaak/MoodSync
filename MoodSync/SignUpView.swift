import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var username = ""
    @State private var errorMessage: String? = nil
    
    var body: some View {
        VStack {
            
            Text("Sign Up")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            
            VStack(spacing: 16) {
                TextField("Username", text: $username)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                
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
                
                SecureField("Confirm Password", text: $confirmPassword)
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
            
            
            Button(action: signUpUser) {
                Text("Sign Up")
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
    }
    
    private func signUpUser() {
        guard password == confirmPassword else {
            errorMessage = "Passwords do not match."
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                errorMessage = error.localizedDescription
            } else if let userId = result?.user.uid {
                saveUserToFirestore(userId: userId)
            }
        }
    }
    
    private func saveUserToFirestore(userId: String) {
        let db = Firestore.firestore()
        db.collection("users").document(userId).setData([
            "username": username,
            "email": email
        ]) { error in
            if let error = error {
                errorMessage = "Failed to save user: \(error.localizedDescription)"
            } else {
                errorMessage = nil
                print("User saved successfully")
            }
        }
    }
}



struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
