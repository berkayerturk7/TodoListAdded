import Foundation

// Singleton  Tasarım Deseni

class GlobalData {
    static let shared = GlobalData()
    var value: Int = 0
    
}

struct StructA {
    func incValue() {
        GlobalData.shared.value = 1
    }
}

struct StructB {
    func decValue() {
        GlobalData.shared.value = 0
    }
}

struct StructC {
    func incValue() {
        GlobalData.shared.value = 1
    }
}
