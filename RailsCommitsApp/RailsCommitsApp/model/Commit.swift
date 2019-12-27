import Foundation

struct Commit {
    let name : String
    let sha : String
    let message : String
    
    
    init(commitDictionary : [String:Any]) {
        self.name = commitDictionary["name"] as? String ?? ""
        self.sha = commitDictionary["sha"] as? String ?? ""
        self.message = commitDictionary["message"] as? String ?? ""
    }
}
