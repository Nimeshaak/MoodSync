import SwiftUI
//import FirebaseAuth

struct SignInView: View {
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
            Text("Sign In")
                .font(.title)
                .fontWeight(.semibold)
                .padding(.bottom, 20)
            
            // Email & Password Fields
            VStack(spacing: 16) {
                TextField("Email", text: .constant(""))
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
                
                SecureField("Password", text: .constant(""))
                    .padding()
                    .background(Color(UIColor.systemGray6))
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            
            // Sign In Button
            Button(action: {
                // Sign In action here
            }) {
                Text("Sign In")
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
            
            // Sign Up option
            HStack {
                Text("Don’t have an account?")
                    .foregroundColor(.gray)
                Button(action: {
                    // Sign Up action here
                }) {
                    Text("Sign Up")
                        .foregroundColor(.blue)
                }
            }
            .padding(.bottom, 20)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
