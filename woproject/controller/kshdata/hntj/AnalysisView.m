//
//  AnalysisView.m
//  woproject
//
//  Created by 关宇琼 on 2016/10/20.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "AnalysisView.h"
#import "SingleAnalysisView.h"




@implementation AnalysisView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor= [UIColor clearColor];
    }
    return self;
}

- (void)createSingleViewWith:(NSArray *)arr {
    
    if (self.subviews.count > 0) {
        [self removeAllSubviews];
    }
    
    for (NSInteger i = 0; i < arr.count; i ++) {
        SingleAnalysisView *singleAnalysisView = [[SingleAnalysisView alloc] init];
        singleAnalysisView.data = arr[i];
        [singleAnalysisView setFrame:CGRectMake(fDeviceWidth / arr.count * i, 0, fDeviceWidth / arr.count, 70)];
        [self addSubview:singleAnalysisView];
        
        if ( i!= arr.count - 1) {
            UILabel *linelb = [[UILabel alloc] init];
            [linelb setFrame:CGRectMake(singleAnalysisView.right + 5, 15, 1, 40)];
            linelb.backgroundColor = RGB(192, 194, 201);
            [self addSubview:linelb];
        }
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
