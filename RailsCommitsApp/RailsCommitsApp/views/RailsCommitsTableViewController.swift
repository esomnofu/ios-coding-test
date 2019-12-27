import UIKit

class RailsCommitsTableViewController: UITableViewController {

    let loader = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        loader.style = .whiteLarge
        loader.backgroundColor = .green
        fetchAllRecentCommits()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.backgroundColor = .cyan
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return  100
    }
    
    
    
    func fetchAllRecentCommits(){
        loader.startAnimating()
        CommitApiService.sharedInstance.fetchCommitsFromApi(completion: { (fetchedCommitsArray) in
            self.loader.stopAnimating()
            print("res in view: ", fetchedCommitsArray)
        }) { (err) in
            self.loader.stopAnimating()
            self.callErrorHandler()
        }
    }
    
    
    func callErrorHandler(){
        handlePoorNetworkConnection(completion: {
            //call the API Call
            self.fetchAllRecentCommits()
        }, selfView: self)
    }

}
