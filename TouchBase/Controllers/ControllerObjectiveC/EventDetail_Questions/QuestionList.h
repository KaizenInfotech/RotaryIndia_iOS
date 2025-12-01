//
//  QuestionList.h
//  TouchBase
//
//  Created by Kaizan on 29/02/16.
//  Copyright © 2016 Parag. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QuestionList : NSObject

@property(nonatomic, strong)NSString *questionId;
@property(nonatomic, strong)NSString *questionType;
@property(nonatomic, strong)NSString *questionText;
@property(nonatomic, strong)NSString *option1;
@property(nonatomic, strong)NSString *option2;

@end
