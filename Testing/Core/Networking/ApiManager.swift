//
//  ApiManager.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Moya
import Alamofire
import RxSwift
import Foundation

final class ApiManager {
	private let manager: Session
	private let serverURL: String
	private let provider: MultiMoyaProvider

	init(configuration: Enviorment) {
		self.serverURL = configuration.serverURL
		
		
		let configuration = URLSessionConfiguration.default
		configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
		configuration.timeoutIntervalForResource = 100
		configuration.timeoutIntervalForRequest = 100
		configuration.urlCredentialStorage = nil
		configuration.shouldUseExtendedBackgroundIdleMode = true
		manager = Session(configuration: configuration)
		
		let loggerPlugin = NetworkLoggerPlugin(configuration: .init(logOptions: .verbose))
		
		let authPlugin = AuthtorizationPlugin(tokenClosure: { "" })
		provider = MultiMoyaProvider(callbackQueue: DispatchQueue.main, session: manager, plugins: [authPlugin, loggerPlugin])
	}
	
	func request(_ target: TargetType) -> Observable<Result<Dict, APIError>> {
		return provider.request(MultiTarget(target))
	}
}
