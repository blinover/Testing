//
//  Reachablility.swift
//  Testing
//
//  Created by Danil Blinov on 01.08.2020.
//  Copyright © 2020 Danil Blinov. All rights reserved.
//

import Alamofire
import RxCocoa
import RxSwift

final class Reachability {
	typealias Status = Alamofire.NetworkReachabilityManager.NetworkReachabilityStatus
	
	static let shared = Reachability()
	private let manager = NetworkReachabilityManager(host: "apple.com")
	private(set) var status = BehaviorRelay<Status>(value: .notReachable)
	
	private init() {
		manager?.startListening(onUpdatePerforming: { self.status.accept($0) })
	}
}

