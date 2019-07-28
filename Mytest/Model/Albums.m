//
//  Albums.m
//  Mytest
//
//  Created by Mac HD on 11/27/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import "Albums.h"

@implementation Albums
@synthesize albumName = _albumName;
@synthesize artistName = _artistName;
@synthesize gender = _gender;

-(id)init{
    if (self = [super init]) {

    }
    return self;
}

-(id)initWithAlbums:(NSString *)name andArtist:(NSString *)artist andGender:(NSString *)gender{
    if (self = [super init]) {
        _albumName = name;
        _artistName = artist;
        _gender = gender;
    }
    return self;
}

@end
