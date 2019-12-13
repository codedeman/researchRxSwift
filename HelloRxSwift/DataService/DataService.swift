//
//  DataService.swift
//  HelloRxSwift
//
//  Created by KIENPT6 on 12/13/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class DataService {
    
    static let instance = DataService()
    
     let article = [Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman")]
    
     let article2 = [Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman")]
    
    
   
    func getData() -> [Article] {
        
        return article2
    }
    
//    func concatOperator()  {
//           let obserable = Observable.concat([first,second])
//
//           obserable.subscribe(onNext: { (event) in
//
//               print("event \(event)")
//
//           }, onError: nil , onCompleted: nil).dispose()
//
//       }
}
