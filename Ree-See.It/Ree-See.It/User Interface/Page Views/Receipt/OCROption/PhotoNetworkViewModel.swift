//
//  PhotoNetworkViewModel.swift
//  Ree-See.It
//
//  Created by Yongye Tan on 11/11/23.
//

import Foundation

public class PhotoNetworkViewModel: ObservableObject {
    init() { }
    
    func generateBoundary() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
}

extension Data {
   mutating func append(_ string: String) {
      if let data = string.data(using: .utf8) {
         append(data)
         print("data======>>>",data)
      }
   }
}
