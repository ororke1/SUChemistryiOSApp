//
//  ChemCell.swift
//  SUChemistryiOSApp
//
//  Created by Daniel Bradley on 11/28/21.
//

import Foundation

import UIKit

class ChemCell: UITableViewCell {
    let imageIV = UIImageView()
    var safeArea: UILayoutGuide!
    let nameLabel = UILabel()
    let resLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    func setupView() {
     safeArea = layoutMarginsGuide
     setupImageView()
     setupNameLabel()
     setupResLabel()
    }

    func setupImageView(){
        addSubview(imageIV)
        imageIV.translatesAutoresizingMaskIntoConstraints = false
        imageIV.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        imageIV.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageIV.widthAnchor.constraint(equalToConstant: 10).isActive = true
        imageIV.heightAnchor.constraint(equalToConstant: 10).isActive = true
        imageIV.backgroundColor = .blue
      
    }
    
    func setupNameLabel(){
        addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: imageIV.trailingAnchor, constant: 5).isActive = true
        nameLabel.topAnchor.constraint(equalTo: topAnchor,constant: 5).isActive = true
    }
    
    func setupResLabel(){
        addSubview(resLabel)
        resLabel.translatesAutoresizingMaskIntoConstraints = false
        resLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor).isActive = true
        resLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 5).isActive = true
    }
    
    }

