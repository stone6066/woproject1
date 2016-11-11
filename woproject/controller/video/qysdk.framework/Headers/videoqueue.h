#ifndef VIDEOQUEUE_H
#define VIDEOQUEUE_H
#include <pthread.h>
#include <list>
#include <inttypes.h>
#include <string>

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


class VideoQueue;
typedef void (__stdcall *VideoOutFun)(void* vq, VideoHead* video, uint8_t* h264);


class VideoQueue
{
public:
    VideoQueue(VideoOutFun fun, void* flag);

private:
    virtual ~VideoQueue();
    void        AddRef();   // 不允许外部调用, 主要用来同步线程

public:
    void*       GetFlag();
    void        Release();
    void        SetCacheTime(int t);
    void        AddQueue(uint8_t* data, uint32_t len);

private:
    void        RunLoop();
    uint32_t    GetSleepTime(VideoHead* head, VideoHead *future);

public:
    static VideoQueue* Create(VideoOutFun fun, void *flag);
    static void* ThreadProc(void* p);
    static uint64_t GetTime();
    static void Log(const char* fmt, ...);

private:
    long                        m_ref;
    pthread_key_t               m_thread_key;
    VideoOutFun                 m_fun;
    void*                       m_flag;
    // 线程相关
    pthread_t                   m_tid;
    bool                        m_stop;
    // 队列相关
    pthread_mutex_t             m_lock;
    pthread_cond_t              m_cond;
    std::list<VideoHead*>       m_queue;
    // 算法相关
    bool                        isFirst;
    int64_t                    disT;  //设备和系统的时间差，全部转换为设备时间来判断 =  satrtDT - startST
    int64_t                    lastFrameCapT;//最后一帧的采集时间,用来算出当前帧的时长间隔
    int64_t                    lastFramePlayT;//最后一帧的播放时间,用来算出当前帧的时长间隔
    int64_t                    defaultCacheT;//缓存总时长,默认为200毫秒
    int64_t                    curCacheT;//当前缓存时长,有可能超过预设缓存，此时就要快播,如果不够缓存就需要慢播(一般只是开始部分才慢播)
    int                         accelerationPercent;//加速百分比，在缓存太多时的加速播放时间间隔比,一定要小于1
    int                         decelerationPercent;//减速百分比，在缓存不够时的减速播放时间间隔比,一定要大于1
    // 跳帧处理
    bool                        m_skipFrame;
};

#endif // VIDEOQUEUE_H
