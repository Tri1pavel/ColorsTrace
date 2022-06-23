//
//  StackInterface.swift
//  CT
//
//  Created by Development on 23.06.2022.
//

import Foundation

/// Generic stack interface.
protocol StackInterface {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
    func peek() -> Element?
}

/// An object that comforts generic stack interface. Use *Element* as generic associatedtype.
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
/// R eturns the last element of the stack.
/// ```
/// func peek() -> Element?
/// ```

struct Stack<Element>: StackInterface {
    typealias Element = Element
    
    private(set) var items: [Element] = []
    
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

