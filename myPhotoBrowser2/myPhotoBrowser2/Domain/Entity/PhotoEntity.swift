//
//  PhotoEntity.swift
//  myPhotoBrowser2
//
//  Created by 김희수 on 2022/04/29.
//

struct PhotoExif {
    let maker: String
    let focalLength: String
    let model: String
    let iso: Int
    let shutterSpeed: String
    let dimension: String
    let aperture: String
    let published: String
}

struct PhotoLocation {
    let location: String
    let latitude: Double
    let longitude: Double
    let description: String
}

struct PhotoDetail {
    let id: String
    let artist: String
    let smlImgUrl: String
    let regImgUrl: String
    let location: PhotoLocation
    let exif: PhotoExif
}

struct PhotoInfo {
    let id: String
    let artist: String
    let smlImgUrl: String
    let width: Int
    let height: Int
}
