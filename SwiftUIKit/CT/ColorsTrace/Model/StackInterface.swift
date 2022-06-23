//
//  StackInterface.swift
//  CT
//
//  Created by Development on 23.06.2022.
//

import Foundation

protocol StackInterface {
    associatedtype Element
    mutating func push(_ element: Element)
    mutating func pop() -> Element?
    func peek() -> Element?
}

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

