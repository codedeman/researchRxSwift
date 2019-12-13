//
//  Traveler.swift
//  HelloRxSwift
//
//  Created by KIENPT6 on 12/13/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
struct Traveler {
    let name: String
    let avater: UIImage?
}

struct Travelers {
    var travelers: [Traveler]
}

extension Travelers:SectionModelType{
    typealias Item = Traveler

    var items: [Traveler] { return travelers }

    init(original: Travelers, items: [Traveler]) {
        self = original
        travelers = items
    }
}
