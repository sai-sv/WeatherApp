//
//  Helpers.swift
//  WeatherApp
//
//  Created by Admin on 03.12.2019.
//  Copyright © 2019 sergei. All rights reserved.
//

import Foundation

class Box<T> {
    typealias Listner = (T) -> ()
    
    private var value: T {
        didSet {
            listner?(value)
        }
    }
    private var listner: Listner?
    
    init(value: T) {
        self.value = value
    }
    
    public func bind(listner: @escaping Listner) {
        self.listner = listner
        listner(self.value)
    }
}
