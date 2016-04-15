//
//  MainViewController.m
//  LeanChatExample
//
//  Created by lzw on 15/4/3.
//  Copyright (c) 2015年 avoscloud. All rights reserved.
//

#import "MainViewController.h"
#import "LCEChatRoomVC.h"

@interface MainViewController ()

@property (weak, nonatomic) IBOutlet UITextField *otherIdTextField;

@property (weak, nonatomic) IBOutlet UITextField *groupId1TextField;

@property (weak, nonatomic) IBOutlet UITextField *groupId2TextField;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
}

- (IBAction)goChat:(id)sender {
    NSString *otherId = self.otherIdTextField.text;
    if (otherId.length > 0) {
        WEAKSELF
        [[CDChatManager manager] fetchConversationWithOtherId : otherId callback : ^(AVIMConversation *conversation, NSError *error) {
            if (error) {
                DLog(@"%@", error);
            }
            else {
                LCEChatRoomVC *chatRoomVC = [[LCEChatRoomVC alloc] initWithConversation:conversation];
                [weakSelf.navigationController pushViewController:chatRoomVC animated:YES];
            }
        }];
    }
}

- (IBAction)goGroupChat:(id)sender {
    NSString *groupId1 = self.groupId1TextField.text;
    NSString *groupId2 = self.groupId2TextField.text;
    if (groupId1.length > 0 && groupId2.length > 0) {
        WEAKSELF
        NSMutableArray *memberIds = [NSMutableArray array];
        [memberIds addObject:groupId1];
        [memberIds addObject:groupId2];
        [memberIds addObject:[CDChatManager manager].selfId];
        [[CDChatManager manager] fetchConversationWithMembers:memberIds callback: ^(AVIMConversation *conversation, NSError *error) {
            if (error) {
                DLog(@"%@", error);
            }
            else {
                LCEChatRoomVC *chatRoomVC = [[LCEChatRoomVC alloc] initWithConversation:conversation];
                [weakSelf.navigationController pushViewController:chatRoomVC animated:YES];
            }
        }];
    }
}

@end
