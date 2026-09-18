

import Foundation

struct Expense:Identifiable,Codable {
    let id:String
    let title:String
    let amount:Double
    let date:String
}
