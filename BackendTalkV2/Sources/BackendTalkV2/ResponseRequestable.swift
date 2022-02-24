//
//  ResponseRequestable.swift
//  
//
//  Created by Алексей on 24-Feb-22.
//

import Foundation

public protocol ResponseRequestable: Requestable {
    associatedtype Response
    
    var responseDecoder: ResponseDecoder { get }
}
