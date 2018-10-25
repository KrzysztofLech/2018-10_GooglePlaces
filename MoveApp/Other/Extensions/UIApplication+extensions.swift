//
//  Copyright © 2018 Krzysztof Lech. All rights reserved.

import UIKit

extension UIApplication{
    
    class func getPresentedViewController() -> UIViewController? {
        var presentViewController = UIApplication.shared.keyWindow?.rootViewController
        while let pVC = presentViewController?.presentedViewController {
            presentViewController = pVC
        }
        return presentViewController
    }
}
