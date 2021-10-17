// ViewController.swift
// Copyright © RoadMap. All rights reserved.

import UIKit
/// Контроллер-
class ViewController: UIViewController {
    // MARK: View elements

    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let headerImageView = UIImageView()
    private let descriptionLabel = UILabel()
    private let scrollView = UIScrollView()

    // MARK: public properties

    var filmTitle = String()
    var filmDescription = String()
    var path = String()

    // MARK: private properties

    private var imageURL = "https://image.tmdb.org/t/p/w500"

    // MARK: ViewController's methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubviews()
        title = "Overview"
    }

    // MARK: Private methods

    private func setupSubviews() {
        view.backgroundColor = .systemBackground

        setupScrollView()
        setupTitleLabel()
        setupHeaderImageView()
        setupDescriptionLabel()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(headerImageView)
        scrollView.addSubview(descriptionLabel)
        scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }

    private func setupTitleLabel() {
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.numberOfLines = 2
        titleLabel.text = filmTitle
        titleLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerImageView.topAnchor, constant: -10).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }

    private func setupHeaderImageView() {
        headerImageView.translatesAutoresizingMaskIntoConstraints = false
        headerImageView.image = getImageFromPath(url: imageURL, path: path)
        headerImageView.clipsToBounds = true
        headerImageView.layer.cornerRadius = 8
        headerImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10).isActive = true
        headerImageView.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.4).isActive = true
        headerImageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        headerImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }

    private func getImageFromPath(url: String, path: String) -> UIImage {
        guard let imageURL = URL(string: "\(url)\(path)"),
              let imageData = try? Data(contentsOf: imageURL) else { return UIImage() }

        guard let image = (UIImage(data: imageData) != nil) ? UIImage(data: imageData) : UIImage()
        else { return UIImage() }

        return image
    }

    private func setupDescriptionLabel() {
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 15
        descriptionLabel.text = filmDescription
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: headerImageView.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 10).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10).isActive = true
    }
}
