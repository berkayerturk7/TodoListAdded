//
//  SettingsView.swift
//  TodoList
//
//  Created by Berkay Ertürk on 26.06.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userViewModel: UserViewModel
  
    
    var body: some View {
                NavigationView {
                    List {
                        Section(header: Text("Bilgiler")) {
                            ForEach(userViewModel.users) { user in
                                HStack {
                                    VStack(alignment: .leading, spacing: 8) {
                                        Text("Adım: \(user.username)")
                                            .font(.title2)
                                        Text("Uyku Zamanım: \(formatTime(date: user.sleepingTime))")
                                            .font(.title3)
                                            .foregroundColor(.secondary)
                                        
                                    }
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 5)
                                    .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                                 
                                    Spacer()
                                    
                                    Button(action: {
                                        // Butona tıklanınca çalışacak kodlar
                                        // Edit user info
                                    }) {
                                        Image(systemName: "pencil.circle.fill")
                                            .foregroundColor(.secondary)
                                            .font(.largeTitle)
                                    }
                                }
                            }
                        }
                        Section(header: Text("Açıklama")) {
                                            Text("Uyku Zamanım Bilgisi Neden Önemli? \n Zaman\n Zaman\n ")
                                        }
                        
                    }
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle("Ayarlar")
                }
                .onAppear {
                    userViewModel.getUsers()
                }
            }

    
    func formatTime(date: Date) -> String {
         let formatter = DateFormatter()
         formatter.dateFormat = "HH:mm" // Kullanmak istediğiniz saat formatını belirleyin
         return formatter.string(from: date)
     }
   }

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        let userViewModel = UserViewModel()
        userViewModel.users = [UserModel(username: "Berkay", sleepingTime: Date())]
        
       
        return SettingsView().environmentObject(userViewModel)
    
    }
}
 

