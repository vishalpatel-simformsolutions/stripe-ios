//
//  InstitutionDataSource.swift
//  StripeFinancialConnections
//
//  Created by Vardges Avetisyan on 6/8/22.
//

import Foundation
@_spi(STP) import StripeCore

protocol InstitutionDataSource: AnyObject {
    
    var manifest: FinancialConnectionsSessionManifest { get }
    
    func fetchInstitutions(searchQuery: String) -> Future<[FinancialConnectionsInstitution]>
    func fetchFeaturedInstitutions() -> Future<[FinancialConnectionsInstitution]>
}

class InstitutionAPIDataSource: InstitutionDataSource {
    
    // MARK: - Properties
    
    let manifest: FinancialConnectionsSessionManifest
    private let apiClient: FinancialConnectionsAPIClient
    private let clientSecret: String
    
    // MARK: - Init
    
    init(
        manifest: FinancialConnectionsSessionManifest,
        apiClient: FinancialConnectionsAPIClient,
        clientSecret: String
    ) {
        self.manifest = manifest
        self.apiClient = apiClient
        self.clientSecret = clientSecret
    }
    
    // MARK: - InstitutionDataSource
    
    func fetchInstitutions(searchQuery: String) -> Future<[FinancialConnectionsInstitution]> {
        return apiClient.fetchInstitutions(
            clientSecret: clientSecret,
            query: searchQuery
        )
        .chained { list in
            return Promise(value: list.data)
        }
    }
    
    func fetchFeaturedInstitutions() -> Future<[FinancialConnectionsInstitution]> {
        return apiClient.fetchFeaturedInstitutions(clientSecret: clientSecret)
            .chained { list in
                return Promise(value: list.data)
            }
    }
}
