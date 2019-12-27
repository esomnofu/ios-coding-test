import UIKit

class CommitApiService: NSObject {
    
    static let sharedInstance = CommitApiService()
 
    
    func fetchCommitsFromApi(completion: @escaping ([Commit]) -> (), errorCompletion: @escaping (Any) -> ()){
        var commitArray = [Commit]()
        var alreadyLoadedCommits = [String]()
        
        let RUBY_REPO = "rails/rails/commits"
        regularGetRequest(apiUrl: BASE_URL+RUBY_REPO, completion: { (result) in
            
            print("RUBY_REPO RES: ", result)
            
            if let arrayDictionary = result as? NSArray {
                for item in arrayDictionary {
                    guard let eachCommitDictionary = item as? [String:Any] else {return}
                    let commit = Commit(commitDictionary: eachCommitDictionary)
                    
                    if alreadyLoadedCommits.contains(commit.sha) {
                        // Do nothing
                    }else{
                        commitArray.append(commit)
                        alreadyLoadedCommits.append(commit.sha)
                    }
                }
            }
            completion(commitArray)
        }) { (error) in
            errorCompletion(error)
        }
    }
    
    
    override init() {
        super.init()
    }
    
}
