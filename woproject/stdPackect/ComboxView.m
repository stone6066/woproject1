//
//  DropDown.m
//  UICombox
//
//  Created by Ralbatr on 14-3-17.
//  Copyright (c) 2014年 Ralbatr. All rights reserved.
//

#import "ComboxView.h"

@implementation ComboxView

-(id)initWithFrame:(CGRect)frame titleStr:(NSString*)tstr
{
    if (frame.size.height<200) {
        frameHeight = 200;
    }else{
        frameHeight = frame.size.height;
    }
    tabheight = frameHeight-30;
    
    frame.size.height = 30.0f;
    
    self = [super initWithFrame:frame];
    
    if(self){
        showList = NO; //默认不显示下拉框
        
        [self creatTableView:frame];
        UIView *comboxBackGroudVc=[[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
        comboxBackGroudVc.backgroundColor=MyGrayColor;
        UIView *comboxVc=[[UIView alloc]initWithFrame:CGRectMake(1, 1, frame.size.width-2, 40-2)];
        comboxVc.backgroundColor=[UIColor whiteColor];
        [comboxBackGroudVc addSubview:comboxVc];
        
        UILabel *comboxTitle=[[UILabel alloc]initWithFrame:CGRectMake(5, 10, 50, 20)];
        comboxTitle.text=tstr;
        [comboxTitle setFont:[UIFont systemFontOfSize:12]];
        [comboxTitle setTextColor:[UIColor blackColor]];
        [comboxVc addSubview:comboxTitle];
        
        
        if (!_textLbl) {
            _textLbl=[[UILabel alloc]initWithFrame:CGRectMake(60, 5, frame.size.width-70, 30)];
            [_textLbl setFont:[UIFont systemFontOfSize:12]];
            _textLbl.text=@"---------";
            [comboxVc addSubview:_textLbl];
        }
        UIImageView * arrowDown=[[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-40, 12, 20, 12)];
        arrowDown.image=[UIImage imageNamed:@"downArrow"];
        [comboxVc addSubview:arrowDown];
        
        if (!_viewBtn) {
            _viewBtn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, 40)];
             [_viewBtn addTarget:self action:@selector(dropdown) forControlEvents:UIControlEventTouchUpInside];
            [comboxBackGroudVc addSubview:_viewBtn];
        }
        
        [self addSubview:comboxBackGroudVc];
        
    }
    return self;
}



- (void)creatTableView:(CGRect)frame
{
    _dropTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 30, frame.size.width, 0)];
    _dropTableView.delegate = self;
    _dropTableView.dataSource = self;
    _dropTableView.hidden = YES;
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    [self dropdown];
//    return NO;
//}

- (void)closeTableView
{
    if (showList) {
        self.hidden = YES;
        NSLog(@"在选择状态");
    }
}

-(void)dropdown{

    if (showList)
    {//如果下拉框已显示，移除
        [self stdRemoveView];
    }
    else
    {//如果下拉框尚未显示，则进行显示
        
        CGRect sf = self.frame;
        sf.size.height = frameHeight;
        [self addSubview:_dropTableView];        
        //把dropdownList放到前面，防止下拉框被别的控件遮住
        [self.superview bringSubviewToFront:self];
        _dropTableView.hidden = NO;
        showList = YES;//显示下拉框
        
        CGRect frame = _dropTableView.frame;
        frame.size.height = 0;
        _dropTableView.frame = frame;
        frame.size.height = tabheight;
        [UIView beginAnimations:@"ResizeForKeyBoard" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveLinear];
        self.frame = sf;
        _dropTableView.frame = frame;
        [UIView commitAnimations];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_tableArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.text = [_tableArray objectAtIndex:[indexPath row]];
    cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 35;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _textLbl.text = [_tableArray objectAtIndex:[indexPath row]];
    [self stdRemoveView];
//    showList = NO;
//    _dropTableView.hidden = YES;
//    
//    CGRect sf = self.frame;
//    sf.size.height = 30;
//    self.frame = sf;
//    CGRect frame = _dropTableView.frame;
//    frame.size.height = 0;
//    _dropTableView.frame = frame;
//    //选择完后，移除
//    [_dropTableView removeFromSuperview];
}

-(void)stdRemoveView{
    showList = NO;
    _dropTableView.hidden = YES;
    
    CGRect sf = self.frame;
    sf.size.height = 30;
    self.frame = sf;
    CGRect frame = _dropTableView.frame;
    frame.size.height = 0;
    _dropTableView.frame = frame;
    //选择完后，移除
    [_dropTableView removeFromSuperview];

}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
