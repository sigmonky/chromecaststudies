//
//  VMNGCCModel.h
//  dynamicAddView
//
//  Created by Randall Weinstein on 5/25/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    DISCONNECTED,
    CONNECTED,
    SELECTED,
    LOADED,
    PAUSED,
    PLAYING,
    BUFFERING
} VMNGCCPlayStates;

@interface VMNGCCModel : NSObject

@property (nonatomic,assign) VMNGCCPlayStates playState;


@end
