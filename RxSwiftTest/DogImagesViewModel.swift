//
//  DogImagesViewModel.swift
//  RxSwiftTest
//
//  Created by Ivan Teo on 28/9/23.
//

import UIKit
import RxSwift


class DogImagesViewModel {
  
  private let dogService: DogService
  
  init(dogService: DogService) {
    self.dogService = dogService
  }
  
  func getDogImagesObservable() -> Observable<[UIImage]> {
    dogService
      .getDogImage()
  }
}
