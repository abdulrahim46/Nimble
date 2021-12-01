//
//  ResponseData.swift
//  Nimble
//
//  Created by Abdul Rahim on 30/11/21.
//

import Foundation

struct ResponseData<T: Codable>: Codable {
  let data: T
  
  init(jsonData: Data) throws {
    let jsonDecoder = JSONDecoder()
    let responseData = try jsonDecoder.decode(ResponseData<T>.self, from: jsonData)
    print(T.self)
    print(responseData)
    self = responseData
  }
}
