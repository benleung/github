import Combine

// note: this is not a test, but an utility class to assist writing tests
final class TestableSubscriber<Input, Failure>: Subscriber where Failure: Error {
    private(set) var value: Input!
    private(set) var successCallCount: Int = 0
    private(set) var failureCallCount: Int = 0

    init() {}

    func receive(subscription: Subscription) {
        subscription.request(.unlimited)
    }

    func receive(_ input: Input) -> Subscribers.Demand {
        value = input
        successCallCount += 1
        return .none
    }

    func receive(completion _: Subscribers.Completion<Failure>) {
        failureCallCount += 1
    }
}
