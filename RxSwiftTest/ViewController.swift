//
//  ViewController.swift
//  RxSwiftTest
//
//  Created by Ivan Teo on 28/9/23.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

  let viewModel: DogImagesViewModel = DogImagesViewModel(
    dogService: DogService.shared
  )
  
  private lazy var tableView: UITableView = {
    let tv = UITableView(frame: .zero)
    tv.delegate = self
    tv.register(
      CustomTableViewCell.self,
      forCellReuseIdentifier: CustomTableViewCell.reuseIdentifier
    )
    return tv
  }()
  
  let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
    tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    
    setupObservations()
  }
  
  private func setupObservations() {
    viewModel.getDogImagesObservable()
      .bind(
        to: tableView.rx.items(
          cellIdentifier: CustomTableViewCell.reuseIdentifier,
          cellType: CustomTableViewCell.self
        )
      ) { row, image, cell in
        cell.configureCell(withImage: image)
      }
      .disposed(by: disposeBag)
  }
}

// MARK: UITableViewDelegate

extension ViewController: UITableViewDelegate {}
