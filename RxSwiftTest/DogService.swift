//
//  DogService.swift
//  RxSwiftTest
//
//  Created by Ivan Teo on 28/9/23.
//

import Foundation
import RxSwift

class DogService {
  
  static let shared = DogService()
  
  private init() {}
  
  private func getDogImageUrl() -> Observable<[URL]> {
    let request = URLRequest(url: URL(string: "https://dog.ceo/api/breed/hound/images")!)
    
    return URLSession.shared.rx
      .response(request: request)
      .map { (response, data) -> [URL] in
        guard response.statusCode == 200 else {
          throw URLError(.badServerResponse)
        }
        let imageUrls = try JSONDecoder().decode(DogImageUrlModel.self, from: data)
        return imageUrls.message.compactMap { URL(string: $0) }
      }
      .asObservable()
  }
  
  private func getImage(fromUrl url: URL) -> Observable<UIImage> {
    return URLSession.shared.rx.data(request: URLRequest(url: url))
       .map { data in
           guard let image = UIImage(data: data) else {
             throw URLError(.cannotDecodeRawData)
           }
           return image
       }
  }
  
  
  func getDogImage() -> Observable<[UIImage]> {
    getDogImageUrl()
      .flatMapLatest { Observable.from($0) } // Convert into an Observable sequence of URLs, where each event emitted is a url
      .flatMap(getImage(fromUrl:))
      .toArray() // Collects all the emitted events and converts them into an array
      .asObservable()
  }
}
