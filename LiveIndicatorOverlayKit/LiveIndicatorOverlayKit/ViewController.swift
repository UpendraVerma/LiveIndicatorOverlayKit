//
//  ViewController.swift
//  LiveIndicatorOverlayKit


import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private let profileImages = [
            UIImage(named: "Profile1"),
            UIImage(named: "Profile2"),
            UIImage(named: "Profile3"),
            UIImage(named: "Profile4"),
            UIImage(named: "Profile5"),
            UIImage(named: "Profile6"),
            UIImage(named: "Profile7"),
            UIImage(named: "Profile8"),
            UIImage(named: "Profile9"),
            UIImage(named: "Profile10")
        ]
        
        private let collectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            layout.itemSize = CGSize(width: 100, height: 100)
            layout.scrollDirection = .vertical
            layout.minimumLineSpacing = 20
            layout.minimumInteritemSpacing = 20
            
            let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            collectionView.translatesAutoresizingMaskIntoConstraints = false
            collectionView.register(ProfileCell.self, forCellWithReuseIdentifier: ProfileCell.identifier)
            return collectionView
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            view.backgroundColor = .white
            setupCollectionView()
        }
        
        private func setupCollectionView() {
            view.addSubview(collectionView)
            collectionView.delegate = self
            collectionView.dataSource = self
            
            NSLayoutConstraint.activate([
                collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
            ])
        }
        
        // MARK: - UICollectionViewDelegate & UICollectionViewDataSource
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return profileImages.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileCell.identifier, for: indexPath) as! ProfileCell
            cell.profileImageView.image = profileImages[indexPath.item]
            cell.applyOverlay(index: indexPath.row)
            return cell
        }


}

//------------------------------------------------------
class ProfileCell: UICollectionViewCell {
    static let identifier = "ProfileCell"
    
    let profileImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupProfileImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupProfileImageView() {
        contentView.addSubview(profileImageView)
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 35
        profileImageView.clipsToBounds = true
    }
    
    // Apply a random live overlay or no overlay for demo purposes
    func applyOverlay(index: Int = 0) {
        switch index {
        case 0:
            profileImageView.applyLiveOverlay(liveCornerRadius: 8,
                                              liveText: "",
                                              liveBackgroundColor: .blue,
                                              labelHeight: 15,
                                              labelWidth: 15,
                                              padding: 5,
                                              liveLabelPosition: .custom(x: 30, y: 20))
        case 1:
            profileImageView.applyLiveOverlay(borderWidth: 2,
                                              borderColor: .red,
                                              borderCornerRadius: profileImageView.layer.cornerRadius,
                                              liveCornerRadius: 5,
                                              liveText: "LIVE",
                                              liveTextColor: .white,
                                              liveBackgroundColor: .red,
                                              font: .boldSystemFont(ofSize: 12),
                                              labelHeight: 20,
                                              labelWidth: 50,
                                              padding: 5,
                                              liveLabelPosition: .bottom)
        case 2:
            profileImageView.applyLiveOverlay(borderWidth: 2,
                                              borderColor: .red,
                                              borderCornerRadius: profileImageView.layer.cornerRadius,
                                              liveCornerRadius: 5,
                                              liveText: "LIVE",
                                              liveTextColor: .white,
                                              liveBackgroundColor: .red,
                                              font: .boldSystemFont(ofSize: 12),
                                              labelHeight: 20,
                                              labelWidth: 50,
                                              padding: 5,
                                              liveLabelPosition: .left)
        case 3:
            profileImageView.applyLiveOverlay(borderWidth: 2,
                                              borderColor: .red,
                                              borderCornerRadius: profileImageView.layer.cornerRadius,
                                              liveCornerRadius: 5,
                                              liveText: "LIVE",
                                              liveTextColor: .white,
                                              liveBackgroundColor: .red,
                                              font: .boldSystemFont(ofSize: 12),
                                              labelHeight: 20,
                                              labelWidth: 50,
                                              padding: 5,
                                              liveLabelPosition: .bottom)
            
        case 4:
            profileImageView.applyLiveOverlay(borderWidth: 2,
                                              borderColor: .red,
                                              borderCornerRadius: profileImageView.layer.cornerRadius,
                                              liveCornerRadius: 5,
                                              liveText: "LIVE",
                                              liveTextColor: .white,
                                              liveBackgroundColor: .red,
                                              font: .boldSystemFont(ofSize: 12),
                                              labelHeight: 20,
                                              labelWidth: 50,
                                              padding: 5,
                                              liveLabelPosition: .right)
        case 5:
            profileImageView.removeLiveOverlay()
            
        case 6:
            profileImageView.applyLiveOverlay(borderWidth: 2,
                                              borderColor: .red,
                                              borderCornerRadius: profileImageView.layer.cornerRadius,
                                              liveCornerRadius: 5,
                                              liveText: "LIVE",
                                              liveTextColor: .white,
                                              liveBackgroundColor: .red,
                                              font: .boldSystemFont(ofSize: 12),
                                              labelHeight: 20,
                                              labelWidth: 50,
                                              padding: 5,
                                              liveLabelPosition: .custom(x: 30, y: 20))
            
        case 7:
            profileImageView.applyLiveOverlay(borderWidth: 2,
                                              borderColor: .blue,
                                              borderCornerRadius: profileImageView.layer.cornerRadius,
                                              liveCornerRadius: 10,
                                              liveText: "",
                                              liveBackgroundColor: .green,
                                              font: .boldSystemFont(ofSize: 12),
                                              labelHeight: 20,
                                              labelWidth: 20,
                                              padding: 5,
                                              liveLabelPosition: .bottom)
            
        default:
            break
        }

    }
    
}
