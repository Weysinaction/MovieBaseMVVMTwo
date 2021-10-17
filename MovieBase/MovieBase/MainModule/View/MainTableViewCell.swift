// MainTableViewCell.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// MainTableViewCell-
final class MainTableViewCell: UITableViewCell {
    // MARK: View elements

    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let imageViewFilm = UIImageView()
    private let cellView = UIView()

    // MARK: FilmTableViewCell methods

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(cellView)
        cellView.addSubview(imageViewFilm)
        cellView.addSubview(titleLabel)
        cellView.addSubview(descriptionLabel)

        setupBackgroundView()
        setupImageView()
        setupTitleLabel()
        setupDescriptionLabel()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: private methods

    private func setupBackgroundView() {
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.layer.borderWidth = 1
        cellView.layer.borderColor = UIColor.darkGray.cgColor
        cellView.layer.cornerRadius = 8
        cellView.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        cellView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        cellView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        cellView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
    }

    private func setupImageView() {
        imageViewFilm.translatesAutoresizingMaskIntoConstraints = false
        imageViewFilm.layer.cornerRadius = 8
        imageViewFilm.topAnchor.constraint(equalTo: cellView.topAnchor).isActive = true
        imageViewFilm.bottomAnchor.constraint(equalTo: cellView.bottomAnchor).isActive = true
        imageViewFilm.leftAnchor.constraint(equalTo: cellView.leftAnchor).isActive = true
        imageViewFilm.widthAnchor.constraint(equalTo: cellView.widthAnchor, multiplier: 0.4).isActive = true
    }

    private func setupTitleLabel() {
        titleLabel.numberOfLines = 2
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: imageViewFilm.rightAnchor, constant: 8).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: cellView.topAnchor, constant: 8).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor).isActive = true
    }

    private func setupDescriptionLabel() {
        descriptionLabel.numberOfLines = 7
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leftAnchor.constraint(equalTo: imageViewFilm.rightAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: cellView.rightAnchor, constant: -10).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: cellView.bottomAnchor, constant: -10).isActive = true
    }
}
