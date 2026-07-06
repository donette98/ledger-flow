import Foundation
import FirebaseAuth
import GoogleSignIn

class AuthManager: NSObject, ObservableObject {
    @Published var isLoggedIn = false
    @Published var user: User?
    @Published var errorMessage: String?
    
    static let shared = AuthManager()
    
    override private init() {
        super.init()
        checkAuthStatus()
    }
    
    func checkAuthStatus() {
        if Auth.auth().currentUser != nil {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
    
    func signUp(
        email: String,
        password: String,
        name: String,
        accountType: String,
        currency: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                completion(.failure(error))
                return
            }
            
            guard let authUser = result?.user else {
                completion(.failure(NSError(domain: "AuthManager", code: -1, userInfo: nil)))
                return
            }
            
            let user = User(
                id: authUser.uid,
                email: email,
                name: name,
                accountType: accountType,
                currency: currency
            )
            
            self?.user = user
            self?.isLoggedIn = true
            completion(.success(user))
        }
    }
    
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<User, Error>) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                completion(.failure(error))
                return
            }
            
            guard let authUser = result?.user else {
                completion(.failure(NSError(domain: "AuthManager", code: -1, userInfo: nil)))
                return
            }
            
            let user = User(
                id: authUser.uid,
                email: authUser.email ?? "",
                name: authUser.displayName ?? "",
                accountType: "individual",
                currency: "USD"
            )
            
            self?.user = user
            self?.isLoggedIn = true
            completion(.success(user))
        }
    }
    
    func signInWithGoogle(completion: @escaping (Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else {
            completion(.failure(NSError(domain: "AuthManager", code: -1, userInfo: nil)))
            return
        }
        
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first,
              let rootViewController = window.rootViewController else {
            completion(.failure(NSError(domain: "AuthManager", code: -1, userInfo: nil)))
            return
        }
        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController) { [weak self] result, error in
            if let error = error {
                self?.errorMessage = error.localizedDescription
                completion(.failure(error))
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString else {
                completion(.failure(NSError(domain: "AuthManager", code: -1, userInfo: nil)))
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
            
            Auth.auth().signIn(with: credential) { [weak self] authResult, error in
                if let error = error {
                    self?.errorMessage = error.localizedDescription
                    completion(.failure(error))
                    return
                }
                
                guard let authUser = authResult?.user else {
                    completion(.failure(NSError(domain: "AuthManager", code: -1, userInfo: nil)))
                    return
                }
                
                let newUser = User(
                    id: authUser.uid,
                    email: authUser.email ?? "",
                    name: authUser.displayName ?? "",
                    accountType: "individual",
                    currency: "USD"
                )
                
                self?.user = newUser
                self?.isLoggedIn = true
                completion(.success(newUser))
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            user = nil
            isLoggedIn = false
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
