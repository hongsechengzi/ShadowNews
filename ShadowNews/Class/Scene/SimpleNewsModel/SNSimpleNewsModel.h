//
//  SNSimpleNewsModel.h
//  ShadowNews
//
//  Created by lanou3g on 14-7-5.
//  Copyright (c) 2014年 Shadow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SNSimpleNewsModel : NSObject

@property (copy, nonatomic, readonly) NSString * imgSrc; //!< 主题图片网址.
@property (copy, nonatomic, readonly) NSString * title; //!< 新闻标题.
@property (copy, nonatomic, readonly) NSString * publishTime; //!< 发表时间.
@property (assign, nonatomic, readonly) NSUInteger replyCount; //!< 跟帖数.
@property (copy, nonatomic, readonly) NSString * docId; //!< 文章唯一标识.

/**
 *  便利构造器.
 *
 *  @param imgSrc     主题图片网址.
 *  @param title      新闻标题.
 *  @param pulishTime 发表时间.
 *  @param replyCount 跟帖数.
 *  @param docId      文章唯一标识.
 *
 *  @return 实例对象.
 */
+ (instancetype) simpleNewsWithImgSrc: (NSString *) imgSrc
                               title: (NSString *) title
                         publishTime: (NSString *) pulishTime
                          replyCount: (NSUInteger) replyCount
                               docId: (NSString *) docId;

/**
 *  便利初始化.
 *
 *  @param imgSrc     主题图片网址.
 *  @param title      新闻标题.
 *  @param pulishTime 发表时间.
 *  @param replyCount 跟帖数.
 *  @param docId      文章唯一标识.
 *
 *  @return 实例对象.
 */
- (instancetype) initWithImgSrc: (NSString *) imgSrc
                          title: (NSString *) title
                    publishTime: (NSString *) pulishTime
                     replyCount: (NSUInteger) replyCount
                          docId: (NSString *) docId;


@end
