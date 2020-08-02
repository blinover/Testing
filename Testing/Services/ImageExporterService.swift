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
	
	func image(with view: UIView) -> UIImage? {
		let rect = CGRect(origin:CGPoint(x: 0, y: 0), size: view.bounds.size)
		UIBezierPath(roundedRect: rect, cornerRadius: 8).addClip()
		view.draw(rect)
		
		UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, 0.0)
		defer { UIGraphicsEndImageContext() }
		if let context = UIGraphicsGetCurrentContext() {
			view.layer.render(in: context)
			let image = UIGraphicsGetImageFromCurrentImageContext()
			return image
		}
		return nil
	}
	
}
