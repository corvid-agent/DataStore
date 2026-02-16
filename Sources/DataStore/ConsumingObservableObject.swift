#if canImport(Combine)
import Combine
import Foundation

/// An `ObservableObject` that can consume and observe changes in other `ObservableObject` instances.
open class ConsumingObservableObject: ObservableObject, @unchecked Sendable {
    private let bagLock = NSLock()
    private var bag: Set<AnyCancellable> = Set()

    deinit {
        bagLock.lock()
        bag.removeAll()
        bagLock.unlock()
    }

    public init() { }

    /// Consume changes from the specified `ObservableObject` instance.
    ///
    /// - Parameter object: The `ObservableObject` to consume.
    public func consume<Object: ObservableObject>(
        object: Object
    ) where ObjectWillChangePublisher == ObservableObjectPublisher {
        bagLock.lock()
        defer { bagLock.unlock() }
        bag.insert(
            object.objectWillChange.sink(
                receiveCompletion: { _ in },
                receiveValue: { [weak self] _ in
                    self?.objectWillChange.send()
                }
            )
        )
    }
}
#endif
