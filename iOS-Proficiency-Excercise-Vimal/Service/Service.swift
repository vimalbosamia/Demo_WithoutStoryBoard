//
//  Service.swift
//  iOS-Proficiency-Excercise-Vimal
//
//  Created by Vimal on 24/06/20.
//  Copyright © 2020 Vimal. All rights reserved.
//

import Foundation

final class Service {
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    private let baseURLString =  "https://dl.dropboxusercontent.com/"
    private let facts = "s/2iodh4vg0eortkl/facts.json"
    
    static public let shared: Service = Service()
    func fetchDataForFacts( completionHandler: @escaping (ItemData?) -> Void) {
        let urlString = baseURLString + facts
        guard let url = URL(string: urlString) else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: urlRequest.url!) { data, response, error in
            var dataReceived:ItemData?
            
            defer {
                self.dataTask = nil
                completionHandler(dataReceived)
            }
            
            if let error = error {
                print("[API] Request failed with error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data, let response = response as? HTTPURLResponse else {
                print("[API] equest returned an invalid response")
                return
            }
            
            guard response.statusCode == 200 else {
                print("[API] Request returned an unsupported status code: \(response.statusCode)")
                return
            }
            
            let responseStrInISOLatin = String(data: data, encoding: String.Encoding.isoLatin1)
            guard let modifiedDataInUTF8Format = responseStrInISOLatin?.data(using: String.Encoding.utf8) else {
                print("could not convert data to UTF-8 format")
                return
            }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(ItemData.self, from: modifiedDataInUTF8Format)
                dataReceived = model
            } catch {
                print("[API] Decoding failed with error: \(error)")
            }
        }
        dataTask?.resume()
    }
    
    func obtainImageDataWithPath(imagePath: String, completionHandler: @escaping (Data?) -> Void) {
            let url: URL! = URL(string: imagePath)
        let task = defaultSession.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completionHandler(data)
        }
        task.resume()
    }
}
