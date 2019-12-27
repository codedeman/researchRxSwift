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
        concatOperator()
//         mergerOperator()
        
//        tranformFlatmapLatest()
        
//        tranformFlatmap().subscribe(onNext: { (event) in
//
//            print(event)
//
//        }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
//
//        tranformData().subscribe(onNext: { (event) in
//            print(event)
//            }).disposed(by: disposeBag)
//
//        combineLatest()
//        startWith()
//        creteRxSwift()
        
        
//        mergerOperator()
        // Do any additional setup after loading the view.
    }
    func mergerOperator()  {
        

        
        let source = Observable.of(left.asObserver(),right.asObserver())
        let obserable  = source.merge()
        obserable.subscribe(onNext: { (event) in
            print(event)
            }, onError: nil , onCompleted: nil)
        
        
        left.onNext(1)
        right.onNext(4)
        left.onNext(2)
        left.onNext(3)
        right.onNext(6)


        
        
    }
    
    func creteRxSwift()  {
        
        let source: Observable = Observable<Int>.create { (event) -> Disposable in
            
            for i in 1 ... 5 {
                event.on(.next(i))
            }
            event.onCompleted()
            return Disposables.create {
                print("disposed")
            }
            
        }
        
        source.subscribe{
        
            print($0)
        }

    }
    
    func concatOperator()  {
        
        

        let obserable = Observable.concat([left,right])
        
        obserable.subscribe(onNext: { (event) in
            
            print("event \(event)")
                
        }, onError: nil , onCompleted: nil).disposed(by: disposeBag)
        
        left.onNext(1)
        right.onNext(4)
        left.onNext(2)
        left.onNext(3)
        right.onNext(6)
       
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
        
        let obserable = number.startWith(6,7)
        obserable.subscribe(onNext: { (event) in
            print("event \(event)")
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).dispose()
        
        
    }
    
    
    func tranformData() -> Observable<String> {
        
        return Observable.of(1,2,3).map{String("\($0)")}
    }
    
    func tranformFlatmap() -> Observable<String> {
        
        return Observable.of(1,2,3,4).flatMap(generateTransformation)
    }
    
    
    
   
    func generateTransformation(int: Int) -> Observable<String> {
        return Observable.just(String("Number: \(int)") )
    }
    
    func  tranformFlatmapLatest()  {
        
        let outerObservable = Observable<Int>.interval(0.5, scheduler: MainScheduler.instance).take(2)
        let combineObservable = outerObservable.flatMapLatest {  value in
            return Observable<NSInteger>.interval(0.3, scheduler: MainScheduler.instance).take(3).map {  inerValue in
                print("Outer value \(value) Iner Value \(inerValue)")
            }
        }
        combineObservable.subscribe(onNext: { (event) in
            print("event \(event)")
        }, onError: nil, onCompleted: nil).disposed(by: disposeBag)
    }
    


}


