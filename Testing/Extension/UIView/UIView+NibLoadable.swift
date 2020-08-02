//
//  UIView+NibLoadable.swift
//  Testing
//
//  Created by Danil Blinov on 02.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import UIKit

public protocol NibLoadable: AnyObject {
	static var nibName: String { get }
	static var defaultNibBundle: Bundle { get }
	
	static func nib(fromBundle nibBundle: Bundle) -> UINib
	static func loadFromNib(inBundle nibBundle: Bundle) -> Self
}

public extension NibLoadable where Self: UIView {
	static var nibName: String {
		return String(describing: self)
	}
	
	static var defaultNibBundle: Bundle {
		return Bundle.main
	}
	
	static func nib(fromBundle nibBundle: Bundle = Self.defaultNibBundle) -> UINib {
		return UINib(nibName: nibName, bundle: nibBundle)
	}
	
	static func loadFromNib(inBundle nibBundle: Bundle) -> Self {
		let view = nib(fromBundle: nibBundle)
			.instantiate(withOwner: self, options: nil).first as! Self // swiftlint:disable:this force_cast
		view.translatesAutoresizingMaskIntoConstraints = true
		return view
	}
	
	static func loadFromNib() -> Self {
		let nibBundle = Bundle(for: self)
		let view = loadFromNib(inBundle: nibBundle)
		return view
	}
}
