//
//  SettingsView.swift
//  TodoList
//
//  Created by Berkay Ertürk on 26.06.2023.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    var username: String = ""
    var sleepingTime : Date = Date()
    
    
    var body: some View {
                NavigationView {
                    List {
                        ForEach(userViewModel.users) { user in
                            HStack {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Adım: \(user.username)")
                                        .font(.headline)
                                    Text("Uyku Zamanım: \(formatTime(date: user.sleepingTime))")
                                        .font(.subheadline)
                                        .foregroundColor(.secondary)
                                }
                                .padding(10)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.gray.opacity(0.3), radius: 5, x: 0, y: 2)
                            .padding(.vertical, 5)
                                
                                Button(action: {
                                    // Butona tıklanınca çalışacak kodlar
                                    // Edit user info
                                }) {
                                    Image(systemName: "pencil.circle.fill")
                                        .foregroundColor(.secondary)
                                        .font(.title)
                                }
                            }
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
        SettingsView().environmentObject(UserViewModel())
    }
}
