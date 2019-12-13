//
//  ArticleViewModel.swift
//  HelloRxSwift
//
//  Created by KIENPT6 on 12/12/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import Foundation

import RxDataSources
import RxSwift
import RxCocoa


class ArticleViewModel:NSObject{
    
    
    
    let items = Variable<[Travelers]>([
           Travelers(travelers: [Traveler(name: "Bob", avater: UIImage(named: "ironman.jpg"))])
       ])
    
    
    var user:BehaviorSubject<[Article]>  = BehaviorSubject(value: [])
    
    
    let article = [Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman")]
    
    override init() {
           super.init()
            print(article)
//           blindingData()
       }
    
    func getData() -> [Article] {
        
        
        return article
    }
    
   
    
    func blindingData()  {
        user.onNext(article)
//        print("data \(getData())")
    }
    
}
