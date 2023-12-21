//
//  MoyaProvider+.swift
//  ToDoListApp
//
//  Created by 이대현 on 12/20/23.
//

import Moya

extension MoyaProvider {
    func request(_ target: Target) async -> Result<Response, MoyaError> {
        await withCheckedContinuation { continuation in
            self.request(target) { result in
                continuation.resume(returning: result)
            }
        }
    }
}
