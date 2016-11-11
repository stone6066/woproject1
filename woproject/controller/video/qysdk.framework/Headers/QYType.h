//
//  QYType.h
//  qysdk
//
//  Created by yj on 15/9/24.
//  Copyright © 2015年 yj. All rights reserved.
//
#include <sys/time.h>

#ifndef QYType_h
#define QYType_h

enum QY_LOG_LEVEL {
    QY_LOG_NONE = 0,        // 不打印日志
    QY_LOG_ERROR = 1,       // 打印错误日志
    QY_LOG_WARNING = 2,     // 打印警告日志和错误日志
    QY_LOG_INFO = 3,         // 打印信息日志、警告日志和错误日志
    QY_LOG_DEBUG             //调试信息
};

enum QY_PTZ_TYPE {
    QY_ZOOM_IN =0,             // 变倍-放大
    QY_ZOOM_OUT,               // 变倍-缩小
    QY_IRIS_IN,                // 光圈-放大
    QY_IRIS_OUT,               // 光圈-缩小
    QY_FOCUS_NEAR,             // 调焦-近
    QY_FOCUS_FAR,              // 调焦-远
    QY_MOVE_UP,                // 镜头移动-上
    QY_MOVE_DOWN,              // 镜头移动-下
    QY_MOVE_LEFT,              // 镜头移动-左
    QY_MOVE_RIGHT,             // 镜头移动-右
    QY_MOVE_LEFTUP,            // 镜头移动-上左
    QY_MOVE_RIGHTUP,           // 镜头移动-上右
    QY_MOVE_LEFTDOWN,          // 镜头移动-下左
    QY_MOVE_RIGHTDOWN,         // 镜头移动-下右
    QY_STOP,                   // 停止当前操作
    QY_SET_SPEED,              // 设定操作速度 speed 速度值百分比(0-63)
    QY_RESET=16                // 重置
 };


enum QY_VIDEO_QUALITY {
    QY_VQ_LOWER = 1,         //普清
    QY_VQ_STANDER, // 标清
    QY_VQ_HIGHT, // 高清
    QY_VQ_SUPPER // 超清
};


// 设备列表数据结构
typedef struct
{
    uint64_t        deviceID;       // 设备通道id
    int             status;         // 设备状态: 0离线, 1在线
} QY_DEVICE_INFO;

// 设备通道列表数据结构
typedef struct
{
    uint64_t        channelID;      // 通道id
    int             status;         // 设备状态: 0离线, 1在线, -1未启用
    int             cloud;          // 云存状态: 0关闭, 1开启
} QY_CHANNEL_INFO;

// 报警信息数据结构
typedef struct
{
    char            alarmID[64];        // 报警GUID
    uint64_t        devID;              // 设备ID
    uint64_t        channelID;          // 通道ID
    int             type;               // 报警类型
    char            content[256];       // 报警内容
    char            time[64];          // 报警时间
    char            shotUrl[256];       // 报警截图网址
    char            videoUrl[256];      // 报警录像地址
    char            actionScript[256];  // 执行脚本
} QY_ALARM_INFO;


// 云台状态
typedef struct
{
    int             position;           // 云台位置
    int             speed;              // 速度 1-100的百分比速度
    int             baudRate;           // 波特率
    int             dataBit;            // 数据位
    int             stopBit;            // 停止位
    int             check;              // 校验 0:无、1:奇校验、2:偶校验
    int             tract[64];          // 巡航
    int             tractcnt;           //
    int             presetPoint;        // 预警点
} QY_PTZ_STATUS;


// 报警查询类型
typedef enum
{
    QY_ALARM_MOTION_DETECT = 0,         // 移动侦测
    QY_ALARM_VIDEO_COVER = 1            // 遮盖报警
} QY_ALARM_TYPE;

// 时间段配数据结构
typedef struct{
    char            start[64];          // 开始时间
    char            end[64];            // 结束时间
} QY_TIME_BUCKET;

// 日期配置
typedef struct{
    int             count;              // 段个数
    QY_TIME_BUCKET  times[20];
} QY_DAY_TIMES;

// 报警配置
typedef struct{
    int             enable;             // 移动侦测使能0：关闭 1：打开
    int             sensitive;          // 灵敏度0：关闭 1：打开
    int             regionSetting[30];  // 区域设置
    QY_DAY_TIMES    days[7];            // 一周的时间段
    int             buzzerMoo;          // 蜂鸣器鸣叫0：关闭 1：打开
    int             alarmOut;           // 报警输出0：关闭 1：打开
    int             record;             // 触发录像0：关闭 1：打开
    int             preRecord;          // 预录像0：关闭 1：打开
    int             shotSnap;           // 抓拍0：关闭 1：打开
    int             sendEmail;          // 发送email0：关闭 1：打开
    int             sendFtp;            // 发送ftp0：关闭 1：打开
    int             interval;           // 告警间隔
    int             curIndex;           // 当前时间计划
} QY_ALARM_CONFIG;

// 录像状态
typedef struct {
    int             enable;            // 录像状态, 0:关闭，1:打开
    QY_DAY_TIMES    days[7];            //
} QY_RECORD_CONFIG;

// 天概要索引信息
typedef struct {
    int             year;               // 年
    int             month;              // 月
    int             day;                // 日
} QY_DAY;

// 天文件索引
typedef struct {
    int             year;
    int             month;
    int             daysnum;            // 一个月内录像的天数
    QY_DAY          days[31];
} QY_DAYS_INDEX;

// 时间结构
typedef struct {
    int         year;
    int         month;
    int         day;
    int         hour;
    int         minute;
    int         seconds;
} QY_TIME;

// 时间段数据结构
typedef struct {
    QY_TIME starttime;
    QY_TIME endtime;
} QY_TIME_BUCKET2;


typedef struct{
    char subDevId[64];//摄像头编号
    char ip[64];//ip地址
    int State;//绑定状态0:未绑定 1:已绑定(只有获取ipc列表是才有用)
}QY_IPC_INFO;


//画质模式组
typedef struct{
    int module;//画质 1-普清 2-标清 3-高清 4-超清
    char resolution[256];//分辨率
    int framerate;//帧率
    int picQuality;//质量
}QY_CHANELCODQY_MOUDLES;
//画质参数类型
typedef struct{
    char resolutionList[3][256];//分辨率
    int frameRate[2];//帧率范围framerate[0]-framerate[1]
    int picQuality[2];//质量
    int iFrameInterval[2];//I帧间隔范围iframeinterval[0]-iframeinterval[1]
}QY_CHANELCODQY_TYPE;
//当前通道设置状态
typedef struct{
    int module;//当前画质模式
    char resolution[256];//分辨率
    int frameRate;//帧率
    int picQuality;//质量
    int iFrameInterval;//I帧间隔
    int bitRateType;//码率模式 1：VBR、2：CBR、3：fixQP
    int encondeMode;//编码模式 1:jpeg、2:h264
}QY_CHANELCODQY_CURSTA;


typedef struct{
    int modulescnt;
    QY_CHANELCODQY_MOUDLES modulesls[10];
    QY_CHANELCODQY_TYPE paramtype;
    QY_CHANELCODQY_CURSTA cursta;
}QY_CHANELCODQY_STA;


typedef enum {
    QY_DR_UNKNOWN, // 未知原因
    QY_DR_INITIATIVE, // 主动退出
    QY_DR_PASSIVE // 被踢下线
} QY_DISCONNECT_REASON;

typedef enum {
    QY_RS_START,
    QY_RS_END,
    QY_RS_WRITQY_ERROR
} QY_RECORD_STATUS;

//设备类型
typedef enum{
    QY_DT_CONTAINER = 1,//设备
    QY_DT_CHANNEL ,//通道
}QY_DEVICE_TYPE;


typedef struct{
    int video;//视频 0：无 1：有
    int audio;//语音
    int venc;//画质设置
    int flip;//翻转
    int talk;//对讲
    int ptz;//云台
    // int focuszoom;//变焦
    int zoom; // 变倍
    int aperture; // 光圈
    int focus; // 变焦
    int replay;//回放
    int recPlan;//录像计划
    int warnPlan;//报警计划
    int errorNo;//错误码
}QY_DEVICE_FUN;

//画质模式组
typedef struct{
    int module;//画质 1-普清 2-标清 3-高清 4-超清
    char resolution[256];//分辨率
    int framerate;//帧率
    int picQuality;//质量
}QY_CHANELCODQY_MODULES;
//当前通道设置状态
typedef struct{
    int module;//当前画质模式
    char resolution[256];//分辨率
    int frameRate;//帧率
    int picQuality;//质量
    int iFrameInterval;//I帧间隔
    int bitRateType;//码率模式 1：VBR、2：CBR、3：fixQP
    int encondeMode;//编码模式 1:jpeg、2:h264
}QY_CHANELCODQY_CURENTSTA;



@interface QYTimeIndex : NSObject
{
    @public
    int             version;
    int             type;
    int             num;
    NSMutableArray  *times; // QY_TIME_BUCKET2
}

@end

#endif /* QYType_h */
