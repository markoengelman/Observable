# Observable
- Observable is an alternative mechanism for observing model changes and reacting to those changes using @propertyWrapper’s introduced in Swift 5.
- To read more about motivation behind it please see my article about it: https://markoengelman.com/observing-model-changes-using-propertywrapper/

## Code
```Swift
@propertyWrapper
class Observable<T> {
    class ObservableToken {
        private let cancellationClosure: () -> Void
        
        init(_ cancellationClosure: @escaping () -> Void) {
            self.cancellationClosure = cancellationClosure
        }
        
        func cancel() {
            cancellationClosure()
        }
    }
    
    private (set) var observers: [UUID: (T) -> Void] = [:]
    
    var value: T
    
    init(value initialValue: T) {
        self.value = initialValue
        self.wrappedValue = initialValue
    }
    
    var wrappedValue: T {
        get { value }
        set {
            value = newValue
            observers.forEach { $0.value(newValue) }
        }
    }
    
    var projectedValue: Observable<T> { return self }
    
    @discardableResult
    func observe(_ closure: @escaping (T) -> Void) -> ObservableToken {
        let id = UUID()
        let token = ObservableToken { [weak self] in self?.observers.removeValue(forKey: id) }
        observers[id] = closure
        return token
    }
}
```
## How to use
- For demostrantion how to use please see my article about it: https://markoengelman.com/observing-model-changes-using-propertywrapper/
