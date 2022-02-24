//
//  Bundle+AllXibFilesNames.swift
//  AnyUse
//
//  Created by Алексей on 22..022022.
//

import Foundation

extension Bundle {

    /// Массив из имен всех `xib`-файлов в приложении.
    static let allXibsFilesNames: [String] = {
        (Bundle.main.urls(forResourcesWithExtension: "nib", subdirectory: nil) ?? []).map {
            $0.deletingPathExtension().lastPathComponent
        }
    }()
}

