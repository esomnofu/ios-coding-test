
import Foundation


let BASE_URL = "https://api.github.com/repos/"


//MARK: NETWORK ERROR LABELS
let NETWORK_ERROR_TIME = TimeInterval(9999999 * 999999)
let GENERIC_ERROR_MESSAGE_WITH_RETRY = "Something went wrong! - Tap to retry"
let NO_COMMIT_TITLE = "No commits found!"
let NO_COMMIT_MESSAGE = "Sorry, there are currently no commits on the repository you are trying to access"
let MINIMUM_COMMITS_TO_DISPLAY = 25
