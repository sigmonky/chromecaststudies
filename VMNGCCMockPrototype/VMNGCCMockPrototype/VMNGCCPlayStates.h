//
//  VMNGCCPlayStates.h
//  VMNGCCMockPrototype
//
//  Created by Weinstein, Randy - Nick.com on 6/9/14.
//  Copyright (c) 2014 Viacom. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum {
    DEVICESUNDETECTED,
    DEVICESDETECTED,
    DEVICESELECTED,
    DEVICECONNECTED,
    DEVICEDISCONNECTED,
    MEDIALOADING,
    MEDIALOADED,
    MEDIAPLAYING,
    MEDIAPAUSED,
    MEDIABUFFERING,
    MEDIASTOPPED
} VMNGCCPlayState;

typedef enum {
    PLAY,
    PAUSE,
    RESUME,
    STOP
} VMNGCCPlayStateRequest;


@interface VMNGCCPlayStates : NSObject

@end
