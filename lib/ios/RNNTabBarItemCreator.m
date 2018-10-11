#import "RNNTabBarItemCreator.h"
#import <React/RCTConvert.h>
#import "UIImage+tint.h"

@implementation RNNTabBarItemCreator

+ (UITabBarItem *)updateTabBarItem:(UITabBarItem *)tabItem bottomTabOptions:(RNNBottomTabOptions *)bottomTabOptions {
	tabItem.selectedImage = [self getSelectedIconImage:[bottomTabOptions.selectedIcon getWithDefaultValue:nil] selectedIconColor:[bottomTabOptions.selectedIconColor getWithDefaultValue:nil]];
	tabItem.image = [self getIconImage:[bottomTabOptions.icon getWithDefaultValue:nil] withTint:[bottomTabOptions.iconColor getWithDefaultValue:nil]];
	tabItem.title = [bottomTabOptions.text getWithDefaultValue:@""];
	tabItem.tag = bottomTabOptions.tag;
	tabItem.accessibilityIdentifier = [bottomTabOptions.testID getWithDefaultValue:nil];
	
	NSDictionary* iconInsets = [bottomTabOptions.iconInsets getWithDefaultValue:nil];
	if (iconInsets && ![iconInsets isKindOfClass:[NSNull class]]) {
		id topInset = iconInsets[@"top"];
		id leftInset = iconInsets[@"left"];
		id bottomInset = iconInsets[@"bottom"];
		id rightInset = iconInsets[@"right"];
		
		CGFloat top = topInset != (id)[NSNull null] ? [RCTConvert CGFloat:topInset] : 0;
		CGFloat left = topInset != (id)[NSNull null] ? [RCTConvert CGFloat:leftInset] : 0;
		CGFloat bottom = topInset != (id)[NSNull null] ? [RCTConvert CGFloat:bottomInset] : 0;
		CGFloat right = topInset != (id)[NSNull null] ? [RCTConvert CGFloat:rightInset] : 0;
		
		tabItem.imageInsets = UIEdgeInsetsMake(top, left, bottom, right);
	}
	
	
	
	[self appendTitleAttributes:tabItem textColor:[bottomTabOptions.textColor getWithDefaultValue:nil] selectedTextColor:[bottomTabOptions.selectedTextColor getWithDefaultValue:nil] fontFamily:[bottomTabOptions.fontFamily getWithDefaultValue:nil] fontSize:[bottomTabOptions.fontSize getWithDefaultValue:nil]];
	
	return tabItem;
}

+ (UIImage *)getSelectedIconImage:(NSDictionary *)selectedIcon selectedIconColor:(NSDictionary *)selectedIconColor {
	if (selectedIcon) {
		if (selectedIconColor) {
			return [[[RCTConvert UIImage:selectedIcon] withTintColor:[RCTConvert UIColor:selectedIconColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		} else {
			return [[RCTConvert UIImage:selectedIcon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		}
	} else {
		return [self getIconImage:selectedIconColor withTint:selectedIconColor];
	}
	
	return nil;
}

+ (UIImage *)getIconImage:(NSDictionary *)icon withTint:(NSDictionary *)tintColor {
	if (icon) {
		if (tintColor) {
			return [[[RCTConvert UIImage:icon] withTintColor:[RCTConvert UIColor:tintColor]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		} else {
			return [[RCTConvert UIImage:icon] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
		}
	}
	
	return nil;
}

+ (void)appendTitleAttributes:(UITabBarItem *)tabItem textColor:(NSDictionary *)textColor selectedTextColor:(NSDictionary *)selectedTextColor fontFamily:(NSString *)fontFamily fontSize:(NSNumber *)fontSize {
	NSMutableDictionary* selectedAttributes = [NSMutableDictionary dictionaryWithDictionary:[tabItem titleTextAttributesForState:UIControlStateNormal]];
	if (selectedTextColor) {
		selectedAttributes[NSForegroundColorAttributeName] = [RCTConvert UIColor:selectedTextColor];
	} else {
		selectedAttributes[NSForegroundColorAttributeName] = [UIColor blackColor];
	}
	
	selectedAttributes[NSFontAttributeName] = [self tabBarTextFont:fontFamily fontSize:fontSize];
	[tabItem setTitleTextAttributes:selectedAttributes forState:UIControlStateSelected];
	
	
	NSMutableDictionary* normalAttributes = [NSMutableDictionary dictionaryWithDictionary:[tabItem titleTextAttributesForState:UIControlStateNormal]];
	if (textColor) {
		normalAttributes[NSForegroundColorAttributeName] = [RCTConvert UIColor:textColor];
	} else {
		normalAttributes[NSForegroundColorAttributeName] = [UIColor blackColor];
	}
	
	normalAttributes[NSFontAttributeName] = [self tabBarTextFont:fontFamily fontSize:fontSize];
	[tabItem setTitleTextAttributes:normalAttributes forState:UIControlStateNormal];
}

+(UIFont *)tabBarTextFont:(NSString *)fontFamily fontSize:(NSNumber *)fontSize {
	if (fontFamily) {
		return [UIFont fontWithName:fontFamily size:[self fontSize:fontSize]];
	}
	else if (fontSize) {
		return [UIFont systemFontOfSize:[self fontSize:fontSize]];
	}
	else {
		return nil;
	}
}

+ (CGFloat)fontSize:(NSNumber *)fontSize {
	return fontSize ? [fontSize floatValue] : 10;
}

@end