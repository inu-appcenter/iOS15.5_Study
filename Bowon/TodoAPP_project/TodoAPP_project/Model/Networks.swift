//
//  Network.swift
//  TodoAPP_project
//
//  Created by Bowon Han on 11/26/23.
//

import Foundation

enum FetchError: Error {
    case invalidStatus
    case jsonDecodeError
}

class Networks {
    static let shared = Networks()
    
    var todoDataSource : [Todo] = []
    
    private init() {}
        
//    func fetchAllTodoList(_ id: Int) {
//        guard let url = URL(string: "http://hyeseong.na2ru2.me/api/members/tasks/\(id)") else { return }
//        
//        Task {
//            do {
//                let todoInformation = try await self.fetchTodoInfo(url: url)
//                self.todoDataSource = todoInformation
//                print(todoDataSource)
//            } catch {
//                print("Error: \(error)")
//            }
//        }
//    }
    
    func createTodoList(title: String,
                        description: String = "null" ,
                        endDate: String = "null",
                        id: Int) {
        guard let url = URL(string: "http://hyeseong.na2ru2.me/api/tasks/\(id)") else { return }
        
        Task {
            do {
                try await self.createTodoInfo(url: url,
                                              param:["title": title,
                                                     "description":description,
                                                     "endDate":endDate])
            } catch {
                print("createError: \(error)")
            }
        }
    }
    
    func modifyTodoList(title: String,
                        description: String = "null" ,
                        isFinished: Bool ,
                        endDate: String = "null",
                        id: Int) {
        guard let url = URL(string: "http://hyeseong.na2ru2.me/api/tasks/\(id)") else { return }
        
        Task {
            do {
                try await self.modifyTodoInfo(url: url,
                                              param:["title": title,
                                                     "description":description,
                                                     "endDate":endDate,
                                                     "isFinished": isFinished])
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func deleteTodoList(_ id: Int) {
        guard let url = URL(string: "http://hyeseong.na2ru2.me/api/tasks/\(id)") else { return }
        
        Task {
            do {
                try await self.deleteTodoInfo(url: url)
            } catch {
                print("deleteError: \(error)")
            }
        }
    }
    
    
// MARK: - todoInfo network
    func fetchTodoInfo(url: URL) async throws -> [Todo] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else{
            throw FetchError.invalidStatus
        }
        
        let todoInformation = try JSONDecoder().decode([Todo].self, from: data)
        return todoInformation
    }
    
    private func createTodoInfo(url: URL, param: [String: Any]) async throws {
        let sendData = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = sendData
                        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
                
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else{
                throw FetchError.invalidStatus
            }
            print("Response data: \(data)")
        } catch {
            print("CreateError: \(error)")
        }
    }
    
    private func deleteTodoInfo(url: URL) async throws {
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
                        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
                
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else{
                throw FetchError.invalidStatus
            }
            print("Response data: \(data)")
        } catch {
            print("DeleteError: \(error.localizedDescription)")
        }
    }
    
    private func modifyTodoInfo(url: URL, param: [String: Any]) async throws {
        let sendData = try! JSONSerialization.data(withJSONObject: param, options: [])
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = sendData
                        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
                
            guard let httpResponse = response as? HTTPURLResponse,
                  (200..<300).contains(httpResponse.statusCode) else{
                throw FetchError.invalidStatus
            }
            print("Response data: \(data)")
        } catch {
            print("ModifyError: \(error.localizedDescription)")
        }
    }
}
