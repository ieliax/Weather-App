//
//  PersistencyManager.m
//  Mytest
//
//  Created by Mac HD on 11/26/18.
//  Copyright © 2018 Mac HD. All rights reserved.
//

#import "PersistencyManager.h"
#import "../Model/Albums.h"
#import "../Model/WCityListRealm.h"
#import <Realm.h>


@interface PersistencyManager ()
@property(nonatomic,strong)NSString *cache;
@end

@implementation PersistencyManager


-(id)init{
    if (self = [super init]) {
       
    }
    return self;
}

-(id)initWithUserData:(NSArray *)list{
    if (self = [super init]) {
        if (list != nil) {
            self.citys = [[NSMutableArray alloc] init];
            self.searchedcitys = [[NSMutableArray alloc] init];
            
            for (int i = 0; i<list.count; i++) {
                // NSLog(@"%@ nombre de count",[[self listOfSearchCitys] objectAtIndex:i]);
                WCityListRealm *wx = [list objectAtIndex:i];
                [self.searchedcitys addObject:wx.cityName];
                
            }
        }
    }
    return self;
}

-(id)initWithListOfCity:(NSArray *)list{
    
    if (self = [super init]) {
        
       // if (list != nil) {
            self.citys = [[NSMutableArray alloc] init];
            self.searchedcitys = [[NSMutableArray alloc] init];
            
            for (int a = 0; a<list.count; a++) {
               // for (int b = 0; b<[[list objectAtIndex:b] count]; b++) {
                    // NSLog(@"%@ nombre de count",[[self listOfSearchCitys] objectAtIndex:i]);
                    
                    WCityListRealm *wx = [list objectAtIndex:a];
                    [self.searchedcitys addObject:wx.cityName];
              //  }
            }
       // }
        
       
       // dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
         self.realmObject = [RLMRealm defaultRealm];
        
        self.cache = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        NSLog(@"%@ cache",self.cache);
       
            
//        Albums *albums1 = [[Albums alloc] initWithAlbums:@"Best of May"
//                                               andArtist:@"David Bowei"
//                                               andGender:@"Pop"];
//        
//        Albums *albums2 = [[Albums alloc] initWithAlbums:@"Best Zato"
//                                               andArtist:@"David Bowei"
//                                               andGender:@"Pop"];
//        
//        Albums *albums3 = [[Albums alloc] initWithAlbums:@"Best of Elphelt"
//                                               andArtist:@"David Bowei"
//                                               andGender:@"Pop"];
//        
//        Albums *albums4 = [[Albums alloc] initWithAlbums:@"Best of Faust"
//                                               andArtist:@"David Bowei"
//                                               andGender:@"Pop"];
//        
//        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithObjectsAndKeys:albums1,@"artista", nil];
//       
//        self.albums = [NSMutableArray arrayWithObjects:albums1,albums2,albums3,albums4,nil];
    }
    return self;
 
}

-(void)saveImage:(UIImage *)image withNameOfFile:(NSString *)filename{
    NSString *file = [filename stringByAppendingString:@".jpg"];
    NSLog(@"%@",file);
    NSString *url = [self.cache stringByAppendingPathComponent:file];
    NSData *data = UIImagePNGRepresentation(image);
    if (!data) {
        return;
    }
    [data writeToFile:url atomically:YES];
}

-(UIImage *)getImage:(NSString *)filename{
    NSString *file = [filename stringByAppendingString:@".jpg"];
    NSString *url = [self.cache stringByAppendingPathComponent:file];
    NSData *data = [NSData dataWithContentsOfFile:url];
    if (!data) {
        return nil;
    }
    return [UIImage imageWithData:data];
}

-(NSArray *)getAlbums{
    return self.albums;
}



//-(void)addAlbum:(Albums *)album AtIndex:(int)index{
//    if ([self.albums count] >= index) {
//        [self.albums insertObject:album atIndex:index];
//    }
//}

#pragma mark CITY

-(void)addCity:(NSString *)city AtIndex:(int)index{
    if ([self.citys count] >= index) {
        [self.citys insertObject:city atIndex:index];
    }
}

-(void)addCityto:(NSString *)city AtIndex:(int)index{
    if ([self.searchedcitys count] >= index) {
        [self.searchedcitys insertObject:city atIndex:index];
    }
}
-(NSArray *)getCitys{
    return self.citys;
}
-(NSArray *)getSearchCity{
    return self.searchedcitys;
}

//-(void)addCity:(WCityModel *)city AtIndex:(int)index{
//    if ([self.citys count] >= index) {
//        [self.citys insertObject:city atIndex:index];
//
//    }
// //   [self.citys addObject:city];
//}

//-(void)Query(){
//
//}

-(void)saveData:(__unsafe_unretained RLMObject *const)object{
//    [self.realmObject transactionWithBlock:^{
//         [self.realmObject addObject:object];
//        //NSLog(@"%@ CLASSSS",[[object class] allObjects]);
//    }];
}

-(void)addAlbum:(Albums *)album AtIndex:(int)index{
    if ([self.albums count] >= index) {
        [self.albums insertObject:album atIndex:index];
    }
}

@end
