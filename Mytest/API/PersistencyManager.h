//
//  PersistencyManager.h
//  Mytest
//
//  Created by Mac HD on 11/26/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>
#import <UIKit/UIKit.h>

@class Albums;
@class WCityModel;
@class WCityRealmModel;
NS_ASSUME_NONNULL_BEGIN

@interface PersistencyManager : NSObject
@property(nonatomic,strong)NSMutableArray* albums;
@property(nonatomic,strong)NSMutableArray* citys;
@property(nonatomic,strong)NSMutableArray* searchedcitys;
@property(nonatomic,strong)RLMRealm *realmObject;

-(id)init;
-(id)initWithListOfCity:(NSArray *)list;
-(id)initWithUserData:(NSArray *)list;
-(NSArray *)getAlbums;
-(NSArray *)getCitys;
-(NSArray *)getSearchCity;
-(void)saveImage:(UIImage *)image withNameOfFile:(NSString *)filename;
-(UIImage *)getImage:(NSString *)filename;
-(void)addAlbum:(Albums *)album AtIndex:(int)index;
-(void)addCity:(WCityModel *)city AtIndex:(int)index;
-(void)addCityto:(NSString *)city AtIndex:(int)index;
-(void)saveData:(WCityRealmModel *)object;



@end

NS_ASSUME_NONNULL_END
