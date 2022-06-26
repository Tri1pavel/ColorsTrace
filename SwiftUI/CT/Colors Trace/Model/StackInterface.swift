//
//  StackInterface.swift
//  CT
//
//  Created by Development on 26.06.2022.
//

import Foundation

protocol StackInterface {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
    func peek() -> Element?
}

/// Stack is an abstract data type, which is a list of elements organized according to the LIFO principle.
/// - Parameter items: Populate stack with initial values
///
/// Adds a new element at the end of the stack.
/// ```
/// func push(_ element: Element)
/// ```
///
/// Removes and returns the last element of the stack.
/// ```
/// func pop() -> Element?
/// ```
///
/// Returns the last element of the stack.
/// ```
/// func peek() -> Element?
/// ```
struct Stack<Element>: StackInterface {
    typealias Element = Element
    
    private var items: [Element] = []
    
    var isEmpty: Bool {
        items.isEmpty
    }
    
    init() {}
    init(items: [Element]) {
        self.items = items
    }
    
    mutating func push(_ element: Element) {
        items.append(element)
    }
    
    mutating func pop() -> Element? {
        items.popLast()
    }
    
    func peek() -> Element? {
        items.last
    }
}
