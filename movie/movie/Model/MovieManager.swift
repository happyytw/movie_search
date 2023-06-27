//
//  MovieManager.swift
//  movie
//
//  Created by Taewon Yoon on 2023/06/27.
//

import Foundation
import SwiftyJSON

protocol MovieManagerDelegate {
    func didUpdateMovie(_ movieManager: MovieManager, movie: [Show])
}

struct MovieManager {
    var delegate: MovieManagerDelegate?
    
    func fetchMovie(movieName: String){
        let urlString = "https://api.tvmaze.com/search/shows?q=\(movieName)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        print("여기1")
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String) {
        print("여기")
        if let url = URL(string: urlString) {
            print("여기2")
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Error in URL: \(error)")
                    return
                }
                print("여기3")
                if let data = data {
                    print("여기4")
                    do {
                        let decoded = try JSONDecoder().decode([Show].self, from: data)

                        self.delegate?.didUpdateMovie(self, movie: decoded)
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                    print("여기5")
                }
                print("여기6")
            }
            task.resume()
        }
    }
}
