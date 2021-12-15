
#import "NSString+KX.h"
#import "NSData+KX.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (KX)

#pragma mark - 有效的手机号
- (BOOL)kx_isValidMobileNumber {
    NSString * regex = @"^1[3456789]\\d{9}$";
    return [self isValidByRegex:regex];
}

#pragma mark - 有效的身份证号
- (BOOL)kx_isIdCardNumber {
    if (self.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
      NSString * regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:self]) return NO;
    //** 开始进行校验 *//
    //将前17位加权因子保存在数组里
    NSArray * idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray * idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17; i++) {
        NSInteger subStrIndex = [[self substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum += subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod = idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast = [self substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod == 2) {
        if(![idCardLast isEqualToString:@"X"] && ![idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    } else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - 有效的真实姓名
- (BOOL)kx_isValidRealName {
    NSString * regex = @"^[\u4e00-\u9fa5]{2,8}$";
    return [self isValidByRegex:regex];
}

#pragma mark - 有效的验证码
- (BOOL)kx_isValidVerifyCode:(NSInteger)length {
    NSString * regex = [NSString stringWithFormat:@"^[0-9]{%ld}", length];
    return [self isValidByRegex:regex];
}

#pragma mark - 有效的银行卡号
/** 银行卡号有效性问题Luhn算法
 *  现行 16 位银联卡现行卡号开头 6 位是 622126～622925 之间的，7 到 15 位是银行自定义的，
 *  可能是发卡分行，发卡网点，发卡序号，第 16 位是校验码。
 *  16 位卡号校验位采用 Luhm 校验方法计算：
 *  1，将未带校验位的 15 位卡号从右依次编号 1 到 15，位于奇数位号上的数字乘以 2
 *  2，将奇位乘积的个十位全部相加，再加上所有偶数位上的数字
 *  3，将加法和加上校验位能被 10 整除。
 */
- (BOOL)kx_isValidBankCardNumber {
    NSString * lastNum = [[self substringFromIndex:(self.length-1)] copy];//取出最后一位
    NSString * forwardNum = [[self substringToIndex:(self.length -1)] copy];//前15或18位
    NSMutableArray * forwardArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i<forwardNum.length; i++) {
        NSString * subStr = [forwardNum substringWithRange:NSMakeRange(i, 1)];
        [forwardArr addObject:subStr];
    }
    NSMutableArray * forwardDescArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = (int)(forwardArr.count-1); i> -1; i--) {//前15位或者前18位倒序存进数组
        [forwardDescArr addObject:forwardArr[i]];
    }
    NSMutableArray * arrOddNum = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 < 9
    NSMutableArray * arrOddNum2 = [[NSMutableArray alloc] initWithCapacity:0];//奇数位*2的积 > 9
    NSMutableArray * arrEvenNum = [[NSMutableArray alloc] initWithCapacity:0];//偶数位数组
    for (int i=0; i< forwardDescArr.count; i++) {
        NSInteger num = [forwardDescArr[i] intValue];
        if (i%2) {//偶数位
            [arrEvenNum addObject:[NSNumber numberWithInteger:num]];
        }else{//奇数位
            if (num * 2 < 9) {
                [arrOddNum addObject:[NSNumber numberWithInteger:num * 2]];
            }else{
                NSInteger decadeNum = (num * 2) / 10;
                NSInteger unitNum = (num * 2) % 10;
                [arrOddNum2 addObject:[NSNumber numberWithInteger:unitNum]];
                [arrOddNum2 addObject:[NSNumber numberWithInteger:decadeNum]];
            }
        }
    }
    __block  NSInteger sumOddNumTotal = 0;
    [arrOddNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNumTotal += [obj integerValue];
    }];
    __block NSInteger sumOddNum2Total = 0;
    [arrOddNum2 enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumOddNum2Total += [obj integerValue];
    }];
    __block NSInteger sumEvenNumTotal =0 ;
    [arrEvenNum enumerateObjectsUsingBlock:^(NSNumber * obj, NSUInteger idx, BOOL *stop) {
        sumEvenNumTotal += [obj integerValue];
    }];
    NSInteger lastNumber = [lastNum integerValue];
    NSInteger luhmTotal = lastNumber + sumEvenNumTotal + sumOddNum2Total + sumOddNumTotal;
    return (luhmTotal%10 ==0)?YES:NO;
}

#pragma mark - 有效的邮箱
- (BOOL)kx_isValidEmail {
    NSString * regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    return [self isValidByRegex:regex];
}

#pragma mark - 是否只有中文
- (BOOL)kx_isValidChinese {
    NSString * regex =@"^[\u4e00-\u9fa5]{0,}$";
    return [self isValidByRegex:regex];
}

#pragma mark - 是否是纯数字
- (BOOL)kx_isOnlyNumber {
    NSScanner * scan = [NSScanner scannerWithString:self];
    NSInteger val;
    return [scan scanInteger:&val] && [scan isAtEnd];
}

#pragma mark - 正则验证
- (BOOL)isValidByRegex:(NSString *)regex {
    NSPredicate * predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:self];
}

#pragma mark - 手机号中间4位*显示
- (NSString *)kx_secrectMobile {
    if ([self kx_isValidMobileNumber]) {
        NSMutableString * resString = [NSMutableString stringWithString:self];
        NSRange range = NSMakeRange(3, 7);
        [resString stringByReplacingCharactersInRange:range withString:@"****"];
        return resString;
    }
    return nil;
}

#pragma mark - 姓*显示
- (NSString *)kx_secrectRealName {
    if ([self kx_isValidRealName]) {
        NSMutableString * resString = [NSMutableString stringWithString:self];
        NSRange range = NSMakeRange(0, 1);
        [resString stringByReplacingCharactersInRange:range withString:@"*"];
        return resString;
    }
    return nil;
}

#pragma mark - 银行卡号中间8位*显示
- (NSString *)kx_secrectBlankCard {
    if ([self kx_isValidBankCardNumber]) {
        NSMutableString * resString = [NSMutableString stringWithString:self];
        NSRange range = NSMakeRange(4, 8);
        [resString stringByReplacingCharactersInRange:range withString:@" **** **** "];
        return resString;
    }
    return nil;
}

#pragma mark - 计算文字高度
- (CGFloat)kx_heightWithFont:(UIFont *)font width:(CGFloat)width {
    NSDictionary * attributes = @{NSFontAttributeName: font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return ceil(size.height);
}

#pragma mark - 计算文字宽度
- (CGFloat)kx_widthWithFont:(UIFont *)font height:(CGFloat)height {
    NSDictionary * attributes = @{NSFontAttributeName: font};
    CGSize size = [self boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, height) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    return ceil(size.width);
}

#pragma mark - 突出特定位置的文字
- (NSMutableAttributedString *)kx_mutableCharacters:(UIColor *)color font:(UIFont *)font withRange:(NSRange)range {
    NSMutableAttributedString * mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:self];
    [mutableAttributedString addAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:font} range:range];
    return mutableAttributedString;
}

#pragma mark - 突出所有数字
- (NSMutableAttributedString *)kx_mutableAllNumber:(UIColor *)color font:(UIFont *)font {
    NSMutableAttributedString * mutableAttributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSArray * numbsers = @[@"0", @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9"];
    for (NSInteger i = 0; i < mutableAttributedString.length; i ++) {
        NSRange range = NSMakeRange(i, 1);
        NSString * string = [self substringWithRange:range];
        if ([numbsers containsObject:string]) {
            [mutableAttributedString addAttributes:@{NSForegroundColorAttributeName:color, NSFontAttributeName:font} range:range];
        }
    }
    return mutableAttributedString;
}

#pragma mark - 添加删除线
- (NSMutableString *)kx_addStrikeLineWithcolor:(UIColor *)color {
    NSMutableAttributedString *attributString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attributes = @{
                                 NSStrikethroughStyleAttributeName: @(NSUnderlineStyleSingle),
                                 NSStrokeColorAttributeName: color ? color : [UIColor blackColor]
                                 };
    [attributString addAttributes:attributes range:NSMakeRange(0, [self length])];
    return [attributString copy];
}

#pragma mark - 添加下划线
- (NSMutableString *)kx_addUnderLineWithcolor:(UIColor *)color {
    NSMutableAttributedString *attributString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attributes = @{
                                 NSUnderlineStyleAttributeName: @(NSUnderlineStyleSingle),
                                 NSStrokeColorAttributeName: color ? color : [UIColor blackColor]
                                 };
    [attributString addAttributes:attributes range:NSMakeRange(0, [self length])];
    return [attributString copy];
}

#pragma mark - md5
- (NSString *)kx_md5 {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_MD5_DIGEST_LENGTH];
    CC_MD5(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_MD5_DIGEST_LENGTH];
}

#pragma mark - sha1
- (NSString *)kx_sha1 {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA1_DIGEST_LENGTH];
}

#pragma mark - sha256
- (NSString *)kx_sha256 {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA256_DIGEST_LENGTH];
}

#pragma mark - sha512
- (NSString *)kx_sha512 {
    const char *string = self.UTF8String;
    int length = (int)strlen(string);
    unsigned char bytes[CC_SHA512_DIGEST_LENGTH];
    CC_SHA512(string, length, bytes);
    return [self stringFromBytes:bytes length:CC_SHA512_DIGEST_LENGTH];
}

#pragma mark - 加密通用方法
- (NSString *)stringFromBytes:(unsigned char *)bytes length:(int)length
{
    NSMutableString *mutableString = @"".mutableCopy;
    for (int i = 0; i < length; i++)
        [mutableString appendFormat:@"%02x", bytes[i]];
    return [NSString stringWithString:mutableString];
}

#pragma mark - 利用AES加密数据
- (NSString *)kx_encryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv {
    NSData * encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] kx_encryptedWithAESUsingKey:key andIV:iv];
    return [encrypted base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark - 利用AES解密据
- (NSString *)kx_decryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv {
    NSData * decrypted = [[[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters] kx_decryptedWithAESUsingKey:key andIV:iv];
    return [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
}

#pragma mark - 利用DES加密数据
- (NSString *)kx_encryptedWithDESUsingKey:(NSString *)key andIV:(NSData *)iv{
    NSData * encrypted = [[self dataUsingEncoding:NSUTF8StringEncoding] kx_encryptedWithDESUsingKey:key andIV:iv];
    return [encrypted base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
}

#pragma mark - 利用DES解密数据
- (NSString *)kx_decryptedWithDESUsingKey:(NSString *)key andIV:(NSData *)iv{
    NSData * decrypted = [[[NSData alloc] initWithBase64EncodedString:self options:NSDataBase64DecodingIgnoreUnknownCharacters] kx_decryptedWithDESUsingKey:key andIV:iv];
    return [[NSString alloc] initWithData:decrypted encoding:NSUTF8StringEncoding];
}

@end
