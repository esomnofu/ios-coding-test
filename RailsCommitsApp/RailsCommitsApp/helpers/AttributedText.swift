import UIKit

protocol NSAttributedStringExtension {
    static func customAtrributedTextRegularAndRegular(string1:String, string2:String, size1:CGFloat, size2:CGFloat, color1:UIColor, color2:UIColor) -> NSAttributedString
}


extension NSAttributedString : NSAttributedStringExtension {
    
    class func customAtrributedTextRegularAndRegular(string1: String, string2: String, size1: CGFloat, size2: CGFloat, color1: UIColor, color2: UIColor) -> NSAttributedString {
        
        let attrs1 = [NSAttributedString.Key.font : UIFont(name: "Arial-BoldItalicMT", size: size1)!, NSAttributedString.Key.foregroundColor : color1]
        let attrs2 = [NSAttributedString.Key.font : UIFont(name: "ArialMT", size: size2)!, NSAttributedString.Key.foregroundColor : color2]
        
        let attributedString1 = NSAttributedString(string:string1, attributes:attrs1)
        let attributedString2 = NSAttributedString(string:string2, attributes:attrs2)
        
        let tmpStr : NSMutableAttributedString = attributedString1.mutableCopy() as! NSMutableAttributedString
        tmpStr.append(attributedString2)
        let finalStr : NSAttributedString = tmpStr.copy() as! NSAttributedString
        
        return finalStr
    }
    
    class func customAtrributedTextBold(string:String, size:CGFloat, color:UIColor) -> NSAttributedString {
        let attrs = [NSAttributedString.Key.font : UIFont(name: "Arial-BoldMT", size: size)!, NSAttributedString.Key.foregroundColor : color]
        return NSAttributedString(string: string, attributes: attrs)
    }
    
    
}



