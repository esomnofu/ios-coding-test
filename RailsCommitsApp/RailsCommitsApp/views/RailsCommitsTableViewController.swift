import UIKit

class RailsCommitsTableViewController: UITableViewController {

    let reuseIdentifier = "reuseIdentifier"
    var localCurrentCount = 1
    var localCommitsArray = [Commit]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllRecentCommits(currentCount: localCurrentCount)
        view.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localCommitsArray.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        let currentCommit = localCommitsArray[indexPath.row]
        
        cell.textLabel?.attributedText = NSAttributedString.customAtrributedTextBold(string: currentCommit.name, size: 25, color: UIColor.black)
       
        cell.detailTextLabel?.numberOfLines = 0
        cell.detailTextLabel?.attributedText = NSAttributedString.customAtrributedTextRegularAndRegular(string1: "\(currentCommit.sha)\n", string2: currentCommit.message, size1: 14, size2: 12, color1: UIColor.black, color2: UIColor.darkGray)
        
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return  UITableView.automaticDimension
    }
    
    
    
    func fetchAllRecentCommits(currentCount:Int){
        START_PAGE_LOADING(viewcontroller: self)
        
        CommitApiService.sharedInstance.fetchCommitsFromApi(completion: { (fetchedCommitsArray) in
            
            //ADD VALUES TO LOCAL REF
            self.addToLocalCommitsArray(array: fetchedCommitsArray)
            
            //CHECK IF EMPTY AND ALERT USER
            if self.localCommitsArray.count == 0 {
                let alert = UIAlertController.alert(title: NO_COMMIT_TITLE, message: NO_COMMIT_MESSAGE)
                self.present(alert, animated: true)
            }
            
            //DETERMINE IF WE RECURSIVELY CALL FXN AGAIN OR DISPLAY TO USERS
            if self.localCommitsArray.count < MINIMUM_COMMITS_TO_DISPLAY {
                self.localCurrentCount += 1
                self.fetchAllRecentCommits(currentCount: self.localCurrentCount)
            }else {
                CLEAR_PAGE_LOADING_AND_TOASTS(viewcontroller: self)
                self.localCommitsArray = fetchedCommitsArray
                self.tableView.reloadData()
            }
           
      
        }, errorCompletion: { (err) in
            CLEAR_PAGE_LOADING_AND_TOASTS(viewcontroller: self)
            self.callErrorHandler()
        }, CURRENT_PAGE: currentCount)
        
        
    }
    
    func addToLocalCommitsArray(array: [Commit]){
        if array.count > 0 {
            for eachCommit in array {
                self.localCommitsArray.append(eachCommit)
            }
        }
    }
    
    func callErrorHandler(){
        handlePoorNetworkConnection(completion: {
            //call the API Call
            self.fetchAllRecentCommits(currentCount: self.localCurrentCount)
        }, selfView: self)
    }

}
