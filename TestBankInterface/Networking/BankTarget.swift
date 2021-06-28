//
//  Loguin.swift
//  TestBankInterface
//
//  Created by George de Araújo Apostolakis on 04/06/21.
//
import Moya

public enum BankTarget {
    case login
    case statements
}
//MARK: - BankTarget

extension BankTarget: TargetType {
    
    public var baseURL: URL {
        switch self {
            case .login:
                return URL(string: "https://run.mocky.io/v3/81c521b8-a959-4ead-b772-1d5c19a5468f")!
            case .statements:
                return URL(string: "https://6092aef785ff5100172136c2.mockapi.io/api")!
        }
    }
    
    public var path: String {
        switch self {
        case .login:
            return ""
        case .statements:
            return "/statements"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .login:
            return .get
        case .statements:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
        switch self {
        case .login:
            return .requestPlain
//            return .requestParameters(parameters: ["user": "test_user", "password": "Test@1"], encoding: JSONEncoding.default)
        case .statements:
            return.requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .login:
            return ["Content-Type" : "application/x-www-form-urlencoded"]
        case .statements:
            return ["Content-Type" : "application/x-www-form-urlencoded"]
        }
    }
}
