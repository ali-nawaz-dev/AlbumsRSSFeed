//
//  UIFontExtension.swift
//  AlbumsRSSFeed
//
//  Created by Sheikh Ali on 06/08/2022.
//

import Foundation
import UIKit

extension UIFont {
    
  class var h1: UIFont {
    return UIFont.systemFont(ofSize: 34.0, weight: .bold)
  }
    
  class var body2: UIFont {
    return UIFont.systemFont(ofSize: 18.0, weight: .regular)
  }
    
  class var subtitle: UIFont {
    return UIFont.systemFont(ofSize: 16.0, weight: .bold)
  }
    
  class var body1: UIFont {
    return UIFont.systemFont(ofSize: 16.0, weight: .semibold)
  }
    
  class var caption: UIFont {
    return UIFont.systemFont(ofSize: 12.0, weight: .medium)
  }
    
}
