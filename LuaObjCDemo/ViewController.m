//
//  ViewController.m
//  LuaObjCDemo
//
//  Created by 王亚静 on 2017/7/7.
//  Copyright © 2017年 Wong. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
{
    lua_State *lua_s;
}
@end

@implementation ViewController

- (IBAction)doLuaFile:(id)sender {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"extension" ofType:@"lua"];
    int result = luaL_dofile(lua_s, [filePath UTF8String]);
    NSLog(@"%d", result);
}
- (IBAction)doLuaString:(id)sender {
    int result = luaL_dostring(lua_s, [@"print('World')" UTF8String]);
    NSLog(@"%d", result);
}

- (void)openFileIO:(lua_State *)lua {
    lua_openfilelibs(lua);
}

static int isExist(lua_State *lua) {
    NSLog(@"isExist");
    return 0;
}

static const struct luaL_reg filelibs [] = {
    {"isExist", isExist},
    {NULL, NULL}
};

int lua_openfilelibs(lua_State *lua) {
    luaL_register(lua,"file",filelibs);
    return 0;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    lua_s = luaL_newstate();
    luaL_openlibs(lua_s);
    [self openFileIO:lua_s];
    
    // Do any additional setup after loading the view, typically from a nib.
}

@end
