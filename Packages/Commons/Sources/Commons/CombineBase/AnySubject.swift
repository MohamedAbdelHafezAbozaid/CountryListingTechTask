//
//  AnySubject.swift
//  Commons
//
//  Created by mohamed ahmed on 30/01/2025.
//

import Combine
import Foundation

public final class AnySubject<Output, Failure: Error>: Subject {
    public let base: Any

    let baseAsAnyPublisher: AnyPublisher<Output, Failure>
    let send: (Output) -> Void
    let sendCompletion: (Subscribers.Completion<Failure>) -> Void
    let sendSubscription: (Subscription) -> Void

    public init<S: Subject>(_ subject: S) where S.Output == Output, S.Failure == Failure {
        base = subject

        baseAsAnyPublisher = subject.eraseToAnyPublisher()
        send = subject.send
        sendCompletion = subject.send
        sendSubscription = subject.send
    }

    public func receive<S: Subscriber>(subscriber: S) where Failure == S.Failure, Output == S.Input {
        baseAsAnyPublisher.receive(subscriber: subscriber)
    }

    public func send(_ value: Output) {
        send(value)
    }

    public func send(completion: Subscribers.Completion<Failure>) {
        sendCompletion(completion)
    }

    public func send(subscription: Subscription) {
        sendSubscription(subscription)
    }
}

extension Subject {
    func eraseToAnySubject() -> AnySubject<Output, Failure> {
        return AnySubject(self)
    }
}
