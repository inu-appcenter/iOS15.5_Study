//
//  TodoAPI.swift
//  ToDoListApp
//
//  Created by 이대현 on 11/29/23.
//

import Foundation
import Moya

let USERID = 1 // 해당 id에 해당하는 유저의 todolist 불러옴
enum TodoAPI {
    case getList
    case createTodo(_ params: TodoRequestDTO)
    case updateCheck(_ id: Int, _ completed: Bool)
    case deleteTodo(_ id: Int)
}

extension TodoAPI: TargetType {
    
    var baseURL: URL  {
        return URL(string: "http://hyeongjun.na2ru2.me")!
    }
    
    var path: String {
        switch self {
        case .getList:
            return "/users/search/\(USERID)"
        case .createTodo(_):
            return "/todos/\(USERID)"
        case .updateCheck(_, _):
            return "/todos/check"
        case .deleteTodo(let id):
            return "/todos/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getList:
            return .get
        case .createTodo(_):
            return .post
        case .updateCheck(_, _):
            return .put
        case .deleteTodo(_):
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getList:
            return .requestPlain
        case .createTodo(let params):
            return .requestJSONEncodable(params)
        case .updateCheck(let id, let completed):
            let params: [String: Any] = [
                "id": id,
                "completed": completed
            ]
            return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
        case .deleteTodo(_):
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
}
