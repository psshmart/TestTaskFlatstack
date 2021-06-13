//
//  ImageService.swift
//  FlatstackIosTestApp
//
//  Created by Svetlana Safonova on 13.06.2021.
//

import UIKit

class ImageService {
    
    func getCountryImages(urlStrings: [String], completion: @escaping (Result<[UIImage], Error>) -> Void) {
        var images: [UIImage] = []
        for string in urlStrings {
            if let url = URL(string: string) {
                let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
                    if let error = error {
                        print(response.debugDescription)
                        completion(.failure(error))
                    }
                    if let data = data {
                        if let image = UIImage(data: data) {
                            images.append(image)
                            completion(.success(images))
                        }
                    }
                }
                dataTask.resume()
            }
        }
        
        
    }
    
    func getCountryFlag(urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        var flagImage = UIImage()
        if let url = URL(string: urlString) {
            let dataTask = URLSession.shared.dataTask(with: url) { data, response, error  in
                if let error = error {
                    print(response.debugDescription)
                    completion(.failure(error))
                }
                if let data = data {
                    DispatchQueue.main.async {
                        if let image = UIImage(data: data) {
                            flagImage = image
                            completion(.success(flagImage))
                        } else {
                            if let error = error {
                                completion(.failure(error))
                            }
                        }
                    }
                }
            }
            dataTask.resume()
        }
    }
}
