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
    static let YoutubeAPI_KEY = "AIzaSyCTViHoPd-R4MqOOv4DFHaknh9ox8Irwvg"
    static let YoutubeBaseURL = "https://youtube.googleapis.com/youtube/v3/search?"
}

enum APIError: Error {
    case failedTogetData
}

class APICaller {
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        
        guard let url = URL(string: "\(Constatns.baseURL)/3/trending/movie/day?api_key=\(Constatns.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let reselts = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(reselts.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
          
            
        }
        task.resume()
    }
    
    func getTrendingTvs(completion: @escaping (Result<[Title], Error>)-> Void) {
        
        guard let url = URL(string: "\(Constatns.baseURL)/3/trending/tv/day?api_key=\(Constatns.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data,_,error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let results = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(results.results))
            }
            catch {
                completion(.failure(APIError.failedTogetData))
            }
        }
        
        task.resume()
    }
        
    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>)-> Void) {
        guard let url = URL(string: "\(Constatns.baseURL)/3/movie/upcoming?api_key=\(Constatns.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let reselts = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(reselts.results))
//                completion(.success(reselts.results))
            } catch {
//                completion(.failure(error))
                completion(.failure(APIError.failedTogetData))
            }
          
            
        }
        task.resume()
    }
    
    func getPopular(completion: @escaping (Result<[Title], Error>)-> Void) {
        guard let url = URL(string: "\(Constatns.baseURL)/3/movie/popular?api_key=\(Constatns.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let reselts = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(reselts.results))
//                completion(.success(reselts.results))
            } catch {
//                completion(.failure(error))
//                print(error.localizedDescription)
                completion(.failure(APIError.failedTogetData))

            }
          
            
        }
        task.resume()
    }
    
    func getTopRated(completion: @escaping (Result<[Title], Error>)-> Void) {
        guard let url = URL(string: "\(Constatns.baseURL)/3/movie/top_rated?api_key=\(Constatns.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let reselts = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(reselts.results))
//                completion(.success(reselts.results))
            } catch {
//                completion(.failure(error))
//                print(error.localizedDescription)

                completion(.failure(APIError.failedTogetData))
            }
          
            
        }
        task.resume()
    }
    
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>)-> Void) {
        
        guard let url = URL(string: "\(Constatns.baseURL)/3/discover/movie?api_key=\(Constatns.API_KEY)&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&with_watch_monetization_type=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let reselts = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(reselts.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
          
            
        }
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>)-> Void) {
        
        
        // formating the url
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constatns.baseURL)/3/search/movie?api_key=\(Constatns.API_KEY)&query=\(query)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let reselts = try JSONDecoder().decode(TrendingTitleResponse.self, from: data)
                completion(.success(reselts.results))
            } catch {
                completion(.failure(APIError.failedTogetData))
            }
          
            
        }
        task.resume()
    }
    
    func getMovie(with query: String, completion: @escaping (Result<VideoElement, Error>)-> Void) {
        
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constatns.YoutubeBaseURL)q=\(query)&key=\(Constatns.YoutubeAPI_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data,_, error in
            guard let data = data, error == nil else{
                return
            }
            do{
                let results = try JSONDecoder().decode(YoutubeSearchResponse.self, from: data)
                
                completion(.success(results.items[0]))
                
                
            } catch {
                completion(.failure(error))
                print(error.localizedDescription)
            }
          
            
        }
        task.resume()
    }
}
