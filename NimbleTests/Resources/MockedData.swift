//
//  MockedData.swift
//  NimbleTests
//
//  Created by Abdul Rahim on 02/12/21.
//

import Foundation

public final class MockedData {
    public static let loginJSON = Bundle(for: MockedData.self).url(forResource: "LoginAPIResponse", withExtension: "json")!
    public static let surveyJSON = Bundle(for: MockedData.self).url(forResource: "SurveyAPIResponse", withExtension: "json")!
}

internal extension URL {
    var data: Data {
        return try! Data(contentsOf: self)
    }
}
