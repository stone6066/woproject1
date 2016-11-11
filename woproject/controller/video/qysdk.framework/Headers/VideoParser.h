//
//  VideoParser.h
//  qysdk
//
//  Created by 吴怡顺 on 25/3/16.
//  Copyright © 2016年 yj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VideoParser : NSObject

@property (nonatomic) int defH;
@property (nonatomic) int defW;

//解码
- (UIImage*) parserVideoData:(NSData *)data;

-(void)releasePP;

@end


typedef struct _NALUnit{
    unsigned int type;
    unsigned int size;
    unsigned char *data;
}NALUnit;

typedef enum{
    NALUTypeBPFrame = 0x01,
    NALUTypeIFrame = 0x05,
    NALU_TYPE_SEI=0x06,
    NALUTypeSPS = 0x07,
    NALUTypePPS = 0x08
}NALUType;
