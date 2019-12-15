  Observable được ví như trái tim của RX Swift        
Observable sequences có thể phát ra không hoặc nhiều trong vòng đời của nó  với 3 trạng thái 
###  .next(value: T) — khi thêm giá trị vào  một observable sequence 

### .error(error: Error) — Nếu gặp phải Error một chuỗi sẽ phát ra sự kiện lỗi , và sẽ kết thúc chuỗi 

### .completed — Nếu một chuỗi kết thúc nó sẽ gửi event hoàn thành đến  subscribers
Observable:Là  thằng phát ra thông báo thay đổi 
 Observable.of   sẽ in toàn bộ mảng
Observable.from in các thành phần trong mảng
Oberver:  Đăng ký một  và  lắng nghe khi có một observable thay đổi 

### Subjects 
### PublishSubject 
Là nó chỉ phát ra sự kiện mới nhất của subscribers, mà nó không phát lại đến sự kiện tiếp theo , do đó bất cứ sự kiện nào trước  subscribers sẽ không được phát ra 
Ví  dụ  thực tế  publish  giống như  là vào lớp muộn nhưng chỉ cần nghe 1 điểm nó cần nghe 

code example
```swift
    let subject = PublishSubject<String>()

    subject.onNext("Emmit 1")

    subject.subscribe(onNext: { (event) in

    print("event \(event)")
    }).disposed(by: disposeBag)

    subject.onNext("Emmit 2")
``` 
Kết quả sẽ là  event Emmit 2

### BehaviourSubject

1   behavior subject  cung cấp cho  subscriber bất cứ cái gì được phát ra trước và sau  subscriber
V í dụ thực tế behavior là một thằng vào lớp muộn nhưng muốn nghe toàn bộ những gì gần nhất có nghĩa là nó chấp nhận bất cứ event nào 

code example

```swift
    let subject = BehaviorSubject(value: "")
    subject.onNext("Issue 1")

    subject.subscribe(onNext: { (event) in

    print("event \(event)")

    }).disposed(by: disposeBag)

    subject.onNext("Issue 2")

```
Kêt quả sẽ là 

event Issue 1 
event Issue 2

### Replay Trong một vài trường hợp bạn muốn  một subscriber mới nhận các event mới nhất từ sequence đang đăng ký, Mặc dù đã được phát ra trước đó subject có thể lữu trữ lại và phát  lại cho một subscriber tại thời điểm đăng ký, tóm cái váy lại nó sẽ phát sự kiện nó 

code example 



###  ReplaySubject 
là khởi tạo với một kích thước và duy trì bộ đệm của các phần tử có kích thước đó và phát lại số event mới nhất được set trong kích thứớc bufferSize 
```swift
    let replaySub = ReplaySubject<String>.create(bufferSize: 2)

    replaySub.onNext("Issue #1")
    replaySub.onNext("Issue #2")
    replaySub.onNext("Issue #3")
    replaySub.onNext("Issue #5")
    replaySub.onNext("Issue #6")
    replaySub.onNext("Issue #7")

    replaySub.subscribe { (event) in
        
        print("event \(event)")
    }
```

Kết quả sẽ là:
event next(Issue #6)
event next(Issue #7)

### 



### Combining Observables


### Concat 
1 Obserable 2 hoặc nhiều chuỗi 
2 Observable nhiều chuỗi nối tiếp trong  một Obserable  theo thứ tự của Obserable  
3 Hoàn thành Observable đầu tiên rồi đến Observable tiếp theo …
4 Được sử dụng như một hàm static hoặc phương thức của observable 

Example 
```swift

    let first = Observable.of(1,2,3)
    let second = Observable.of(4,5,6)

    let obserable = Observable.concat([first,second])

    obserable.subscribe(onNext: { (event) in

    print("event \(event)")

    }, onError: nil , onCompleted: nil).dispose()

```

Kết quả sẽ là 1,3,4,5,6

 
 
 
### Merger  Kết hợp nhiều observable trong một lần phát ra 
 
Có thể kết hợp nhiều output của Observable vì thế nó như một Observable  khi sử dụng merger 
 
Example
```swift
    let left = PublishSubject<Int>()
    let right = PublishSubject<Int>()

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
```
 
### Start with 
 
Phát ra một chuỗi được chỉ địnnh trước  
 
Code example 
 ```swift
 
func startWith(){
        let number = Observable.of(4,5,6)
        let obserable = number.startWith(1,2,3)
        obserable.subscribe(onNext: { (event) in
            print("event \(event)")
            
        }, onError: nil, onCompleted: nil, onDisposed: nil).dispose()
       
    }
```
 
 
Kết quả lúc này sẽ là 
 
1,2,3,4,5,6,7
 
### Create 
 ```swift
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
 
 ```
 ### RxSwift Transforming
 ### map
 
 code example
 
 ```swift
 
 let observable1 = Observable.of(1,2,3)

 observable1.map {
     
     return  $0 * 2
 }.subscribe(onNext: { (event) in
     print("event \(event)")
 }).disposed(by: disposeBag)
 
 ```
 
 ### flat map
 
 code example 
 Đầu tiên cần phải khởi tạo 1 struct 
 ``` swift 
 struct Player {
     var score:BehaviorRelay<Int>
     
 }
 
 ```
 
 ``` swift
 let kevin  = Player(score: BehaviorRelay(value: 50))
 
 let player = PublishSubject<Player>()
 
 player.asObservable().flatMap { $0.score.asObservable()}.subscribe(onNext: { (event) in
     
     print("event \(event)")
     }).disposed(by: disposeBag)
 
 player.onNext(kevin)
 
 
 ```
 Kết quả lúc này sẽ là event 50 
 
 ### Filtering Operators 
 ### Element at 
  Sẽ lấy một phần tử nằm ở một vị trí xác định trong chuỗi mà bạn muốn nhận được và bỏ qua các thành phần khác 
  
  ``` swift 
  
        let observable1 = Observable.of(1,2,3)

       observable1.elementAt(2).subscribe(onNext: { (event) in
           print("event: \(event)")
       }).disposed(by: disposeBag)
  
  ```
  
  Kết quả lú này sẽ là 3
  
  ### Filter 
  
  Chỉ phát ra những phần tử thoả mãn điều kiện 
  
  
  code example
  
  ```swift
 
     let observable1 = Observable.of(1,2,3,4,5,6)
     
     observable1.filter { $0 % 2 == 0
     
     }.subscribe(onNext: { (event) in
     
     print("event \(event)")
     }).disposed(by: disposeBag)
 
 ```
 ### Skipping operators
 Cho phép bỏ qua phần tử khi  truyền vào 1 prametter 
 
 code example
 ```swift 
 
 
  let observable1 = Observable.of("A","B","C","D","E","F")
         
         observable1.skip(0).subscribe { (event) in

             print(event)
         }.disposed(by: disposeBag)
 
 
 ```
 kêt quả sẽ là 
 next(B)
 next(C)
 next(D)
 next(E)
 next(F)
 completed
 ###  skipWhile
 
 




