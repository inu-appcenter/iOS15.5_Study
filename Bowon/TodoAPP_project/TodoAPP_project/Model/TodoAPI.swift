//
//  TodoAPI.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 12/20/23.
//

import Foundation

enum FetchError: Error {
    case invalidStatus
    case jsonDecodeError
}
    
enum TodoAPI {
    static let baseURL = "http://hyeseong.na2ru2.me/api/tasks"

    case createTodo(userid: Int,
                    title: String,
                    description: String,
                    endDate: String)
    
    case modifyTodoSuccess(id: Int)
    case deleteTodo(id: Int)
    case fetchTodo
    case modifyTodo(id: Int,
                    title: String,
                    description: String,
                    endDate: String,
                    isFinished: Bool)
    
    var path: String{
        switch self {
        case .createTodo(let userid,_,_,_):
            return "/\(userid)"
        case .deleteTodo(let id):
            return "/\(id)"
        case .fetchTodo:
            return "/2"
        case .modifyTodoSuccess(let id):
            return "/\(id)"
        case .modifyTodo(let id, _, _, _, _):
            return "/\(id)"
        }
    }
    
    var method: String {
        switch self {
        case .createTodo:
            return "POST"
        case .deleteTodo:
            return "DELETE"
        case .fetchTodo:
            return "GET"
        case .modifyTodoSuccess:
            return "GET"
        case .modifyTodo:
            return "PUT"
        }
    }
    
    var url: URL {
        return URL(string: TodoAPI.baseURL + path)!
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
        
    func performRequest(with parameters: Encodable? = nil) async throws {
        var request = self.request

        if let parameters = parameters {
            request.httpBody = try JSONEncoder().encode(parameters)
        }

        let (data, response) = try await URLSession.shared.data(for: request)

        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw FetchError.invalidStatus
        }

        if case .fetchTodo = self {
            let todoList = try JSONDecoder().decode([Todo].self, from: data)
            print("Todo List: \(todoList)")
        } else {
            let todo = try JSONDecoder().decode(Todo.self, from: data)
            print("Response data: \(todo)")
        }
    }
}


