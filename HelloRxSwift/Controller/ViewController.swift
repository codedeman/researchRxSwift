//
//  ViewController.swift
//  HelloRxSwift
//
//  Created by KIENPT6 on 12/11/19.
//  Copyright © 2019 KIENPT6. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class ViewController: UIViewController {
    private let publish = Published<String>(initialValue: "")
    private let behavior = BehaviorSubject<String>(value: "")
    
    let disposeBag = DisposeBag()
    let first = Observable.of(1,2,3)
    let second = Observable.of(4,5,6)
    let left = PublishSubject<Int>()
    let right = PublishSubject<Int>()
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    
    let button = PublishSubject<String>()
    
    let textFiel = PublishSubject<String>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        combineLatest()
        startWith()
        // Do any additional setup after loading the view.
    }
    func mergerOperator()  {
        
        let source = Observable.of(left.asObserver(),right.asObserver())
        let obserable  = source.merge()
        obserable.subscribe(onNext: { (event) in
            print(event)
            }, onError: nil , onCompleted: nil)
        
        left.onNext(1)
        left.onNext(2)
        left.onNext(3)
        
        right.onNext(4)
        right.onNext(5)
        right.onNext(6)
        
    }
    
    func concatOperator()  {
        let obserable = Observable.concat([first,second])
        
        obserable.subscribe(onNext: { (event) in
            
            print("event \(event)")
                
        }, onError: nil , onCompleted: nil).dispose()
       
    }
    
    func combineLatest(){
    
        let obserable = Observable.combineLatest(left,right, resultSelector: { lastLeft,lastRight in
            "\(lastLeft) \(lastRight)"
        })
        
        let disposable = obserable.subscribe(onNext: { (event) in
            
            print(event)
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
//        left.onNext(45)
//        left.onNext(40)
        left.onNext(60)
        right.onNext(99)
        left.onNext(40)

        right.onNext(2)
        right.onNext(33)
        
        
        
    
            
    }
    
    func withLatest(){
        
        let observable =  button.withLatestFrom(textFiel)
        let disposable = observable.subscribe(onNext: { (event) in
            
            print("event \(event)")
        }, onError: nil, onCompleted: nil, onDisposed: nil)
        
        textFiel.onNext("Hello")
        textFiel.onNext("RxSwift")
        
    }
    
    func startWith(){
        
        let number = Observable.of(2,3,5)
        
        let obserable = number.startWith(1)
        obserable.subscribe(onNext: { (event) in
            
            print("event \(event)")
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).dispose()
        
        
    }
    
    
    
    
    


}


