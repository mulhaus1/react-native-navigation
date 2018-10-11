#import "RNNBottomTabOptions.h"
#import "UIImage+tint.h"
#import "UITabBarController+RNNOptions.h"
#import "UIViewController+RNNOptions.h"
#import "RNNTabBarItemCreator.h"

@implementation RNNBottomTabOptions

- (instancetype)initWithDict:(NSDictionary *)dict {
	self = [super init];
	
	self.text = [StringParser parse:dict key:@"text"];
	self.badge = [StringParser parse:dict key:@"badge"];
	self.fontFamily = [StringParser parse:dict key:@"fontFamily"];
	self.testID = [StringParser parse:dict key:@"testID"];
	
	
	self.badgeColor = [DictionaryParser parse:dict key:@"badgeColor"];
	self.icon = [DictionaryParser parse:dict key:@"icon"];
	self.selectedIcon = [DictionaryParser parse:dict key:@"selectedIcon"];
	self.iconColor = [DictionaryParser parse:dict key:@"iconColor"];
	self.selectedIconColor = [DictionaryParser parse:dict key:@"selectedIconColor"];
	self.selectedTextColor = [DictionaryParser parse:dict key:@"selectedTextColor"];
	self.iconInsets = [DictionaryParser parse:dict key:@"iconInsets"];
	
	self.textColor = [NumberParser parse:dict key:@"textColor"];
	self.fontSize = [NumberParser parse:dict key:@"fontSize"];
	self.visible = [BoolParser parse:dict key:@"visible"];
	
	return self;
}

-(void)resetOptions {
	self.text = nil;
	self.badge = nil;
	self.visible = nil;
	self.icon = nil;
	self.testID = nil;
	self.iconInsets = nil;
	self.selectedIcon = nil;
}

@end
