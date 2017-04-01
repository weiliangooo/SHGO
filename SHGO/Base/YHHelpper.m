//
//  YHHelpper.m
//  benben
//
//  Created by xunao on 15-2-27.
//  Copyright (c) 2015年 xunao. All rights reserved.
//

#import "YHHelpper.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@implementation YHHelpper

//去掉空格
+(NSString*)trim:(NSString*)string{
    NSString *newString = [string stringByTrimmingCharactersInSet:
                           [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return newString==nil?@"":newString;
}
//读取所有联系人
+(NSMutableDictionary*)ReadAllPeoples
{
    //取得本地通信录名柄
    ABAddressBookRef tmpAddressBook = nil;
    if ([[UIDevice currentDevice].systemVersion floatValue]>=6.0) {
        tmpAddressBook=ABAddressBookCreateWithOptions(NULL, NULL);
        dispatch_semaphore_t sema=dispatch_semaphore_create(0);
        ABAddressBookRequestAccessWithCompletion(tmpAddressBook, ^(bool greanted, CFErrorRef error){
            dispatch_semaphore_signal(sema);
        });
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    }
    else
    {
        tmpAddressBook =ABAddressBookCreateWithOptions;
    }
    if (tmpAddressBook==nil) {
        return nil ;
    };
    NSArray* tmpPeoples = (__bridge NSArray*)ABAddressBookCopyArrayOfAllPeople(tmpAddressBook);
    NSString *phone=@"";
    for(id tmpPerson in tmpPeoples)
    {
        if (phone.length>0) {
            phone=[phone stringByAppendingString:@"|"];
        }
        NSString* tmpFirstName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonFirstNameProperty);
        //获取的联系人单一属性:Last name
        NSString* tmpLastName = (__bridge NSString*)ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonLastNameProperty);
        if (tmpFirstName==nil) {
            tmpFirstName=@"";
        }if (tmpLastName==nil) {
            tmpLastName=@"";
        }
        NSString *userName=[tmpLastName stringByAppendingString:tmpFirstName];
        //获取的联系人单一属性:Generic phone number
        ABMultiValueRef tmpPhones = ABRecordCopyValue((__bridge ABRecordRef)(tmpPerson), kABPersonPhoneProperty);
        NSString* tmpPhoneIndex=@"";
        for(int j = 0; j < ABMultiValueGetCount(tmpPhones); j++)
        {
            if (j>0) {
                tmpPhoneIndex=[tmpPhoneIndex stringByAppendingString:@"#"];
            }
            NSString *tmpPhoneMid = (__bridge NSString*)ABMultiValueCopyValueAtIndex(tmpPhones, j);
            //            NSLog(@"tmpPhoneIndex%d:%@", j, tmpPhoneIndex);
            tmpPhoneMid = [tmpPhoneMid stringByReplacingOccurrencesOfString:@"-" withString:@""];
            tmpPhoneIndex=[tmpPhoneIndex stringByAppendingString:[NSString stringWithFormat:@"%@",tmpPhoneMid]];
        }
        phone=[phone stringByAppendingString:[NSString stringWithFormat:@"%@::%@",tmpPhoneIndex,userName]];
        CFRelease(tmpPhones);
    }
    CFRelease(tmpAddressBook);
    //    NSLog(@"%@",phone);
    NSMutableDictionary *param=[[NSMutableDictionary alloc]init];
    [param setObject:@"" forKey:@"group"];
    [param setObject:phone forKey:@"phone"];
    return param;
}
+ (float) heightForTextView: (UITextView *)textView WithText: (NSString *) strText{
    float fPadding = 16.0; // 8.0px x 2
    CGSize constraint = CGSizeMake(textView.contentSize.width - fPadding, CGFLOAT_MAX);
    
    CGSize size = [strText sizeWithFont: textView.font constrainedToSize:constraint lineBreakMode:NSLineBreakByCharWrapping];
    
    float fHeight = size.height + 16.0;
    
    return fHeight;
}
+ (NSString *) phonetic:(NSString*)sourceString {
    NSString *str;
    sourceString=[self trim:sourceString];
    if (sourceString.length) {
        NSString *txt = [sourceString substringToIndex:1];
        NSMutableString *source = [txt mutableCopy];
        CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformMandarinLatin, NO);
        CFStringTransform((__bridge CFMutableStringRef)source, NULL, kCFStringTransformStripDiacritics, NO);
        str = [source substringToIndex:1];
        str=[str stringByReplacingCharactersInRange:NSMakeRange(0,1) withString:[[str substringToIndex:1] uppercaseString]];
        
    }else{
        str=@"#";
    }
    
    return str;
    
}

+(NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (int)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
+(BOOL)isMobileNumber:(NSString *)mobileNum
{
    //    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSString *regex =@"(\\+\\d+)?(\\d{3,4}\\-?)?\\d{8}$";
    
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    
    BOOL isMatch = [pred evaluateWithObject:mobileNum];
    
    return isMatch;
}

@end
