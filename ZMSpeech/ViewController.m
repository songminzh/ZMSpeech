//
//  ViewController.m
//  MPSpeech
//
//  Created by zheng min on 2019/5/31.
//  Copyright © 2019 Micropattern. All rights reserved.
//

#import "ViewController.h"
#import <Speech/Speech.h>

static NSString *cellID = @"cellID";

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSArray *tipsList;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) AVSpeechSynthesizer *speaker;

@end

@implementation ViewController

- (NSArray *)tipsList {
    if (!_tipsList) {
        _tipsList = @[@"春江潮水连海平", @"海上明月共潮生",
                      @"艳艳随波千万里", @"何处春江无月明",
                      @"江流宛转绕芳甸", @"月照花林皆似霰",
                      @"空里流霜不觉飞", @"汀上白沙看不见",
                      @"江天一色无纤尘", @"皎皎空中孤月轮",
                      @"江畔何人初见月", @"江月何年初照人",
                      @"人生代代无穷已", @"江月年年望相似",
                      @"不知江月待何人", @"但见长江送流水",
                      @"白云千载空悠悠", @"青枫浦上不胜愁",
                      @"谁家今夜扁舟子", @"何处相思明月楼",
                      @"可怜楼上月徘徊", @"捣衣砧上拂还来",
                      @"此时相望不相闻", @"愿逐月华独照君",
                      @"鸿雁长飞光不度", @"鱼龙潜跃水成文",
                      @"昨夜闲潭梦落花", @"可怜春半不还家",
                      @"江水流春去欲尽", @"江潭落月复西斜",
                      @"斜月沉沉藏海雾", @"碣石潇湘无限路",
                      @"不知乘月几人归", @"落月摇情满江树"];
    }
    return _tipsList;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [UIView new];
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:cellID];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"文字朗读";
    [self.view addSubview:self.tableView];
}

/*
 Language: zh-CN, Name: Li-mu (Enhanced), Quality: Enhanced [com.apple.ttsbundle.siri_male_zh-CN_premium]
 Language: zh-CN, Name: Ting-Ting (Enhanced), Quality: Enhanced [com.apple.ttsbundle.Ting-Ting-premium]
 Language: zh-CN, Name: Ting-Ting (Enhanced), Quality: Enhanced [com.apple.ttsbundle.Ting-Ting-premium]
 Language: zh-CN, Name: Li-mu, Quality: Default [com.apple.ttsbundle.siri_male_zh-CN_compact]
 Language: zh-CN, Name: Ting-Ting, Quality: Default [com.apple.ttsbundle.Ting-Ting-compact]
 
 Language: zh-CN, Name: Yu-shu, Quality: Default [com.apple.ttsbundle.siri_female_zh-CN_compact]
 Language: zh-CN, Name: Yu-shu (Enhanced), Quality: Enhanced [com.apple.ttsbundle.siri_female_zh-CN_premium]
 */
-(void)speech:(NSString *)string {
    if(string && string.length > 0){
        if (self.speaker.isSpeaking) {
            [self.speaker stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
        }
        
        if (!self.speaker) {
            self.speaker = [[AVSpeechSynthesizer alloc]init];
        }
        
        AVSpeechUtterance *utterance = [[AVSpeechUtterance alloc] initWithString:string];//设置语音内容
        //utterance.voice  = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"]; //设置语言
        AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithIdentifier:@"com.apple.ttsbundle.Ting-Ting-compact"];
        utterance.voice = voice;
        utterance.rate   = 0.5;  // 设置语速
        utterance.volume = 1.0;  // 设置音量（0.0~1.0）默认为1.0
        utterance.pitchMultiplier    = 1.0;  // 设置语调 (0.5-2.0)
        utterance.postUtteranceDelay = 0; // 目的是让语音合成器播放下一语句前有短暂的暂停
        [self.speaker speakUtterance:utterance];
    }
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID forIndexPath:indexPath];
    cell.textLabel.text = self.tipsList[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tipsList.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    [self speech:self.tipsList[indexPath.row]];
}

@end
