//
//  APICaller.swift
//  Netflix Clone
//
//  Created by Yun Ni on 2024-06-11.
//

import Foundation

struct Constatns {
    static let API_KEY = "f2ae7a534a7f7b926545aaec95675ffb"
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constatns.baseURL)/3/trending/movie/day?api_key=\(Constatns.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let reselts = try JSONDecoder().decode(TrendingMovieResponse.self, from: data)
                completion(.success(reselts.results))
            } catch {
                completion(.failure(error))
            }
          
            
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[String], Error>)-> Void) {
        
        guard let url = URL(string: "\(Constatns.baseURL)/3/trending/tv/day?api_key=\(Constatns.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print(results)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        
        task.resume()
    }
        
}
