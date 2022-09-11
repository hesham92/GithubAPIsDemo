import Foundation

class Observerable<T> {
    private var listeners: [((T) -> Void)] = []
    var value: T {
        didSet {
            listeners.forEach {
                $0(value)
            }
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ listener: @escaping (T) -> Void) {
        listener(value)
        self.listeners.append(listener)
    }
}
