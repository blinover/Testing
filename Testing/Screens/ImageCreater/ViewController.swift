//
//  ViewController.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {
	@IBOutlet private weak var heroContainerView: UIView!
	@IBOutlet private weak var nameLabel: UILabel!
	@IBOutlet private weak var hairColorLabel: UILabel!
	
	private let heroService = HeroService()
	private let imageService = ImageExporterService()
	private let disposeBag = DisposeBag()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		loadSkywalker()
	}
	
	private func loadSkywalker() {
		heroService.getHero(by: 1).subscribe(onNext: { [weak self] (result) in
			switch result {
				case .success(let hero):
					self?.nameLabel.text = hero.name
					self?.hairColorLabel.text = hero.hairColor
				case .failure(let error):
					print(error.title)
			}
		}).disposed(by: disposeBag)
	}

	@IBAction func exportImageButtonPressed(_ sender: UIButton) {
		let heroView = ShareHeroView.loadFromNib()
		heroView.frame = CGRect(x: 0, y: 0, width: 300, height: 300)
	
		guard let image = imageService.image(from: heroView), let secondImage = imageService.image(from: heroContainerView) else { return }
		let activityController = UIActivityViewController(activityItems: [image, secondImage], applicationActivities: [])
		activityController.excludedActivityTypes = [.assignToContact, .markupAsPDF, .addToReadingList]
		present(activityController, animated: true, completion: nil)
	}
	
}

