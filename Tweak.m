#import <UIKit/UIKit.h>
#import <libactivator/libactivator.h>

@interface HIActiHastebin : NSObject <LAListener>
@end

@implementation HIActiHastebin
- (void)activator:(LAActivator *)activator receiveEvent:(LAEvent *)event {
    @autoreleasepool {
        UIPasteboard *pasteboard = UIPasteboard.generalPasteboard;
        NSString *pasteContent = pasteboard.string;
        if (!pasteContent) {
            return;
        }
        
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://hastebin.com/documents"]];
        request.HTTPMethod = @"POST";
        request.HTTPBody = [pasteContent dataUsingEncoding:NSUTF8StringEncoding];
        
        [[NSURLSession.sharedSession dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
            if (!data || error) {
                return;
            }
            
            NSDictionary *hastebin = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
            NSString *hastebinKey = hastebin[@"key"];
            if (hastebinKey) {
                pasteboard.string = [@"https://hastebin.com/" stringByAppendingString:hastebinKey];
            }
        }] resume];
    }
}

+ (void)load {
    @autoreleasepool {
        [LASharedActivator registerListener:self.new forName:@"com.ipadkid.actihastebin"];
    }
}

@end
