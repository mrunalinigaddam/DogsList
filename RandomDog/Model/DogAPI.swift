//
//  DogAPI.swift
//  RandomDog
//
//  Created by Mrunalini Gaddam on 10/4/20.
//  Copyright © 2020 Udacity. All rights reserved.
//

import Foundation
import UIKit


class DogAPI{
    enum Endpoint {
       case randomImageFromAllDogsCollection
        case randomImageForBreed(String)
        case listAllBreeds
        
        var url: URL {
            return URL(string:self.stringValue)!
        }
        var stringValue: String{
            switch self{
            case .randomImageFromAllDogsCollection:
                return "https://dog.ceo/api/breed/images/random"
            case .randomImageForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            default:
                return "https://dog.ceo/api/breed/images/random"
            }
        }
    }
    class func requestAllBreedsList(completionHandler:@escaping ([String], Error?) -> Void){
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) {
            (data, response, error) in
            guard let data = data else {
               completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try!
                decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})
            completionHandler(breeds, nil)
            
        }
        task.resume()
    }
    class func requestRandomImage(breed: String, completionHandler:@escaping (DogImage?,Error?) -> Void){
        let rondomImageDogAPI = (DogAPI.Endpoint.randomImageForBreed(breed).url)
        let task = URLSession.shared.dataTask(with: rondomImageDogAPI){ (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try!
                decoder.decode(DogImage.self, from: data)
            print(imageData)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    class func requestImageFile(url:URL,completionHandler: @escaping (UIImage?, Error?) -> Void){
        
        let task = URLSession.shared.dataTask(with: url,completionHandler: {(data,response,error) in
            guard let data = data else {
                completionHandler(nil,error)
                return
                
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage,nil)
             })
        task.resume()
    }
}
