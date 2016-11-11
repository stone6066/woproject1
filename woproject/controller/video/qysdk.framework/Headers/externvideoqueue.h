//
//  externvideoqueue.h
//  qysdk
//
//  Created by yj on 16/3/2.
//  Copyright © 2016年 yj. All rights reserved.
//

#ifndef externvideoqueue_h
#define externvideoqueue_h

#include <inttypes.h>

#ifndef VIDEOQUEUE_H

#pragma pack(1)

#define VIDEOHEAD_PRE       12

struct VideoHead
{
    uint32_t        length; // 数据区大小
    uint64_t        playTime; // 播放时间
    
    uint64_t        capTime; // 采集时间戳
    uint8_t         rate; // 帧率
    uint8_t         format; // 编码格式
    uint8_t         iframe; // 是否关键帧
    uint16_t        width; // 宽度
    uint16_t        height; // 高度
};

#pragma pack()

typedef void (__stdcall *VideoOutFun)(void* vq, struct VideoHead* video, uint8_t* h264);

#endif // VIDEOQUEUE_H

#ifdef __cplusplus
extern "C"
{
#endif // __cplusplus
    
    void* vq_init(VideoOutFun fun, void* flag);
    void vq_release(void* p);
    
    void vq_set_cache_time(void *p, int t);
    void vq_add(void *p, uint8_t* data, uint32_t len);
    
#ifdef __cplusplus
}
#endif // __cplusplus

#endif /* externvideoqueue_h */
