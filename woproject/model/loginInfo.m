//
//  loginInfo.m
//  Proprietor
//
//  Created by tianan-apple on 16/6/27.
//  Copyright © 2016年 tianan-apple. All rights reserved.
//

#import "loginInfo.h"



@implementation loginInfo
- (loginInfo *)asignInfoWithDict:(NSDictionary *)dict{
    
    NSDictionary *idict = [dict objectForKey:@"i"];
    NSDictionary *dictArray = [idict objectForKey:@"Data"];
    loginInfo *LGInfo=[[loginInfo alloc]init];
    NSMutableArray *deptLArr=[[NSMutableArray alloc]init];
    NSMutableArray *projectLArr=[[NSMutableArray alloc]init];
    NSMutableArray *roleLArr=[[NSMutableArray alloc]init];
    
    LGInfo.iccId=[dictArray objectForKey:@"iccId"];
    LGInfo.Id=[dictArray objectForKey:@"id"];
    LGInfo.idNumber=[dictArray objectForKey:@"idNumber"];
    LGInfo.image=[dictArray objectForKey:@"image"];
    LGInfo.image=[dictArray objectForKey:@"image"];
    LGInfo.isInvoke=[dictArray objectForKey:@"isInvoke"];
    LGInfo.isLogin=[dictArray objectForKey:@"isLogin"];
    LGInfo.isValid=[dictArray objectForKey:@"isValid"];
    LGInfo.loginName=[dictArray objectForKey:@"loginName"];
    LGInfo.name=[dictArray objectForKey:@"name"];
    LGInfo.phone=[dictArray objectForKey:@"phone"];
    LGInfo.ukey=[dictArray objectForKey:@"ukey"];
    LGInfo.m=[dict objectForKey:@"m"];
    LGInfo.v=[dict objectForKey:@"v"];
    LGInfo.s=[dict objectForKey:@"s"];
        
    NSDictionary *deptArr=[dictArray objectForKey:@"deptList"];
        
        for (NSDictionary *depttmp in deptArr) {
            deptList *depList=[[deptList alloc]init];
            depList.Id= [depttmp objectForKey:@"id"];
            depList.name=[depttmp objectForKey:@"name"];
            depList.parentId=[depttmp objectForKey:@"parentId"];
            depList.parentName=[depttmp objectForKey:@"parentName"];
            depList.remark=[depttmp objectForKey:@"remark"];
            [deptLArr addObject:depList];
            
        }
        LGInfo.deptList=deptLArr;
        
    NSDictionary *projectArr=[dictArray objectForKey:@"projectList"];
        for (NSDictionary *depttmp in projectArr) {
            projectList *projectL=[[projectList alloc]init];
            projectL.Id= [depttmp objectForKey:@"id"];
            projectL.name=[depttmp objectForKey:@"name"];
            projectL.typeId=[depttmp objectForKey:@"typeId"];
            projectL.ciytId=[depttmp objectForKey:@"ciytId"];
            projectL.v=[depttmp objectForKey:@"v"];
            [projectLArr addObject:projectL];
        }
        LGInfo.projectList=projectLArr;
        
    NSDictionary *roleArr=[dictArray objectForKey:@"roleList"];
        for (NSDictionary *depttmp in roleArr) {
            roleList *roleL=[[roleList alloc]init];
            roleL.Id= [depttmp objectForKey:@"id"];
            roleL.name=[depttmp objectForKey:@"name"];
            roleL.level=[depttmp objectForKey:@"level"];
           
            [roleLArr addObject:roleL];
        }
        LGInfo.roleList=roleLArr;

    return LGInfo;
    
}

-(NSString *)stdTimeToStr:(NSString*)intTime{
    NSTimeInterval interval=[[intTime substringToIndex:10] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    NSDateFormatter *objDateformat = [[NSDateFormatter alloc] init];
    [objDateformat setDateFormat:@"yyyy-MM-dd"];
    return [objDateformat stringFromDate: date];
}
@end
