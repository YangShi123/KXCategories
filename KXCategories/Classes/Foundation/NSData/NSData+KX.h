
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (KX)

/*=================================DATA HASH=================================*/

/// 返回结果：32长度(128位，16字节，16进制字符输出则为32字节长度)
- (NSData *)kx_md5;

/// 返回结果：40长度
- (NSData *)kx_sha1;

/// 返回结果：64长度
- (NSData *)kx_sha256;

/// 返回结果：128长度
- (NSData *)kx_sha512;

/*=================================DATA 加解密=================================*/

/// AES加密数据
/// @param key  key 长度一般为16（AES算法所能支持的密钥长度可以为128,192,256位（也即16，24，32个字节））
/// @param iv  iv
- (NSData *)kx_encryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;

/// AES解密数据
/// @param key key 长度一般为16
/// @param iv  iv
- (NSData *)kx_decryptedWithAESUsingKey:(NSString *)key andIV:(NSData *)iv;

/// DES加密数据
/// @param key key 长度一般为8
/// @param iv  iv
- (NSData *)kx_encryptedWithDESUsingKey:(NSString *)key andIV:(NSData *)iv;

/// DES解密数据
/// @param key key 长度一般为8
/// @param iv  iv
- (NSData *)kx_decryptedWithDESUsingKey:(NSString *)key andIV:(NSData *)iv;

@end

NS_ASSUME_NONNULL_END
