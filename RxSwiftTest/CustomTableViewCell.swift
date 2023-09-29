//
//  CustomTableViewCell.swift
//  RxSwiftTest
//
//  Created by Ivan Teo on 28/9/23.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
  
  static let reuseIdentifier = "CustomTableViewCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private lazy var imgView: UIImageView = {
    let imgView = UIImageView()
    imgView.contentMode = .scaleAspectFill
    imgView.translatesAutoresizingMaskIntoConstraints = false
    return imgView
  }()
  
  func configureCell(withImage image: UIImage) {
    addSubview(imgView)
    imgView.image = image
    imgView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    imgView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    imgView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    imgView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
  }
}

