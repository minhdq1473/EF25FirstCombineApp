//
//  ProfileManager.swift
//  EF25NavigationApp
//
//  Created by iKame Elite Fresher 2025 on 16/7/25.
//

import Foundation
import Combine

class ProfileManager {
    static let shared: ProfileManager = .init()
    
    private var subscriptions: Set<AnyCancellable> = .init()
    private var profiles: [Profile] = []
    
    let onActionPassthroughSubject: PassthroughSubject<ProfileActionType, Never> = .init()
    let onUpdateAction: CurrentValueSubject<UpdateAction, Never>
    
    private init() {
        onUpdateAction = .init(.initial(profiles: profiles))
        observer()
    }
    
    private func observer() {
        onActionPassthroughSubject
            .receive(on: DispatchQueue.global())
            .sink { [weak self] action in
                     self?.onAction(action)
            }
            .store(in: &subscriptions)
    }
    
    private func onAction(_ action: ProfileActionType) {
        switch action {
        case .add(let profile):
            onAdd(profile: profile)
        case .delete(let id):
            onDelete(for: id)
        case .edit(id: let id, firstName: let firstName, lastName: let lastName, gender: let gender, weight: let weight, height: let height):
            onEdit(id: id, firstName: firstName, lastName: lastName, gender: gender, weight: weight, height: height)
        }
    }
    
    private func onAdd(profile: Profile) {
        profiles.append(profile)
        onUpdateAction.send(.add(profile: profile))
    }
    
    private func onDelete(for id: String) {
        guard let index = profiles.firstIndex(where: { $0.id == id}) else { return }
        profiles.remove(at: index)
        onUpdateAction.send(.delete(index: index))
    }
    
    private func onEdit(id: String, firstName: String, lastName: String, gender: String, weight: Double, height: Double) {
        guard let index = profiles.firstIndex(where: { $0.id == id}) else { return }
        
        let updatedProfile = Profile(id: id, firstName: firstName, lastName: lastName, gender: gender, weight: weight, height: height)
        profiles[index] = updatedProfile
        onUpdateAction.send(.update(index: index, profile: updatedProfile))
    }
}





