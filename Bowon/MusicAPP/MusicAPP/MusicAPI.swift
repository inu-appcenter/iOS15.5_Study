//
//  MusicAPI.swift
//  MusicAPP
//
//  Created by Bowon Han on 11/1/23.
//

import UIKit

class ArticleModel{
    
    
    
    
    //    func getArticles(for id: String) async throws -> UIImage {
    //        // 1. 요청할 url string에 담아두기
    //        let urlString = "https://itunes.apple.com/search?media=music&term={new jeans}"
    //
    //        // 2. 해당 스트링으로 인스턴스 생성
    //        let url = URL(string: urlString)
    //
    //        // 3. 만약 nil 이면 중지
    //        guard url != nil else {
    //            print("Couldn't create url object")
    //            return
    //        }
    //        // 4. url session 만들기
    //        let session = URLSession(configuration: .default)
    //
    //        // 5. URLSession이용하여 dataTask 만들기
    //        let datatask = session.dataTask(with: url!){
    //            (data, response, error) in
    //                // 6. 에러 없고 데이터 성공적으로 불러왔을때만 동작
    //            if error == nil && data != nil{
    //                // 7. json 데이터를 swift 인스턴스 객체로 바꿔주기 위해 decoder 객체 생성
    //                let decoder = JSONDecoder()
    //                // 8. 예기치 못한 에러를 발생할 수 있으므로 try-catch 문 작성 (do - catch)
    //                do {
    //                    // 9. try문을 앞에 붙여서 json 데이터를 이전에 만들어준 articleservice 모양의 swift 인스턴스로 파싱해줍니다
    //                    let articleService = try decoder.decode(ArticleSevice.self, from: data!)
    //                    // 10. 데이터 성공적을 받아왔을 시 articlemodelprotocol의 articlesretrieved 함수를 이용해 article을 뷰 컨트롤러롤 보냄
    //                    DispatchQueue.main.async {
    //                        self.delegate?.articlesRetrieved(articles: articleService.results!)
    //                    }
    //                }
    //                catch {
    //                    print("Error parsing the JSON")
    //                }
    //            }
    //        }
    //        // 11. datatask 준비 되었다면 실행
    //        datatask.resume()
    //    }
    //}
}
