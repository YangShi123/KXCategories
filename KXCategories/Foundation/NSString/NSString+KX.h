
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (KX)

/*=================================字符串验证=================================*/

/// 有效的手机号（简单）
- (BOOL)kx_isValidMobileNumber;

/// 有效的身份证号（精确）
- (BOOL)kx_isIdCardNumber;

/// 有效的真实姓名（2-8位中文）
- (BOOL)kx_isValidRealName;

/// 有效的验证码
/// @param length 验证码位数
- (BOOL)kx_isValidVerifyCode:(NSInteger)length;

/// 有效的银行卡号（精确-未实际验证）
- (BOOL)kx_isValidBankCardNumber;

/// 有效的邮箱（精确）
- (BOOL)kx_isValidEmail;

/// 是否只有中文
- (BOOL)kx_isValidChinese;

/// 是否是纯数字
- (BOOL)kx_isOnlyNumber;

/// 是否为空字符串
- (BOOL)kx_isEmpty;

/*=================================字符串隐藏=================================*/

/// 手机号中间4位*显示
- (NSString *)kx_secrectMobile;

/// 姓*显示
- (NSString *)kx_secrectRealName;

/// 银行卡号中间8位*显示
- (NSString *)kx_secrectBlankCard;

/*=================================字符串宽高=================================*/

/// 计算文字高度
/// @param font 字体
/// @param width 约束宽度
- (CGFloat)kx_heightWithFont:(UIFont *)font width:(CGFloat)width;

/// 计算文字宽度
/// @param font 字体
/// @param height 约束高度
- (CGFloat)kx_widthWithFont:(UIFont *)font height:(CGFloat)height;

/*=================================字符串多变=================================*/

/// 突出特定位置的文字
/// @param color 文字颜色
/// @param font 文字字体
/// @param range 范围
- (NSMutableAttributedString *)kx_mutableCharacters:(UIColor *)color font:(UIFont *)font withRange:(NSRange)range;

/// 突出所有数字
/// @param color 数字颜色
/// @param font 数字字体
- (NSMutableAttributedString *)kx_mutableAllNumber:(UIColor *)color font:(UIFont *)font;

/// 添加删除线
/// @param color 颜色
- (NSMutableString *)kx_addStrikeLineWithcolor:(nullable UIColor *)color;

/// 添加下划线
/// @param color 颜色
- (NSMutableString *)kx_addUnderLineWithcolor:(nullable UIColor *)color;

/*=================================字符串HASH=================================*/

/// 返回结果：32长度(128位，16字节，16进制字符输出则为32字节长度)   终端命令：md5 -s "123"
- (NSString *)kx_md5;

/// 返回结果：40长度   终端命令：echo -n "123" | openssl sha -sha1
- (NSString *)kx_sha1;

/// 返回结果：64长度   终端命令：echo -n "123" | openssl sha -sha256
- (NSString *)kx_sha256;

/// 返回结果：128长度   终端命令：echo -n "123" | openssl sha -sha512
- (NSString *)kx_sha512;

/*=================================字符串加解密=================================*/

/// AES加密数据
/// @param key  key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
/// @param iv  iv
- (NSString *)kx_encryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;

/// AES解密数据
/// @param key key 长度一般为16
/// @param iv  iv
- (NSString *)kx_decryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;

/// DES加密数据
/// @param key key 长度一般为8
/// @param iv  iv
- (NSString *)kx_encryptedWithDESUsingKey:(NSString *)key andIV:(NSData *)iv;

/// DES解密数据
/// @param key key 长度一般为8
/// @param iv  iv
- (NSString *)kx_decryptedWithDESUsingKey:(NSString *)key andIV:(NSData *)iv;

@end

NS_ASSUME_NONNULL_END
