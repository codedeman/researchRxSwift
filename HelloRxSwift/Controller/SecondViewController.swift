//
//  SecondViewController.swift
//  HelloRxSwift
//
//  Created by KIENPT6 on 12/12/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources


class SecondViewController: UIViewController {
    
     let article = [Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman"),Article(name: "Kevin pham", avatar: "ironman.jpg", description: "I'm ironman")]
    
    let data = DataService.instance.getData()
    
    let dataSources = RxCollectionViewSectionedReloadDataSource<Travelers>?.self


    let disposeBag = DisposeBag()
    var datsource:Observable<[Article]>!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var userViewModel:ArticleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        datsource = Observable<[Article]>.just(self.article)

        
//        let layout = UICollectionViewFlowLayout()
//               layout.estimatedItemSize = CGSize(width: 160, height: 240)
//               self.collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
//               self.collectionView!.collectionViewLayout = layout
        
        collectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
        
        blindingUI()

        
    }
    
    
        
    
    func blindingUI(){
        
            
       
        datsource.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "CategoryCell", cellType: CategoryCell.self)){(row,data,cell) in
            
            cell.configureCell(user: data)
            
//            cell.avatarImage.image = UIImage(named: data.avatar)
        }.dispose()

        
        collectionView.rx.willDisplayCell
            .subscribe(onNext: ({ (cell,indexPath) in
                cell.alpha = 0
                let transform = CATransform3DTranslate(CATransform3DIdentity, -250, 0, 0)
                cell.layer.transform = transform
                UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
                    cell.alpha = 1
                    cell.layer.transform = CATransform3DIdentity
                }, completion: nil)
            })).disposed(by: disposeBag)
        
        
        
    }

}
