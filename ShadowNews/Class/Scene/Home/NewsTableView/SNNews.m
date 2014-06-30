//
//  SNNews.m
//  ShadowNews
//
//  Created by lanou3g on 14-6-28.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import "SNNews.h"

@implementation SNNews
- (void)dealloc
{
    RELEASE_SAFELY(_title);
    RELEASE_SAFELY(_detail);
    RELEASE_SAFELY(_imageUrlString);
    [super dealloc];

}
- (instancetype)initWithDictionary:(NSDictionary *)dic
{
    self = [super init];
    if (self) {
        self.title = [dic objectForKey:@"title"];
        self.detail = [dic objectForKey:@"detail"];
        self.imageUrlString = [dic objectForKey:@"imageUrlString"];
    }
    return self;
}


@end
