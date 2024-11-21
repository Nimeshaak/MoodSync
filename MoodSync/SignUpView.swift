import SwiftUI
//import FirebaseAuth

struct SignUpView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    var body: some View {
        VStack {
            // Close button
            HStack {
                Spacer()
                Button(action: {
                    // Close action here
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.black)
                        .padding()
                }
            }
            
            Spacer()
            
            // Title
            Text("Sign Up")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            // Email, Password & Confirm Password Fields
            VStack(spacing: 16) {
                TextField("Email", text: $email)
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                
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
            
            // Sign Up Button
            Button(action: {
                // Sign Up action here
                signUpUser()
            }) {
                Text("Sign Up")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            .padding(.top, 20)
            
            // Separator with 'or'
            HStack {
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
                Text("or")
                    .foregroundColor(.gray)
                Divider()
                    .frame(height: 1)
                    .background(Color.gray)
            }
            .padding(.vertical, 20)
            .padding(.horizontal)
            
            // Social Sign-Up Buttons
            VStack(spacing: 10) {
                SocialSignInButton(iconName: "g.circle", text: "Continue with Google")
                SocialSignInButton(iconName: "f.circle", text: "Continue with Facebook")
                SocialSignInButton(iconName: "applelogo", text: "Continue with Apple")
            }
            .padding(.horizontal)
            
            Spacer()
            
            // Sign In option
            HStack {
                Text("Already have an account?")
                    .foregroundColor(.gray)
                Button(action: {
                    // Sign In action here
                }) {
                    Text("Sign In")
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 20)
        }
    }
    
    // Sign up function
    private func signUpUser() {
        // Validate inputs (email, password, confirm password)
        guard password == confirmPassword else {
            print("Passwords do not match")
            return
        }
        
        // Firebase authentication for sign-up
       // Auth.auth().createUser(withEmail: email, password: password) { result, error in
        //    if let error = error {
           //     print("Error signing up: \(error.localizedDescription)")
         //   } else {
           //     print("User signed up successfully")
                // Proceed to next screen or show success message
           // }
       // }
    }
}

struct SocialSignInButton: View {
    var iconName: String
    var text: String
    
    var body: some View {
        Button(action: {
            // Social Sign-Up action here
        }) {
            HStack {
                Image(systemName: iconName)
                    .font(.title2)
                    .foregroundColor(.black)
                Text(text)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
            .background(Color(UIColor.systemGray6))
            .cornerRadius(10)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
