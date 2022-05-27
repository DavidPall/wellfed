//
//  FlagService.swift
//  WellFed
//
//  Created by Pall David on 27.05.2022.
//

import Foundation

class FlagService {
    
    static let shared: FlagService = FlagService()
    
    func countryFlag(countryCode: String) -> String {
      let base = 127397
      var tempScalarView = String.UnicodeScalarView()
      for i in countryCode.utf16 {
        if let scalar = UnicodeScalar(base + Int(i)) {
          tempScalarView.append(scalar)
        }
      }
      return String(tempScalarView)
    }
}
