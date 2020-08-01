//
//  TargetType+Extensions.swift
//  Testing
//
//  Created by Danil Blinov on 02.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Foundation
import Moya

extension TargetType {
	
	var asMultiTarget: MultiTarget {
		return MultiTarget(self)
	}
	
}
