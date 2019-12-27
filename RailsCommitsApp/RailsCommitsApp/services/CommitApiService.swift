import UIKit

class CommitApiService: NSObject {
    
    static let sharedInstance = CommitApiService()
 
    
    func fetchCommitsFromApi(completion: @escaping ([Commit]) -> (), errorCompletion: @escaping (Any) -> (), CURRENT_PAGE:Int){
        var commitArray = [Commit]()
        var alreadyLoadedCommits = [String]()
        
        let RUBY_REPO = "rails/rails/commits?page=\(CURRENT_PAGE)"
        print(RUBY_REPO)
        
        regularGetRequest(apiUrl: BASE_URL+RUBY_REPO, completion: { (result) in
            
            if let arrayDictionary = result as? NSArray {
                
                if  arrayDictionary.count > 0 {
                    
                    
                    for item in arrayDictionary {
                        
                        guard let perCommitDictionary = item as? [String:Any] else  {return}
                        
                        guard let sha = perCommitDictionary["sha"] as? String else {return}
                        
                        guard let commitObj = perCommitDictionary["commit"] as? [String:Any] else  {return}
                        
                         guard let message = commitObj["message"] as? String else {return}
                        
                          guard let authorObj = commitObj["author"] as? [String:Any] else  {return}
                        
                         guard let name = authorObj["name"] as? String else {return}
                        
                        let eachCommitDictionary = ["name":name, "sha":sha, "message":message]
                        
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
            }
            
        }) { (error) in
            errorCompletion(error)
        }
    }
    
    
    override init() {
        super.init()
    }
    
}
