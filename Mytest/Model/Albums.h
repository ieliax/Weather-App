//
//  Albums.h
//  Mytest
//
//  Created by Mac HD on 11/27/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Albums : NSObject
@property(nonatomic,strong)NSString *albumName;
@property(nonatomic,strong)NSString *artistName;
@property(nonatomic,strong)NSString *gender;

-(id)initWithAlbums:(NSString *)name andArtist:(NSString *)artist andGender:(NSString *)gender;
@end

NS_ASSUME_NONNULL_END
