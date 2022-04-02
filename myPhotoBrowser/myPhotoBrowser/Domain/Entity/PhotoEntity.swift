//
//  PhotoEntity.swift
//  myPhotoBrowser
//
//  Created by 김희수 on 2022/03/30.
//

import Foundation

struct PhotoExif {
    var maker: String?
    var focalLength: String?
    var model: String?
    var iso: Int?
    var shutterSpeed: String?
    var dimension: String?
    var aperture: String?
    var published: String?
}

struct PhotoLocation {
    var location: String?
    var latitude: Double?
    var longitude: Double?
    var description: String?
}

struct PhotoDetail {
    var id: String?
    var artist: String?
    var smlImgUrl: String?
    var regImgUrl: String?
    var location: PhotoLocation?
    var exif: PhotoExif?
}

struct PhotoInfo {
    var id: String?
    var artist: String?
    var smlImgUrl: String?
    var width: Int?
    var height: Int?
}
