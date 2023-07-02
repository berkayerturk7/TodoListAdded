
import Foundation

class UserViewModel: ObservableObject {
    
    @Published var users: [UserModel] = []
    
    let usersKey: String = "user"
    
    init() {
        getUsers()
    }
    
    func getUsers() {
        guard
              let data = UserDefaults.standard.data(forKey: usersKey),
              let savedUsers = try? JSONDecoder().decode([UserModel].self, from: data)
        else { return }
        self.users = savedUsers
    }
    
    
    func saveUser() {
        
        if let encodedData = try? JSONEncoder().encode(users) {
            UserDefaults.standard.set(encodedData, forKey: usersKey)
        }
        
    }
    
    func addUser(username: String, sleepingTime: Date) {
        let newUser = UserModel(username: username, sleepingTime: sleepingTime) // default false
        users.append(newUser)
    }
}
