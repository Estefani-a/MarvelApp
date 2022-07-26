//
//  APIClient.swift
//  MarvelApp
//
//  Created by Estefania Sassone on 20/07/2022.
//

import Foundation
import UIKit

class APIClient: UICollectionViewController{
    
    static var shared = APIClient()
    
        let privateKey = "2d32b1fec9342953068c3532918e032e01aa37ec" //Esto deberia moverse a var de entorno porque es para traer info de la API
        let publicApiKey = "7255339681554811baaac79dedd8be98"
        //let ts = "557600638"
        //let hashBase = ts + privateKey + publicApiKey
        //let hash = MD5Generator.md5(for: hashBase)!
        //let hash = 2b934381911e31a3c5cc8b527ae17c81f
        
        
        let urlString = "https://gateway.marvel.com:443/v1/public/characters?ts=1&apikey=7255339681554811baaac79dedd8be98&hash=b934381911e31a3c5cc8b527ae17c81f"
        
        //metodo generico base
        func fetchData<T: Codable>(request: URLRequest, onSuccess: @escaping (T) -> Void, onError: @escaping (APIError) -> Void){
            let session = URLSession(configuration: .default)
            session.dataTask(with: request){ data, response, error in
                if let data = data, let response = response {
                    do {
                        print(response)
                        print(error ?? "")
                            let decoder = JSONDecoder()
                            let result = try decoder.decode(T.self, from: data)
                            onSuccess(result)
                        } catch {
                            onError(.serverError)
                        }
                    }
                }.resume()
        }
        

    //llamado de datos a la API
    func getCharacters(onSuccess: @escaping (CharacterResponse) -> Void, onError: @escaping (APIError) -> Void){
        guard let url = URL(string: "https://gateway.marvel.com:443/v1/public/characters?ts=1&apikey=7255339681554811baaac79dedd8be98&hash=b934381911e31a3c5cc8b527ae17c81f") else{
            onError(.serverError)
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        fetchData(request: request, onSuccess: onSuccess, onError: onError)
    }
    
                
}


