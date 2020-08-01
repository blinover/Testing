//
//  AuthtorizationPlugin.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Foundation
import Moya

struct AuthtorizationPlugin: PluginType {
	let tokenClosure: () -> String?
	
	func prepare(_ request: URLRequest, target: TargetType) -> URLRequest {
		guard let token = tokenClosure() else { return request }
		
		var request = request
		request.addValue(token, forHTTPHeaderField: "Authorization")
		return request
	}
}
