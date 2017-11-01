/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseConversationModel.h"

//#import <Hyphenate/EMConversation.h>
#import <HyphenateLite_CN/EMConversation.h>
@implementation EaseConversationModel

- (instancetype)initWithConversation:(EMConversation *)conversation
{
    self = [super init];
    if (self) {
        _conversation = conversation;
        _title = _conversation.conversationId;
        if (conversation.type == EMConversationTypeChat) {
            _avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/user"];
        }
        else{
            _avatarImage = [UIImage imageNamed:@"EaseUIResource.bundle/group"];
        }
    }
    
    return self;
}
- (BOOL)isTop {
    return [self.conversation.ext[@"isTop"] boolValue];
}

- (void)setIsTop:(BOOL)isTop {
    NSMutableDictionary *dic = [self.conversation.ext mutableCopy];
    if (!dic) {
        dic = [NSMutableDictionary dictionary];
    }
    dic[@"isTop"] = isTop ? @YES : @NO;
    self.conversation.ext = dic;
}
@end
