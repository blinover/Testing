//
//  ImageExporterService.swift
//  Testing
//
//  Created by Danil Blinov on 02.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import UIKit
import QuartzCore

final class ImageExporterService {
	
	func image(from view: UIView) -> UIImage? {
		let imagee = image(with: view)
		return pngImage(imagee)
	}
	
	private func image(with view: UIView) -> UIImage {
		let renderer = UIGraphicsImageRenderer(size: view.bounds.size)
		let image = renderer.image { ctx in
			view.drawHierarchy(in: view.bounds, afterScreenUpdates: true)
		}
		return image
	}
	
	private func pngImage(_ image: UIImage) -> UIImage? {
		guard let data = image.pngData() else { return nil }
		return UIImage(data: data)
	}
	
}
